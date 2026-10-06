import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

/// State shared by the emergency screens: when Emergency was tapped, the
/// location request in flight, the chosen type, the server session and the
/// hospital acted on.
class EmergencySessionService with ListenableServiceMixin {
  DateTime? _tappedAt;
  Future<Object?>? _location;
  EmergencyType _type = EmergencyType.skipped;
  EmergencySearch? _search;
  EmergencyResult? _actedOn;
  EmergencyAction? _action;

  DateTime? get tappedAt => _tappedAt;
  EmergencyType get type => _type;
  EmergencySearch? get search => _search;
  EmergencyResult? get actedOn => _actedOn;
  EmergencyAction? get action => _action;

  /// A pending location lookup started when Emergency was tapped.
  Future<Object?>? get pendingLocation => _location;

  void begin(Future<Object?> location) {
    _tappedAt = DateTime.now().toUtc();
    _location = location;
    _type = EmergencyType.skipped;
    _search = null;
    _actedOn = null;
    _action = null;
  }

  void setType(EmergencyType type) => _type = type;

  void setSearch(EmergencySearch search) {
    _search = search;
    notifyListeners();
  }

  void setActed(EmergencyResult? result, EmergencyAction action) {
    _actedOn = result;
    _action = action;
    notifyListeners();
  }
}
