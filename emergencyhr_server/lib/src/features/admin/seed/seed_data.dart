import '../../../generated/protocol.dart';

/// Fictional pilot data for Lagos. Names are clearly fictional.
abstract final class SeedData {
  static const areas = <String, (double, double)>{
    'Ikeja': (6.6018, 3.3515),
    'Yaba': (6.5095, 3.3711),
    'Surulere': (6.4969, 3.3481),
    'Lekki': (6.4474, 3.4723),
    'Victoria Island': (6.4281, 3.4219),
    'Ikorodu': (6.6194, 3.5105),
  };

  static const agentAAreas = ['Ikeja', 'Yaba', 'Ikorodu'];
  static const agentBAreas = ['Surulere', 'Lekki', 'Victoria Island'];

  /// Password for every demo account (development only).
  static const demoPassword = 'Emergency123!';

  /// Demo accounts: (phone, email). Sign in with the email and
  /// [demoPassword]. The phone numbers are kept so WhatsApp quick updates and
  /// reminders can be tried with the dev adapters.
  static const accounts = {
    platformAdminPhone: 'admin@emergencyhr.test',
    agentAPhone: 'agent.ikeja@emergencyhr.test',
    agentBPhone: 'agent.lekki@emergencyhr.test',
    hospitalAdmin01Phone: 'admin01@emergencyhr.test',
    hospitalAdmin02Phone: 'admin02@emergencyhr.test',
    desk01Phone: 'desk01@emergencyhr.test',
    desk02Phone: 'desk02@emergencyhr.test',
    desk03Phone: 'desk03@emergencyhr.test',
    publicUserPhone: 'public@emergencyhr.test',
  };

  // Account phone numbers.
  static const platformAdminPhone = '+2348000000001';
  static const agentAPhone = '+2348000000002';
  static const agentBPhone = '+2348000000003';
  static const hospitalAdmin01Phone = '+2348000000004';
  static const hospitalAdmin02Phone = '+2348000000005';
  static const desk01Phone = '+2348000000006';
  static const desk02Phone = '+2348000000007';
  static const desk03Phone = '+2348000000008';
  static const publicUserPhone = '+2348000000010';

  /// Minutes since the last status update, per seed number. Null = no status.
  static int? statusAgeMinutes(int n) => switch (n) {
    1 => 4,
    2 => 12,
    3 => 8,
    4 => 20,
    5 => 26,
    6 => 15,
    7 => 45,
    8 => 75,
    9 => 110,
    10 => 180,
    11 => 400,
    12 => 10,
    13 => 6,
    14 => 3 * 24 * 60,
    _ => null,
  };

  static OnboardingStage stage(int n) => switch (n) {
    <= 14 => OnboardingStage.live,
    <= 18 => OnboardingStage.verified,
    <= 21 => OnboardingStage.staffTrained,
    <= 24 => OnboardingStage.visited,
    <= 26 => OnboardingStage.contacted,
    <= 28 => OnboardingStage.seeded,
    29 => OnboardingStage.paused,
    _ => OnboardingStage.declined,
  };

  static VerificationStatus verification(int n) => switch (n) {
    <= 18 => VerificationStatus.verified,
    19 || 20 => VerificationStatus.pending,
    _ => VerificationStatus.seeded,
  };

  static bool accepting(int n) => n != 12;
  static bool flagged(int n) => n == 13;

  /// Live in its first week and quiet for days.
  static bool quietNewcomer(int n) => n == 14;

  static FacilityType type(int n) => switch (n % 3) {
    0 => FacilityType.public,
    1 => FacilityType.private,
    _ => FacilityType.mission,
  };

  static List<Capability> capabilities(int n) {
    final set = <Capability>{Capability.generalEmergency, Capability.oxygen};
    if ({1, 3, 5, 7, 10, 15, 22}.contains(n)) set.add(Capability.trauma);
    if ({2, 6, 8, 16}.contains(n)) set.add(Capability.obstetrics);
    if ({2, 4, 9, 17}.contains(n)) set.add(Capability.paediatrics);
    if ({4, 6, 11}.contains(n)) set.add(Capability.cardiac);
    if ({5, 10}.contains(n)) set.add(Capability.burns);
    if ({1, 4, 6, 8}.contains(n)) set.add(Capability.icu);
    if ({1, 3, 5, 7}.contains(n)) set.add(Capability.theatre);
    if ({1, 5}.contains(n)) set.add(Capability.bloodBank);
    if ({3, 7}.contains(n)) set.add(Capability.ambulance);
    if (n == 9) set.remove(Capability.oxygen);
    return set.toList();
  }

  static OpeningHours openingHours(int n) => n % 4 == 0
      ? OpeningHours(
          alwaysOpen: false,
          periods: [
            for (var day = 1; day <= 6; day++)
              OpeningPeriod(
                weekday: day,
                openMinute: 8 * 60,
                closeMinute: 20 * 60,
              ),
          ],
        )
      : OpeningHours(alwaysOpen: true, periods: []);

  static String areaFor(int n) => areas.keys.elementAt((n - 1) % areas.length);

  /// Spreads facilities within about 3 km of the area centre.
  static (double, double) coordinates(int n) {
    final (lat, lng) = areas[areaFor(n)]!;
    final ring = (n - 1) ~/ areas.length;
    final dLat = [0.004, -0.009, 0.013, -0.016, 0.021][ring % 5];
    final dLng = [0.006, 0.011, -0.008, -0.014, 0.003][ring % 5];
    return (lat + dLat, lng + dLng);
  }

  static String name(int n) =>
      'Seed Hospital ${n.toString().padLeft(2, '0')}, ${areaFor(n)}';

  static String deskPhone(int n) =>
      '+23481000000${n.toString().padLeft(2, '0')}';
}
