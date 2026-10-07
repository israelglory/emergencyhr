import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/facility_api.dart';
import '../../../data/models/route_args.dart';

typedef ListingRow = ({int id, String name, String address});

/// Path B: a hospital searches for its listing first, then claims it or
/// creates a new one. Duplicates are blocked by the server.
class JoinHospitalViewModel extends BaseViewModel {
  JoinHospitalViewModel({
    FacilityApi? api,
    SessionService? session,
    NavigationService? navigation,
  }) : _api = api ?? locator<FacilityApi>(),
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService;

  final FacilityApi _api;
  final SessionService _session;
  final NavigationService _navigation;

  final searchController = TextEditingController();
  Timer? _debounce;
  List<FacilitySearchResult> _results = const [];
  bool _searched = false;

  static const title = 'For hospitals';
  static const heading = 'Join EmergencyHr';
  static const intro =
      'Hospitals on EmergencyHr publish whether they can take emergencies '
      'right now. Start by finding your hospital. It may already be listed.';

  bool get showResults => _searched;
  bool get noResults => _searched && _results.isEmpty && !isBusy;

  List<ListingRow> get results => [
    for (final r in _results)
      (id: r.facility.id, name: r.facility.name, address: r.address),
  ];

  void onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () => _search(value));
  }

  Future<void> _search(String query) async {
    if (query.trim().length < 2) return;
    final response = await runBusyFuture(_api.search(query.trim()));
    _searched = true;
    _results = response.data ?? const [];
    notifyListeners();
  }

  Future<void> claim(ListingRow row) => _requireSignIn(
    AppRoutes.claim(row.id),
    ClaimArgs(facilityId: row.id, name: row.name),
  );

  Future<void> createNew() => _requireSignIn(
    AppRoutes.facilityNew,
    FacilityEditorArgs(name: searchController.text.trim()),
  );

  void sendJoinRequest() => _navigation.pushNamed<void>(AppRoutes.joinRequest);

  Future<void> _requireSignIn(String route, Object args) async {
    if (!_session.isSignedIn) {
      await _navigation.pushNamed<void>(AppRoutes.signInWithNext(route));
      return;
    }
    await _navigation.pushNamed<void>(route, args: args);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
