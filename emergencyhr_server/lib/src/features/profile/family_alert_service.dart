import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/errors.dart';
import '../../generated/protocol.dart';
import '../notifications/notifier.dart';
import 'profile_service.dart';

/// Tells up to three emergency contacts where the user is heading.
class FamilyAlertService {
  FamilyAlertService({this.profile = const ProfileService()});

  final ProfileService profile;

  final _limiter = DatabaseRateLimiter(
    RateLimiterConfig(
      domain: 'family',
      source: 'user',
      maxAttempts: 5,
      timeframe: const Duration(hours: 1),
    ),
  );

  static Uri mapsLink(double lat, double lng) =>
      Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': '$lat,$lng',
      });

  static String message({
    required String name,
    required String? hospital,
    required double lat,
    required double lng,
  }) {
    final where = hospital == null
        ? 'is getting emergency help'
        : 'is heading to $hospital';
    return '$name may be having a medical emergency and $where. '
        'Location: ${mapsLink(lat, lng)}. Sent via Emergencyhr.';
  }

  Future<FamilyAlertResult> notify(
    Session session, {
    required AppUser user,
    required EmergencySession emergencySession,
  }) async {
    final contacts = await profile.contacts(session, user);
    if (contacts.isEmpty) {
      throw Errors.invalidState('Add an emergency contact in your profile.');
    }
    if (!await _limiter.tryRecordAttempt(session, key: '${user.id}')) {
      throw Errors.rateLimited();
    }
    final facility = emergencySession.facilityId == null
        ? null
        : await Facility.db.findById(session, emergencySession.facilityId!);
    final text = message(
      name: user.name ?? 'Your contact',
      hospital: facility?.name,
      lat: facility?.lat ?? emergencySession.lat,
      lng: facility?.lng ?? emergencySession.lng,
    );
    final results = <ContactAlertResult>[];
    for (final c in contacts.take(ProfileService.maxContacts)) {
      final via = c.channel == ContactChannel.whatsapp
          ? await Notifier.whatsAppOrSms(
              session,
              to: c.phone,
              message: text,
              kind: 'family_alert',
            )
          : (await Notifier.sms(
                  session,
                  to: c.phone,
                  message: text,
                  kind: 'family_alert',
                )
                ? ContactChannel.sms
                : null);
      results.add(
        ContactAlertResult(name: c.name, phone: c.phone, sentVia: via),
      );
    }
    return FamilyAlertResult(message: text, results: results);
  }
}
