import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import '../../data/api/assistant_api.dart';
import '../../data/models/labels.dart';

/// One row in the chat.
sealed class ChatItem {
  const ChatItem();
}

class ChatText extends ChatItem {
  ChatText(this.text, {required this.fromUser, this.pending = false});
  String text;
  final bool fromUser;
  bool pending;
}

class ChatRedFlag extends ChatItem {
  const ChatRedFlag(this.type, {required this.crisis});
  final EmergencyType type;
  final bool crisis;

  String get title =>
      crisis ? 'Please get help now' : 'This may be an emergency';
  String get message => crisis
      ? 'Call 112 or talk to someone you trust. You can also find the '
            'nearest hospital now.'
      : 'Find a hospital that can take you now (${type.label.toLowerCase()}).';
}

typedef ConversationRow = ({
  int id,
  String title,
  String updated,
  bool selected,
});

class AssistantViewModel extends ReactiveViewModel {
  AssistantViewModel({
    AssistantApi? api,
    SessionService? session,
    EmergencySessionService? emergency,
    LocationService? location,
    NavigationService? navigation,
    PhoneCallService? calls,
    SnackbarService? snackbar,
    DialogService? dialogs,
  }) : _api = api ?? assistantApi,
       _session = session ?? sessionService,
       _emergency = emergency ?? emergencySession,
       _location = location ?? locationService,
       _navigation = navigation ?? navigationService,
       _calls = calls ?? phoneCallService,
       _snackbar = snackbar ?? snackbarService,
       _dialogs = dialogs ?? dialogService;

  final AssistantApi _api;
  final SessionService _session;
  final EmergencySessionService _emergency;
  final LocationService _location;
  final NavigationService _navigation;
  final PhoneCallService _calls;
  final SnackbarService _snackbar;
  final DialogService _dialogs;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  final inputController = TextEditingController();
  final scrollController = ScrollController();

  final List<ChatItem> _items = [];
  List<AiConversation> _conversations = const [];
  int? _conversationId;
  StreamSubscription<ChatEvent>? _reply;

  static const title = 'Health Assistant';
  static const disclaimer =
      'General health information only. Not a diagnosis or prescription. '
      'In an emergency, call 112.';
  static const emptyHint =
      'Ask a general health question, for example "What should I do for a '
      'mild fever?"';
  static const signedOutTitle = 'Sign in to use the Health Assistant';
  static const signedOutMessage =
      'Your conversations are private and you can delete them at any time.';

  bool get isSignedIn => _session.isSignedIn;
  bool get isReplying => _reply != null;
  bool get isEmpty => _items.isEmpty;
  List<ChatItem> get items => _items;

  List<ConversationRow> get conversations => [
    for (final c in _conversations)
      (
        id: c.id!,
        title: c.title,
        updated: Formatters.ago(c.updatedAt, DateTime.now().toUtc()),
        selected: c.id == _conversationId,
      ),
  ];
  bool get hasConversations => _conversations.isNotEmpty;

  VoidCallback? get onSend => isReplying ? null : send;

  Future<void> onReady() async {
    if (!isSignedIn) return;
    await loadConversations();
  }

  Future<void> loadConversations() async {
    final response = await _api.conversations();
    if (response.success) _conversations = response.data!;
    notifyListeners();
  }

  void signIn() => _navigation.pushNamed<void>(
    AppRoutes.signInWithNext(AppRoutes.assistant),
  );

  void newConversation() {
    unawaited(_reply?.cancel());
    _reply = null;
    _conversationId = null;
    _items.clear();
    notifyListeners();
  }

  Future<void> openConversation(int id) async {
    await _reply?.cancel();
    _reply = null;
    final response = await runBusyFuture(_api.messages(id));
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    _conversationId = id;
    _items.clear();
    for (final m in response.data!) {
      if (m.role == ChatRole.assistant &&
          m.redFlagDetected &&
          m.suggestedEmergencyType != null) {
        _items.add(ChatRedFlag(m.suggestedEmergencyType!, crisis: false));
      }
      _items.add(ChatText(m.content, fromUser: m.role == ChatRole.user));
    }
    notifyListeners();
    _scrollToEnd();
  }

  void send() {
    final text = inputController.text.trim();
    if (text.isEmpty || isReplying) return;
    inputController.clear();
    final pending = ChatText('', fromUser: false, pending: true);
    _items
      ..add(ChatText(text, fromUser: true))
      ..add(pending);
    notifyListeners();
    _scrollToEnd();

    _reply = _api
        .send(text, conversationId: _conversationId)
        .listen(
          (event) => _onEvent(event, pending),
          onError: (Object error) {
            pending
              ..text = ErrorMessages.describe(error).message
              ..pending = false;
            _finish();
          },
          onDone: () {
            pending.pending = false;
            _finish();
          },
        );
  }

  void _onEvent(ChatEvent event, ChatText pending) {
    switch (event.kind) {
      case ChatEventKind.started:
        _conversationId = event.conversationId;
      case ChatEventKind.delta:
        pending.text += event.text ?? '';
      case ChatEventKind.redFlag:
        _items.insert(
          _items.indexOf(pending),
          ChatRedFlag(
            event.emergencyType ?? EmergencyType.other,
            crisis: event.crisis ?? false,
          ),
        );
      case ChatEventKind.error:
        pending.text = event.text ?? ErrorMessages.generic;
      case ChatEventKind.done:
        pending.pending = false;
    }
    notifyListeners();
    _scrollToEnd();
  }

  void _finish() {
    _reply = null;
    notifyListeners();
    unawaited(loadConversations());
  }

  /// Opens the Emergency flow with the type already chosen.
  void findCare(EmergencyType type) {
    _emergency.begin(_location.current());
    _emergency.setType(type);
    _navigation.pushNamed<void>(AppRoutes.emergency, args: type);
  }

  void startEmergency() {
    _emergency.begin(_location.current());
    _navigation.pushNamed<void>(AppRoutes.emergency);
  }

  Future<void> call112() => _calls.callNumber(number: '112', title: 'Call 112');

  Future<void> deleteConversation(int id) async {
    final ok = await _dialogs.confirm(
      title: 'Delete this conversation?',
      message: 'It will be removed permanently.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!ok) return;
    final response = await _api.delete(id);
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    if (_conversationId == id) newConversation();
    await loadConversations();
  }

  Future<void> deleteAll() async {
    final ok = await _dialogs.confirm(
      title: 'Delete all conversations?',
      message: 'Your whole Health Assistant history will be removed.',
      confirmLabel: 'Delete all',
      destructive: true,
    );
    if (!ok) return;
    final response = await _api.deleteAll();
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    newConversation();
    await loadConversations();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _reply?.cancel();
    inputController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
