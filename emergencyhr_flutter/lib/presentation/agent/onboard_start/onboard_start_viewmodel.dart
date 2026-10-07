import 'dart:async';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/facility_api.dart';
import '../../../data/api/onboarding_api.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/route_args.dart';

typedef NearbyRow = ({
  int id,
  String name,
  String detail,
  OnboardingStage stage,
});

/// Step 1 of field onboarding: find the hospital the agent is standing in.
class OnboardStartViewModel extends BaseViewModel {
  OnboardStartViewModel({
    FacilityApi? facilities,
    OnboardingApi? onboarding,
    LocationService? location,
    NavigationService? navigation,
    SnackbarService? snackbar,
  }) : _facilities = facilities ?? locator<FacilityApi>(),
       _onboarding = onboarding ?? locator<OnboardingApi>(),
       _location = location ?? locationService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService;

  final FacilityApi _facilities;
  final OnboardingApi _onboarding;
  final LocationService _location;
  final NavigationService _navigation;
  final SnackbarService _snackbar;

  final searchController = TextEditingController();
  Timer? _debounce;

  double? _lat;
  double? _lng;
  List<FacilitySearchResult> _results = const [];
  bool _searched = false;
  String? _locationProblem;

  static const _locateKey = 'locate';

  static const intro =
      'Stand at the emergency desk and find the listing. If it is not there, '
      'create one.';
  static const pickHint =
      'Picking a seeded or contacted hospital marks it as Visited.';

  bool get isLocating => busy(_locateKey);
  bool get isSearching => isBusy && !isLocating;
  String? get locationProblem => _locationProblem;
  bool get showResults => _searched;
  bool get noResults => _searched && _results.isEmpty;
  String get resultsTitle => _lat != null && searchController.text.isEmpty
      ? 'Within 300 m of you'
      : 'Search results';

  List<NearbyRow> get results => [
    for (final r in _results)
      (
        id: r.facility.id,
        name: r.facility.name,
        detail: [
          r.address,
          if (r.distanceMeters != null)
            Formatters.distanceKm(r.distanceMeters! / 1000),
          r.facility.onboardingStage.label,
        ].join(' · '),
        stage: r.facility.onboardingStage,
      ),
  ];

  Future<void> imAtTheHospital() async {
    _locationProblem = null;
    final result = await runBusyFuture(
      _location.current(),
      busyObject: _locateKey,
    );
    switch (result) {
      case LocationFound(:final lat, :final lng):
        _lat = lat;
        _lng = lng;
        searchController.clear();
        final response = await runBusyFuture(_facilities.nearby(lat, lng));
        _searched = true;
        if (response.success) {
          _results = response.data!;
        } else {
          _snackbar.error(message: response.message!);
        }
      case LocationDenied():
        _locationProblem =
            'Location is off. Search by name below, or allow location.';
      case LocationUnavailable():
        _locationProblem = 'Could not get your location. Search by name below.';
    }
    notifyListeners();
  }

  void onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () => _search(value));
  }

  Future<void> _search(String query) async {
    if (query.trim().length < 2) return;
    final response = await runBusyFuture(_facilities.search(query.trim()));
    _searched = true;
    if (response.success) _results = response.data!;
    notifyListeners();
  }

  /// Opens the facility and records that the agent is on site.
  Future<void> pick(NearbyRow row) async {
    if (row.stage == OnboardingStage.seeded ||
        row.stage == OnboardingStage.contacted) {
      await runBusyFuture(
        _onboarding.setStage(
          row.id,
          OnboardingStage.visited,
          note: 'Agent on site',
        ),
      );
    }
    await _navigation.pushNamed<void>(AppRoutes.agentFacility(row.id));
  }

  Future<void> createNew() => _navigation.pushNamed<void>(
    AppRoutes.facilityNew,
    args: FacilityEditorArgs(
      lat: _lat,
      lng: _lng,
      name: searchController.text.trim().isEmpty
          ? null
          : searchController.text.trim(),
    ),
  );

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
