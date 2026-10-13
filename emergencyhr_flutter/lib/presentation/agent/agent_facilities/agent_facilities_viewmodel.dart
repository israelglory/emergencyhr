import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/onboarding_api.dart';
import '../../../data/models/labels.dart';

typedef AgentFacilityRow = ({
  int id,
  String name,
  String detail,
  String progress,
  StatusTone progressTone,
  String nextAction,
});

class AgentFacilitiesViewModel extends BaseViewModel {
  AgentFacilitiesViewModel({
    OnboardingApi? api,
    NavigationService? navigation,
  }) : _api = api ?? locator<OnboardingApi>(),
       _navigation = navigation ?? navigationService;

  final OnboardingApi _api;
  final NavigationService _navigation;

  List<AgentFacility> _items = const [];

  String? get errorMessage => modelError?.toString();
  bool get isLoading => isBusy && _items.isEmpty;
  bool get isEmpty => !isBusy && !hasError && _items.isEmpty;

  // Filters
  final searchController = TextEditingController();
  static const allAreas = 'All areas';
  String? _area;
  int _shown = pageSize;

  /// Rows shown at a time; an area can hold hundreds of hospitals.
  static const pageSize = 50;

  String get area => _area ?? allAreas;
  List<({String value, String label})> get areaOptions => [
    for (final a in [
      allAreas,
      ...{for (final i in _items) i.facility.area}.toList()..sort(),
    ])
      (value: a, label: a),
  ];

  List<AgentFacility> get _filtered {
    final q = searchController.text.trim().toLowerCase();
    return [
      for (final i in _items)
        if ((_area == null || i.facility.area == _area) &&
            (q.isEmpty ||
                i.facility.name.toLowerCase().contains(q) ||
                i.address.toLowerCase().contains(q)))
          i,
    ];
  }

  bool get isFiltered =>
      _area != null || searchController.text.trim().isNotEmpty;
  bool get noMatches => isFiltered && _filtered.isEmpty;
  bool get hasMore => _filtered.length > _shown;

  String get countLabel {
    final matching = _filtered.length;
    final label = Formatters.count(matching, 'hospital');
    return isFiltered ? '$label of ${_items.length}' : label;
  }

  void setArea(String? value) {
    _area = value == null || value == allAreas ? null : value;
    _shown = pageSize;
    notifyListeners();
  }

  void onSearchChanged(String _) {
    _shown = pageSize;
    notifyListeners();
  }

  void clearFilters() {
    _area = null;
    searchController.clear();
    _shown = pageSize;
    notifyListeners();
  }

  void loadMore() {
    _shown += pageSize;
    notifyListeners();
  }

  List<AgentFacilityRow> get rows {
    final sorted = _filtered
      ..sort((a, b) {
        final an = a.nextActionAt ?? DateTime.utc(9999);
        final bn = b.nextActionAt ?? DateTime.utc(9999);
        return an.compareTo(bn);
      });
    return [
      for (final i in sorted.take(_shown))
        (
          id: i.facility.id,
          name: i.facility.name,
          detail:
              '${i.facility.area} · ${i.facility.onboardingStage.label}'
              '${i.submitted ? ' · submitted' : ''}',
          progress: '${i.checklistDone}/${i.checklistTotal}',
          progressTone: i.checklistDone == i.checklistTotal
              ? StatusTone.positive
              : StatusTone.neutral,
          nextAction: i.nextActionAt == null
              ? 'No date set'
              : 'Next action ${Formatters.dayMonth(i.nextActionAt!)}',
        ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.myFacilities());
    if (response.success) {
      _items = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> open(int id) async {
    await _navigation.pushNamed<void>(AppRoutes.agentFacility(id));
    await load();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
