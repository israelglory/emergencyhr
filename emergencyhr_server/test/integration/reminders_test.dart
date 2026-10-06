import 'package:emergencyhr_server/src/core/app_config.dart';
import 'package:emergencyhr_server/src/features/notifications/messaging.dart';
import 'package:emergencyhr_server/src/features/notifications/reminder_service.dart';
import 'package:emergencyhr_server/src/features/notifications/whatsapp_gateway.dart';
import 'package:emergencyhr_server/src/features/status/quick_update_service.dart';
import 'package:emergencyhr_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart' show Session;
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

class _CapturingWhatsApp implements WhatsAppGateway {
  final sent = <String>[];

  @override
  Future<bool> send(
    Session session, {
    required String to,
    required String message,
  }) async {
    sent.add(to);
    return true;
  }
}

void main() {
  group('Given ReminderService.needsStaleReminder', () {
    final now = DateTime.utc(2026, 10, 5, 10); // Monday 11:00 Lagos
    FacilityStatus status(int minutes) => FacilityStatus(
      facilityId: 1,
      accepting: true,
      erBedsFree: 1,
      icuBedsFree: 0,
      doctorOnDuty: true,
      depositRequired: false,
      updatedAt: now.subtract(Duration(minutes: minutes)),
    );
    final alwaysOpen = OpeningHours(alwaysOpen: true, periods: []);
    final closedNow = OpeningHours(
      alwaysOpen: false,
      periods: [OpeningPeriod(weekday: 2, openMinute: 480, closeMinute: 1200)],
    );

    test('when 61 minutes old and open then remind', () {
      expect(
        ReminderService.needsStaleReminder(
          status: status(61),
          hours: alwaysOpen,
          now: now,
        ),
        isTrue,
      );
    });

    test('when 30 minutes old then do not remind', () {
      expect(
        ReminderService.needsStaleReminder(
          status: status(30),
          hours: alwaysOpen,
          now: now,
        ),
        isFalse,
      );
    });

    test('when closed now then do not remind', () {
      expect(
        ReminderService.needsStaleReminder(
          status: status(200),
          hours: closedNow,
          now: now,
        ),
        isFalse,
      );
    });
  });

  late _CapturingWhatsApp whatsApp;
  setUp(() {
    Messaging.smsOverride = CapturingSmsGateway();
    Messaging.whatsAppOverride = whatsApp = _CapturingWhatsApp();
  });
  tearDown(() {
    Messaging.smsOverride = null;
    Messaging.whatsAppOverride = null;
    AppConfig.instance = AppConfig(whatsappQuickUpdate: true);
  });

  withServerpod(
    'Given stale reminders and quick updates',
    rollbackDatabase: RollbackDatabase.disabled,
    (sessionBuilder, endpoints) {
      setUpAuthServices();

      test('when a live status is stale then desk staff are reminded once an '
          'hour, not on every run', () async {
        final f = await createFacility(sessionBuilder, name: 'Seed Stale One');
        await Facility.db.updateRow(
          sessionBuilder.build(),
          f.copyWith(openingHours: OpeningHours(alwaysOpen: true, periods: [])),
        );
        await FacilityStatus.db.insertRow(
          sessionBuilder.build(),
          FacilityStatus(
            facilityId: f.id!,
            accepting: true,
            erBedsFree: 1,
            icuBedsFree: 0,
            doctorOnDuty: true,
            depositRequired: false,
            updatedAt: DateTime.now().toUtc().subtract(
              const Duration(minutes: 90),
            ),
          ),
        );
        await createUser(
          sessionBuilder,
          phone: '+2348039990001',
          roles: [(UserRole.deskStaff, f.id)],
        );
        const service = ReminderService();
        await service.sendStaleReminders(sessionBuilder.build());
        await service.sendStaleReminders(sessionBuilder.build());
        expect(whatsApp.sent.where((p) => p == '+2348039990001'), hasLength(1));
      });

      test('when desk staff text P then the facility is paused', () async {
        AppConfig.instance = AppConfig(whatsappQuickUpdate: true);
        final f = await createFacility(sessionBuilder, name: 'Seed Quick One');
        await createUser(
          sessionBuilder,
          phone: '+2348039990002',
          roles: [(UserRole.deskStaff, f.id)],
        );
        final reply = await const QuickUpdateService().handle(
          sessionBuilder.build(),
          fromPhone: '2348039990002',
          text: ' p ',
        );
        expect(reply, contains('paused'));
        final status = await FacilityStatus.db.findFirstRow(
          sessionBuilder.build(),
          where: (t) => t.facilityId.equals(f.id!),
        );
        expect(status!.accepting, isFalse);
      });

      test('when an unknown number texts then nothing changes', () async {
        AppConfig.instance = AppConfig(whatsappQuickUpdate: true);
        final reply = await const QuickUpdateService().handle(
          sessionBuilder.build(),
          fromPhone: '2348039990999',
          text: 'A',
        );
        expect(reply, contains('not registered'));
      });

      test('when the flag is off then quick updates are refused', () async {
        AppConfig.instance = AppConfig(whatsappQuickUpdate: false);
        final reply = await const QuickUpdateService().handle(
          sessionBuilder.build(),
          fromPhone: '2348039990002',
          text: 'A',
        );
        expect(reply, contains('not switched on'));
      });
    },
  );
}
