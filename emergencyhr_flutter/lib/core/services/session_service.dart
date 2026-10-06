import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../data/api/api_response.dart';
import '../../data/api/auth_api.dart';
import '../../data/models/shell_kind.dart';

/// Who is signed in and what they may open. Viewmodels listen to it through
/// `ReactiveViewModel.listenableServices` and rebuild when it changes.
class SessionService with ListenableServiceMixin {
  SessionService(this._api);

  final AuthApi _api;

  CurrentUser? _currentUser;
  int? _activeFacilityId;
  bool _initialised = false;
  Completer<void>? _loading;

  CurrentUser? get currentUser => _currentUser;
  bool get isSignedIn => _api.isSignedIn;
  bool get isInitialised => _initialised;

  Set<UserRole> get roles => {
    for (final r in _currentUser?.roles ?? const <RoleAssignment>[]) r.role,
  };

  bool hasAnyRole(Set<UserRole> wanted) => roles.any(wanted.contains);

  bool canOpen(ShellKind shell) =>
      shell == ShellKind.public || (isSignedIn && hasAnyRole(shell.roles));

  /// Shells this user can open, public first.
  List<ShellKind> get availableShells =>
      ShellKind.values.where(canOpen).toList();

  /// The shell to land in after sign-in: the most specific staff shell.
  ShellKind get preferredShell {
    for (final shell in [ShellKind.admin, ShellKind.agent, ShellKind.desk]) {
      if (canOpen(shell)) return shell;
    }
    return ShellKind.public;
  }

  /// Facilities where the user holds one of [wanted].
  List<FacilitySummary> facilitiesFor(Set<UserRole> wanted) {
    final ids = {
      for (final r in _currentUser?.roles ?? const <RoleAssignment>[])
        if (wanted.contains(r.role) && r.facilityId != null) r.facilityId!,
    };
    return [
      for (final f in _currentUser?.facilities ?? const <FacilitySummary>[])
        if (ids.contains(f.id)) f,
    ];
  }

  bool hasFacilityRole(int facilityId, Set<UserRole> wanted) =>
      (_currentUser?.roles ?? const <RoleAssignment>[]).any(
        (r) => r.facilityId == facilityId && wanted.contains(r.role),
      );

  /// The facility a desk user is working on.
  int? get activeFacilityId {
    final desk = facilitiesFor(ShellKind.desk.roles);
    if (desk.any((f) => f.id == _activeFacilityId)) return _activeFacilityId;
    return desk.isEmpty ? null : desk.first.id;
  }

  void selectFacility(int facilityId) {
    _activeFacilityId = facilityId;
    notifyListeners();
  }

  Future<void> init() async {
    _api.authChanges.addListener(_onAuthChanged);
    if (isSignedIn) await refresh();
    _initialised = true;
    notifyListeners();
  }

  /// Waits for the first load so guards do not bounce a signed-in user.
  Future<void> ready() async {
    if (_initialised) return;
    await _loading?.future;
  }

  Future<ApiResponse<CurrentUser>> refresh() async {
    final loading = _loading = Completer<void>();
    final response = await _api.me();
    if (response.success) {
      _currentUser = response.data;
    } else if (!isSignedIn) {
      _currentUser = null;
    }
    loading.complete();
    notifyListeners();
    return response;
  }

  /// Applies a server response that already contains the updated user.
  void update(CurrentUser user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _api.signOut();
    _currentUser = null;
    _activeFacilityId = null;
    notifyListeners();
  }

  void _onAuthChanged() {
    if (!isSignedIn) {
      _currentUser = null;
      notifyListeners();
    } else if (_currentUser == null) {
      unawaited(refresh());
    }
  }
}
