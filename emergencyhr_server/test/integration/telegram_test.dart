import 'package:emergencyhr_server/src/core/app_config.dart';
import 'package:emergencyhr_server/src/features/telegram/logic/bot_actions.dart';
import 'package:emergencyhr_server/src/features/telegram/logic/bot_copy.dart';
import 'package:emergencyhr_server/src/features/telegram/logic/bot_message.dart';
import 'package:emergencyhr_server/src/features/telegram/telegram_bot_service.dart';
import 'package:emergencyhr_server/src/features/telegram/telegram_gateway.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart' hide NotAuthorizedException;
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

/// Keeps what the bot sent instead of calling Telegram.
class CapturingTelegramGateway implements TelegramGateway {
  final sent = <BotMessage>[];
  final toasts = <String?>[];

  BotMessage get last => sent.last;

  @override
  Future<void> send(Session session, int chatId, BotMessage message) async =>
      sent.add(message);

  @override
  Future<void> edit(
    Session session,
    int chatId,
    int messageId,
    BotMessage message,
  ) async => sent.add(message);

  @override
  Future<void> answerTap(Session session, String tapId, {String? text}) async =>
      toasts.add(text);
}

Map<String, dynamic> _text(int fromId, String text) => {
  'message': {
    'message_id': 1,
    'from': {'id': fromId},
    'chat': {'id': fromId, 'type': 'private'},
    'text': text,
  },
};

Map<String, dynamic> _location(int fromId, double lat, double lng) => {
  'message': {
    'message_id': 1,
    'from': {'id': fromId},
    'chat': {'id': fromId, 'type': 'private'},
    'location': {'latitude': lat, 'longitude': lng},
  },
};

Map<String, dynamic> _tap(int fromId, String data) => {
  'callback_query': {
    'id': 'tap',
    'from': {'id': fromId},
    'data': data,
    'message': {
      'message_id': 9,
      'chat': {'id': fromId, 'type': 'private'},
    },
  },
};

void main() {
  late CapturingTelegramGateway gateway;
  setUp(() {
    TelegramGateway.override = gateway = CapturingTelegramGateway();
    AppConfig.instance = AppConfig(
      telegramAdapter: AdapterKind.dev,
      telegramBotUsername: 'EmergencyHrBot',
    );
  });
  tearDown(() {
    TelegramGateway.override = null;
    AppConfig.instance = AppConfig();
  });
  const bot = TelegramBotService();

  withServerpod(
    'Given the Telegram bot',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test(
        'when someone shares a location then nearby hospitals are listed',
        () async {
          await createFacility(
            sessionBuilder,
            name: 'Telegram Search Hospital',
            area: 'Telegram Town',
            lat: 9.3001,
            lng: 7.2001,
          );
          final session = sessionBuilder.build();
          await bot.handle(session, _location(5001, 9.3, 7.2));
          expect(gateway.last.text, contains('Telegram Search Hospital'));
          expect(gateway.last.text, contains('112'));

          await bot.handle(session, _tap(5001, 't:burns:9.30000:7.20000'));
          expect(gateway.last.text, contains('Burns'));
        },
      );

      test('when a group chat writes then the bot stays quiet', () async {
        final session = sessionBuilder.build();
        await bot.handle(session, {
          'message': {
            'message_id': 1,
            'from': {'id': 5002},
            'chat': {'id': -100, 'type': 'group'},
            'text': '/start',
          },
        });
        expect(gateway.sent, isEmpty);
      });

      test(
        'when staff connect from the app then they can update status, and '
        'the link works only once',
        () async {
          final facility = await createFacility(
            sessionBuilder,
            name: 'Telegram Desk Hospital',
            area: 'Telegram Town',
            lat: 9.31,
            lng: 7.21,
          );
          final desk = await createUser(
            sessionBuilder,
            phone: '+2348039990001',
            roles: [(UserRole.deskStaff, facility.id)],
          );
          final link = await endpoints.telegram.createLink(desk.session);
          expect(link, startsWith('https://t.me/EmergencyHrBot?start=link_'));
          final code = Uri.parse(link).queryParameters['start']!;

          final session = sessionBuilder.build();
          await bot.handle(session, _text(6001, '/start $code'));
          expect(gateway.last.text, startsWith('Connected'));
          expect(
            (await endpoints.telegram.connection(desk.session)).connected,
            isTrue,
          );

          // Another Telegram account cannot reuse the link.
          await bot.handle(session, _text(6002, '/start $code'));
          expect(gateway.last.text, BotCopy.linkInvalid);

          await bot.handle(session, _text(6001, BotCopy.updateStatus));
          expect(gateway.last.text, contains('Telegram Desk Hospital'));
          expect(gateway.last.text, contains('No status sent yet'));

          final draft = StatusDraft(
            facilityId: facility.id!,
            accepting: true,
            erBeds: 4,
            icuBeds: 1,
          );
          await bot.handle(session, _tap(6001, draft.saveData));
          expect(gateway.toasts.last, 'Status updated');
          final saved = await FacilityStatus.db.findFirstRow(
            session,
            where: (t) => t.facilityId.equals(facility.id!),
          );
          expect(saved!.erBedsFree, 4);
          expect(saved.updatedByUserId, desk.user.id);

          await bot.handle(session, _tap(6001, 'c:${facility.id}'));
          expect(gateway.toasts.last, 'Confirmed');

          // A stranger's tap with the same data changes nothing.
          await bot.handle(
            session,
            _tap(6003, draft.copyWith(accepting: false).saveData),
          );
          expect(gateway.last.text, BotCopy.notStaff);
          final after = await FacilityStatus.db.findFirstRow(
            session,
            where: (t) => t.facilityId.equals(facility.id!),
          );
          expect(after!.accepting, isTrue);

          await endpoints.telegram.disconnect(desk.session);
          await bot.handle(session, _tap(6001, draft.saveData));
          expect(gateway.last.text, BotCopy.notStaff);
        },
      );

      test(
        'when someone who is not hospital staff asks for a link then denied',
        () async {
          final user = await createUser(
            sessionBuilder,
            phone: '+2348039990002',
          );
          await expectLater(
            endpoints.telegram.createLink(user.session),
            throwsA(isA<NotAuthorizedException>()),
          );
        },
      );
    },
  );
}
