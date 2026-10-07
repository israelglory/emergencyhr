import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/pilot_areas.dart';

typedef PipelineItem = ({
  int id,
  String name,
  String area,
  String stageAgent,
  String progress,
  StatusTone progressTone,
  String nextAction,
  bool selected,
});

class PipelineViewModel extends BaseViewModel {
  PipelineViewModel({
    AdminApi? api,
    BottomSheetService? sheets,
    SnackbarService? snackbar,
    NavigationService? navigation,
  }) : _api = api ?? adminApi,
       _sheets = sheets ?? bottomSheetService,
       _snackbar = snackbar ?? snackbarService,
       _navigation = navigation ?? navigationService;

  final AdminApi _api;
  final BottomSheetService _sheets;
  final SnackbarService _snackbar;
  final NavigationService _navigation;

  PipelineBoard? _board;
  List<AgentRow> _agents = const [];
  String? _area;
  int? _agentId;
  final Set<int> _selected = {};
  int _shown = pageSize;

  /// Rows shown at a time; the whole board can hold hundreds of hospitals.
  static const pageSize = 50;

  static const allAreas = 'All areas';
  static const allAgents = 'All agents';

  bool get isLoading => isBusy && _board == null;
  String? get errorMessage => modelError?.toString();

  String get targetLabel {
    final b = _board;
    if (b == null) return '';
    return '${b.liveCount} live. Pilot target ${b.targetMin} to ${b.targetMax}.';
  }

  List<({String label, String value})> get stageCounts => [
    for (final c in _board?.counts ?? const <StageCount>[])
      (label: c.stage.label, value: '${c.count}'),
  ];

  List<({String value, String label})> get areaOptions => [
    for (final a in [allAreas, ...PilotAreas.names]) (value: a, label: a),
  ];
  String get area => _area ?? allAreas;
  List<({int? value, String label})> get agentOptions => [
    (value: null, label: allAgents),
    for (final a in _agents)
      (
        value: a.userId,
        label: Formatters.person(name: a.name, email: a.email, phone: a.phone),
      ),
  ];
  int? get agentId => _agentId;

  bool get hasSelection => _selected.isNotEmpty;
  String get selectionLabel => '${_selected.length} selected';

  bool get hasMore => (_board?.rows.length ?? 0) > _shown;

  List<PipelineItem> get rows => [
    for (final r in (_board?.rows ?? const <PipelineRow>[]).take(_shown))
      (
        id: r.facility.id,
        name: r.facility.name,
        area: r.facility.area,
        stageAgent:
            '${r.facility.onboardingStage.label} · '
            '${r.agentName ?? 'Unassigned'}',
        progress: '${r.checklistDone}/${r.checklistTotal}',
        progressTone: r.checklistDone == r.checklistTotal
            ? StatusTone.positive
            : StatusTone.neutral,
        nextAction: r.nextActionAt == null
            ? 'None'
            : Formatters.dayMonth(r.nextActionAt!),
        selected: _selected.contains(r.facility.id),
      ),
  ];

  void loadMore() {
    _shown += pageSize;
    notifyListeners();
  }

  Future<void> load() async {
    setError(null);
    _shown = pageSize;
    final results = await runBusyFuture(
      Future.wait([
        _api.pipeline(area: _area, agentUserId: _agentId),
        _api.agents(),
      ]),
    );
    if (results[0].success) {
      _board = results[0].data as PipelineBoard;
    } else {
      setError(results[0].message);
    }
    if (results[1].success) _agents = results[1].data as List<AgentRow>;
    notifyListeners();
  }

  void setArea(String? value) {
    _area = value == null || value == allAreas ? null : value;
    load();
  }

  void setAgent(int? id) {
    _agentId = id;
    load();
  }

  void toggle(int id) {
    _selected.contains(id) ? _selected.remove(id) : _selected.add(id);
    notifyListeners();
  }

  void open(int id) => _navigation.pushNamed<void>(AppRoutes.agentFacility(id));

  Future<void> assignSelected() async {
    final agentId = await _sheets.show<int>(
      OptionPickerSheet<int>(
        title: 'Pick an agent',
        subtitle: 'Assign ${Formatters.count(_selected.length, 'hospital')}',
        options: [
          for (final a in _agents)
            (
              label: Formatters.person(
                name: a.name,
                email: a.email,
                phone: a.phone,
              ),
              detail: a.areas.join(', '),
              value: a.userId,
            ),
        ],
        onPick: (id) => _sheets.dismiss<int>(id),
      ),
    );
    if (agentId == null) return;
    final response = await runBusyFuture(
      _api.assignAgent(_selected.toList(), agentId),
    );
    if (response.success) {
      _selected.clear();
      _snackbar.success(message: 'Assigned');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }
}
