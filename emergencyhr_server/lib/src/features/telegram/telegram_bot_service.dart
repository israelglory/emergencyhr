import 'dart:convert';
import 'dart:math';

import 'package:serverpod/serverpod.dart' hide NotAuthorizedException;

import '../../core/app_config.dart';
import '../../core/auth_guard.dart';
import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';
import '../auth/account_service.dart';
import '../auth/otp_codes.dart';
import '../auth/otp_service.dart';
import '../emergency/emergency_service.dart';
import '../status/status_service.dart';
import 'logic/bot_actions.dart';
import 'logic/bot_copy.dart';
import 'logic/bot_message.dart';
import 'telegram_gateway.dart';

/// The Telegram bot. Anyone can search for hospitals; staff who connected
/// their account from the app can update their hospital's status. Nothing
/// about public users (messages, locations) is stored or logged.
class TelegramBotService {
  const TelegramBotService({
    this.emergency = const EmergencyService(),
    this.status = const StatusService(),
  });

  final EmergencyService emergency;
  final StatusService status;

  static const linkTtl = Duration(minutes: 15);
  static const _linkPrefix = 'link_';
  static final _random = Random.secure();

  static String _hash(Session session, String code) =>
      OtpCodes.hash(code, 'telegram-link', OtpService.pepper(session));

  // Linking from the app

  /// A one-time "Connect Telegram" link for a staff member.
  Future<String> createLink(Session session, AppUser user) async {
    final username = AppConfig.instance.telegramBotUsername;
    if (AppConfig.instance.telegramAdapter == AdapterKind.off ||
        username == null) {
      throw Errors.featureDisabled();
    }
    final code = base64Url
        .encode(List<int>.generate(24, (_) => _random.nextInt(256)))
        .replaceAll('=', '');
    await TelegramLinkCode.db.insertRow(
      session,
      TelegramLinkCode(
        userId: user.id!,
        codeHash: _hash(session, code),
        expiresAt: clock.now().add(linkTtl),
      ),
    );
    return 'https://t.me/$username?start=$_linkPrefix$code';
  }

  Future<TelegramConnection> connection(Session session, AppUser user) async {
    final config = AppConfig.instance;
    final link = await TelegramLink.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    return TelegramConnection(
      enabled:
          config.telegramAdapter != AdapterKind.off &&
          config.telegramBotUsername != null,
      connected: link != null,
      botUsername: config.telegramBotUsername,
    );
  }

