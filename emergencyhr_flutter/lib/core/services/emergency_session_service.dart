import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

/// State shared by the emergency screens: when Emergency was tapped, the
/// location request in flight, the "What happened" filter, the chosen area,
/// the server session and the hospital acted on.
class EmergencySessionService with ListenableServiceMixin {
  DateTime? _tappedAt;
  Future<Object?>? _location;
  EmergencyType _type = EmergencyType.skipped;
  String? _area;
  EmergencySearch? _search;
  EmergencyResult? _actedOn;
  EmergencyAction? _action;

  DateTime? get tappedAt => _tappedAt;
  EmergencyType get type => _type;

  /// The pilot area picked instead of the device location.
  String? get area => _area;
  EmergencySearch? get search => _search;
  EmergencyResult? get actedOn => _actedOn;
  EmergencyAction? get action => _action;

  /// A pending location lookup started when Emergency was tapped.
  Future<Object?>? get pendingLocation => _location;

  /// Starts a new emergency. Every Emergency button calls this before
  /// opening Hospitals near you. [type] is set when another screen already
  /// knows what happened (Health Assistant).
  void begin(
    Future<Object?> location, {
    EmergencyType type = EmergencyType.skipped,
  }) {
    _tappedAt = DateTime.now().toUtc();
    _location = location;
    _type = type;
    _area = null;
    _search = null;
    _actedOn = null;
    _action = null;
  }

  void setType(EmergencyType type) => _type = type;

  void setArea(String? area) => _area = area;

  void setSearch(EmergencySearch search) {
    _search = search;
    notifyListeners();
  }

  /// While a new ranking loads after the filter or area changed.
  void clearSearch() {
    _search = null;
    notifyListeners();
  }

  void setActed(EmergencyResult? result, EmergencyAction action) {
    _actedOn = result;
    _action = action;
    notifyListeners();
  }
}
