import 'package:serverpod/serverpod.dart';

import '../../core/app_config.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';
import 'status_service.dart';

/// WhatsApp quick update: registered staff text A (accepting), P (paused) or
/// C (confirm still accurate). Behind the `whatsappQuickUpdate` flag.
class QuickUpdateService {
  const QuickUpdateService({this.status = const StatusService()});

  final StatusService status;

  static const help =
      'EmergencyHr quick update: reply A for accepting, P for paused, or C '
      'to confirm your status is still accurate.';

  /// Returns the reply to send back.
  Future<String> handle(
    Session session, {
    required String fromPhone,
    required String text,
  }) async {
    if (!AppConfig.instance.whatsappQuickUpdate) {
      return 'Quick updates are not switched on yet. Please use the app.';
    }
    final String phone;
    try {
      phone = Validate.phone(
        fromPhone.startsWith('+') ? fromPhone : '+$fromPhone',
      );
    } catch (_) {
      return help;
    }
    final code = text.trim().toUpperCase();
    if (!{'A', 'P', 'C'}.contains(code)) return help;

    final user = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.phone.equals(phone),
    );
    if (user == null || user.suspendedAt != null) {
      return 'This number is not registered as hospital staff on EmergencyHr.';
    }
    final roles = await RoleAssignment.db.find(
      session,
      where: (t) =>
          t.userId.equals(user.id!) &
          t.role.inSet(<UserRole>{UserRole.deskStaff, UserRole.hospitalAdmin}),
    );
    final facilityIds = {for (final r in roles) ?r.facilityId};
    if (facilityIds.isEmpty) {
      return 'This number is not registered as hospital staff on EmergencyHr.';
    }
    if (facilityIds.length > 1) {
      return 'You work at more than one hospital. Please update in the app.';
    }
    final facility = await Facility.db.findById(session, facilityIds.single);
    if (facility == null) return help;

    final current = await status.current(session, facility.id!);
    try {
      if (code == 'C') {
        if (current == null) {
          return 'No status yet for ${facility.name}. Send A or P first.';
        }
        await status.confirm(session, facility: facility, user: user);
        return 'Thank you. ${facility.name} is confirmed as still accurate.';
      }
      await status.update(
        session,
        facility: facility,
        user: user,
        input: StatusInput(
          accepting: code == 'A',
          erBedsFree: current?.erBedsFree ?? 0,
          icuBedsFree: current?.icuBedsFree ?? 0,
          doctorOnDuty: current?.doctorOnDuty ?? true,
          depositRequired: current?.depositRequired ?? false,
        ),
      );
      return code == 'A'
          ? '${facility.name} is now shown as accepting. Update beds in the app.'
          : '${facility.name} is now shown as paused.';
    } on SerializableException {
      return 'That update could not be saved. Please use the app.';
    }
  }
}
