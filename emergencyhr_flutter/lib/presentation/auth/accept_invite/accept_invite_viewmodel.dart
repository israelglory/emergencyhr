import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/staff_api.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/shell_kind.dart';

enum InviteScreenState { loading, notFound, valid, unusable }

/// Opened from an invite link or QR code (`/invite/<code>`).
class AcceptInviteViewModel extends ReactiveViewModel {
  AcceptInviteViewModel({
    required this.code,
    StaffApi? api,
    SessionService? session,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _api = api ?? locator<StaffApi>(),
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  final String code;
  final StaffApi _api;
  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  InvitePreview? _preview;

  static const _acceptKey = 'accept';

  InviteScreenState get state => hasError
      ? InviteScreenState.notFound
      : _preview == null
      ? InviteScreenState.loading
      : _preview!.valid
      ? InviteScreenState.valid
      : InviteScreenState.unusable;
  String? get errorMessage => modelError?.toString();
  bool get isValid => _preview?.valid ?? false;
  bool get isSignedIn => _session.isSignedIn;
  bool get isAccepting => busy(_acceptKey);

  String get heading => 'Join ${_preview?.facilityName ?? ''}';
  String get message => isValid
      ? 'You have been invited as ${_preview!.role.label.toLowerCase()}. '
            'Invite expires ${Formatters.date(_preview!.expiresAt)}.'
      : '${_preview?.reason ?? ''} Ask the hospital admin to send you a new '
            'one.';

  static const unusableTitle = 'This invite cannot be used';
  static const notFoundTitle = 'Invite not found';
  static const notFoundMessage = 'Check the link or code and try again.';

  /// Role and inviter for the details card.
  List<({String label, String value})> get details => [
    if (_preview case final p?) (label: 'Role', value: p.role.label),
    if (_preview?.invitedBy case final name?)
      (label: 'Invited by', value: name),
  ];
  String get actionLabel => isSignedIn ? 'Accept invite' : 'Sign in to accept';

  Future<void> load() async {
    final response = await runBusyFuture(_api.previewInvite(code));
    if (response.success) {
      _preview = response.data;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> accept() async {
    if (!isSignedIn) {
      await _navigation.pushNamed<void>(
        AppRoutes.signInWithNext(AppRoutes.invite(code)),
      );
      return;
    }
    final response = await runBusyFuture(
      _api.acceptInvite(code),
      busyObject: _acceptKey,
    );
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    await _session.refresh();
    final facilityId = response.data!.facilityId;
    if (facilityId != null) _session.selectFacility(facilityId);
    _snackbar.success(message: 'Welcome. You can now update this hospital.');
    await _navigation.clearStackAndShow<void>(
      AppRoutes.forShell(ShellKind.desk),
    );
  }

  void goHome() => _navigation.clearStackAndShow<void>(AppRoutes.home);
}