  Future<void> disconnect(Session session, AppUser user) async {
    await TelegramLink.db.deleteWhere(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
  }

  // Updates from Telegram

  /// Handles one update from the webhook. Only private chats are answered.
  Future<void> handle(Session session, Map<String, dynamic> update) async {
    final gateway = TelegramGateway.of(session);
    final message = update['message'];
    final tap = update['callback_query'];
    if (message is Map<String, dynamic>) {
      final chat = message['chat'] as Map<String, dynamic>? ?? const {};
      final from = message['from'] as Map<String, dynamic>? ?? const {};
      if (chat['type'] != 'private') return;
      final chatId = chat['id'] as int;
      final fromId = from['id'] as int;
      final reply = await _onMessage(session, message, chatId, fromId);
      if (reply != null) await gateway.send(session, chatId, reply);
    } else if (tap is Map<String, dynamic>) {
      final tapId = tap['id'].toString();
      final from = tap['from'] as Map<String, dynamic>? ?? const {};
      final original = tap['message'] as Map<String, dynamic>?;
      final chatId = (original?['chat'] as Map?)?['id'] as int?;
      final messageId = original?['message_id'] as int?;
      final action = BotAction.parse(tap['data']?.toString() ?? '');
      if (chatId == null || messageId == null || action == null) {
        await gateway.answerTap(session, tapId);
        return;
      }
      final result = await _onTap(session, action, from['id'] as int);
      await gateway.answerTap(session, tapId, text: result.toast);
      final reply = result.message;
      if (reply == null) return;
      if (result.replace) {
        await gateway.edit(session, chatId, messageId, reply);
      } else {
        await gateway.send(session, chatId, reply);
      }
    }
  }

  Future<BotMessage?> _onMessage(
    Session session,
    Map<String, dynamic> message,
    int chatId,
    int fromId,
  ) async {
    final location = message['location'];
    if (location is Map) {
      final lat = (location['latitude'] as num).toDouble();
      final lng = (location['longitude'] as num).toDouble();
      return _search(session, lat: lat, lng: lng, type: EmergencyType.skipped);
    }
    final text = (message['text'] as String? ?? '').trim();
    if (text.startsWith('/start $_linkPrefix')) {
      return _link(
        session,
        code: text.substring('/start $_linkPrefix'.length).trim(),
        fromId: fromId,
        chatId: chatId,
      );
    }
    if (text == BotCopy.pickArea || text == '/area') {
      return BotCopy.areaPicker();
    }
    if (text == BotCopy.updateStatus || text == '/status') {
      return _openStatus(session, fromId);
    }
    if (text == '/disconnect') {
      await TelegramLink.db.deleteWhere(
        session,
        where: (t) => t.telegramUserId.equals(fromId),
      );
      return BotCopy.disconnected();
    }
    final staff = await _staffUser(session, fromId) != null;
    return BotCopy.welcome(staff: staff);
  }

  Future<({BotMessage? message, bool replace, String? toast})> _onTap(
    Session session,
    BotAction action,
    int fromId,
  ) async {
    switch (action) {
      case Noop():
        return (message: null, replace: false, toast: null);
      case PickArea(:final index):
        if (index < 0 || index >= BotCopy.areas.length) {
          return (message: null, replace: false, toast: null);
        }
        final area = BotCopy.areas[index];
        return (
          message: await _search(
            session,
            lat: area.lat,
            lng: area.lng,
            type: EmergencyType.skipped,
            areaName: area.name,
          ),
          replace: false,
          toast: null,
        );
      case FilterType(:final type, :final lat, :final lng):
        if (!_inNigeria(lat, lng)) {
          return (message: null, replace: false, toast: null);
        }
        return (
          message: await _search(
            session,
            lat: lat,
            lng: lng,
            type: type,
            areaName: _areaAt(lat, lng),
          ),
          replace: true,
          toast: null,
        );
      case OpenPanel(:final facilityId):
        return _staffPanel(session, fromId, facilityId);
      case EditDraft(:final draft):
        return _staffPanel(session, fromId, draft.facilityId, draft: draft);
      case SaveDraft(:final draft):
        return _save(session, fromId, draft);
      case ConfirmStatus(:final facilityId):
        return _confirm(session, fromId, facilityId);
    }
  }

  static bool _inNigeria(double lat, double lng) =>
      lat >= 4 && lat <= 14 && lng >= 2.5 && lng <= 15;

  /// The area name when [lat], [lng] is an area centre from the picker.
  static String? _areaAt(double lat, double lng) {
    for (final a in BotCopy.areas) {
      if ((a.lat - lat).abs() < 0.00001 && (a.lng - lng).abs() < 0.00001) {
        return a.name;
      }
    }
    return null;
  }

  Future<BotMessage> _search(
    Session session, {
    required double lat,
    required double lng,
    required EmergencyType type,
    String? areaName,
  }) async {
    if (!_inNigeria(lat, lng)) {
      return const BotMessage(
        'EmergencyHr covers hospitals in Nigeria. Tap Pick my area to '
        'choose a place.',
      );
    }
    final ranked = await emergency.rankNear(
      session,
      lat: lat,
      lng: lng,
      type: type,
    );
    final nearest = areaName ?? _areaAt(lat, lng);
    return BotCopy.results(
      ranked: ranked.results,
      showCall112: _noAccepting(ranked.results),
      type: type,
      lat: lat,
      lng: lng,
      now: clock.now(),
      areaName: nearest,
    );
  }

  static bool _noAccepting(List<EmergencyResult> results) =>
      !results.any((r) => r.freshness == FreshnessTier.fresh);

  // Staff

  /// The connected, active staff member behind a Telegram account.
  Future<AppUser?> _staffUser(Session session, int fromId) async {
    final link = await TelegramLink.db.findFirstRow(
      session,
      where: (t) => t.telegramUserId.equals(fromId),
    );
    if (link == null) return null;
    final user = await AppUser.db.findById(session, link.userId);
    if (user == null || user.suspendedAt != null) return null;
    return user;
  }

  Future<List<Facility>> _staffFacilities(Session session, AppUser user) async {
    final roles = await AuthGuard.rolesOf(session, user.id!);
    final ids = {
      for (final r in roles)
        if (AuthGuard.staff.contains(r.role)) ?r.facilityId,
    };
    if (ids.isEmpty) return const [];
    return Facility.db.find(
      session,
      where: (t) => t.id.inSet(ids),
      orderBy: (t) => t.name,
    );
  }

  Future<BotMessage> _openStatus(Session session, int fromId) async {
    final user = await _staffUser(session, fromId);
    if (user == null) return const BotMessage(BotCopy.notStaff);
    final facilities = await _staffFacilities(session, user);
    if (facilities.isEmpty) return const BotMessage(BotCopy.notStaff);
    if (facilities.length > 1) return BotCopy.facilityPicker(facilities);
    final f = facilities.single;
    final saved = await status.current(session, f.id!);
    return BotCopy.panel(
      facility: f,
      saved: saved,
      draft: StatusDraft.from(f.id!, saved),
      now: clock.now(),
    );
  }

  /// The staff member and facility for a tap, after checking they still
  /// work there.
  Future<({AppUser user, Facility facility})?> _authorize(
    Session session,
    int fromId,
    int facilityId,
  ) async {
    final user = await _staffUser(session, fromId);
    if (user == null) return null;
    final allowed = await AuthGuard.hasRole(
      session,
      user,
      AuthGuard.staff,
      facilityId: facilityId,
    );
    if (!allowed) return null;
    final facility = await Facility.db.findById(session, facilityId);
    if (facility == null) return null;
    return (user: user, facility: facility);
  }

  static const _denied = (
    message: BotMessage(BotCopy.notStaff),
    replace: false,
    toast: null,
  );

  Future<({BotMessage? message, bool replace, String? toast})> _staffPanel(
    Session session,
    int fromId,
    int facilityId, {
    StatusDraft? draft,
    String? notice,
    String? toast,
  }) async {
    final access = await _authorize(session, fromId, facilityId);
    if (access == null) return _denied;
    final saved = await status.current(session, facilityId);
    return (
      message: BotCopy.panel(
        facility: access.facility,
        saved: saved,
        draft: draft ?? StatusDraft.from(facilityId, saved),
        now: clock.now(),
        notice: notice,
      ),
      replace: true,
      toast: toast,
    );
  }

  Future<({BotMessage? message, bool replace, String? toast})> _save(
    Session session,
    int fromId,
    StatusDraft draft,
  ) async {
    final access = await _authorize(session, fromId, draft.facilityId);
    if (access == null) return _denied;
    final saved = await status.current(session, draft.facilityId);
    try {
      await status.update(
        session,
        facility: access.facility,
        user: access.user,
        input: StatusInput(
          accepting: draft.accepting,
          erBedsFree: draft.erBeds,
          icuBedsFree: draft.icuBeds,
          doctorOnDuty: saved?.doctorOnDuty ?? true,
          depositRequired: saved?.depositRequired ?? false,
        ),
      );
    } on SerializableException catch (e) {
      return (
        message: BotMessage(_errorText(e)),
        replace: false,
        toast: null,
      );
    }
    return _staffPanel(
      session,
      fromId,
      draft.facilityId,
      notice: '✅ Status updated.',
      toast: 'Status updated',
    );
  }

  Future<({BotMessage? message, bool replace, String? toast})> _confirm(
    Session session,
    int fromId,
    int facilityId,
  ) async {
    final access = await _authorize(session, fromId, facilityId);
    if (access == null) return _denied;
    try {
      await status.confirm(
        session,
        facility: access.facility,
        user: access.user,
      );
    } on SerializableException catch (e) {
      return (
        message: BotMessage(_errorText(e)),
        replace: false,
        toast: null,
      );
    }
    return _staffPanel(
      session,
      fromId,
      facilityId,
      notice: '✅ Confirmed. Thank you.',
      toast: 'Confirmed',
    );
  }

  static String _errorText(SerializableException e) => BotMessage.escape(
    switch (e) {
      InvalidStateException(:final message) => message,
      ValidationException(:final message) => message,
      NotAuthorizedException(:final message) => message,
      NotFoundException(:final message) => message,
      ConflictException(:final message) => message,
      RateLimitedException(:final message) => message,
      _ => 'That update could not be saved. Please use the app.',
    },
  );

  Future<BotMessage> _link(
    Session session, {
    required String code,
    required int fromId,
    required int chatId,
  }) async {
    if (code.isEmpty) return const BotMessage(BotCopy.linkInvalid);
    final now = clock.now();
    final row = await TelegramLinkCode.db.findFirstRow(
      session,
      where: (t) => t.codeHash.equals(_hash(session, code)),
    );
    if (row == null || row.usedAt != null || !row.expiresAt.isAfter(now)) {
      return const BotMessage(BotCopy.linkInvalid);
    }
    final user = await AppUser.db.findById(session, row.userId);
    if (user == null || user.suspendedAt != null) {
      return const BotMessage(BotCopy.linkInvalid);
    }
    await session.db.transaction((tx) async {
      await TelegramLinkCode.db.updateRow(
        session,
        row.copyWith(usedAt: now),
        transaction: tx,
      );
      // One Telegram account per person, and one person per Telegram
      // account: replace any earlier connection on either side.
      await TelegramLink.db.deleteWhere(
        session,
        where: (t) =>
            t.userId.equals(user.id!) | t.telegramUserId.equals(fromId),
        transaction: tx,
      );
      await TelegramLink.db.insertRow(
        session,
        TelegramLink(
          userId: user.id!,
          telegramUserId: fromId,
          chatId: chatId,
          linkedAt: now,
        ),
        transaction: tx,
      );
    });
    return BotCopy.linked(AccountService.displayName(user));
  }
}
