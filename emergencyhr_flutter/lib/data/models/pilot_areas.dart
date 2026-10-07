/// A pilot area with its centre, used by the area picker and forms.
class PilotArea {
  const PilotArea(this.name, this.lat, this.lng, {this.description});

  final String name;
  final double lat;
  final double lng;
  final String? description;
}

abstract final class PilotAreas {
  static const all = [
    PilotArea(
      'Ikeja',
      6.6018,
      3.3515,
      description: 'Allen, Opebi, Alausa',
    ),
    PilotArea(
      'Yaba',
      6.5095,
      3.3711,
      description: 'Sabo, Akoka, Ebute Metta',
    ),
    PilotArea(
      'Surulere',
      6.4969,
      3.3481,
      description: 'Ojuelegba, Masha',
    ),
    PilotArea(
      'Lekki',
      6.4474,
      3.4723,
      description: 'Phase 1, Ikate, Ajah',
    ),
    PilotArea(
      'Victoria Island',
      6.4281,
      3.4219,
      description: 'Ikoyi, Obalende',
    ),
    PilotArea(
      'Ikorodu',
      6.6194,
      3.5105,
      description: 'Town, Ijede, Igbogbo',
    ),
    // Oyo State. Its Surulere LGA is listed under Ogbomoso so it is not
    // confused with Surulere, Lagos.
    PilotArea(
      'Ogbomoso',
      8.1335,
      4.2410,
      description: 'Ogbomoso North, Ogbomoso South, Ori Ire, Ogo Oluwa',
    ),
  ];

  static List<String> get names => [for (final a in all) a.name];

  /// The pilot area whose centre is closest, for the Home location line.
  static PilotArea nearest(double lat, double lng) {
    double d(PilotArea a) =>
        (a.lat - lat) * (a.lat - lat) + (a.lng - lng) * (a.lng - lng);
    return all.reduce((a, b) => d(a) <= d(b) ? a : b);
  }
}
