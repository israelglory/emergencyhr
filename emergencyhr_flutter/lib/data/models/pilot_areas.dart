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
      description: 'Ikeja, Allen, Opebi, Alausa',
    ),
    PilotArea(
      'Yaba',
      6.5095,
      3.3711,
      description: 'Yaba, Sabo, Akoka, Ebute Metta',
    ),
    PilotArea(
      'Surulere',
      6.4969,
      3.3481,
      description: 'Surulere, Ojuelegba, Masha',
    ),
    PilotArea(
      'Lekki',
      6.4474,
      3.4723,
      description: 'Lekki Phase 1, Ikate, Ajah',
    ),
    PilotArea(
      'Victoria Island',
      6.4281,
      3.4219,
      description: 'Victoria Island, Ikoyi, Obalende',
    ),
    PilotArea(
      'Ikorodu',
      6.6194,
      3.5105,
      description: 'Ikorodu town, Ijede, Igbogbo',
    ),
  ];

  static List<String> get names => [for (final a in all) a.name];
}
