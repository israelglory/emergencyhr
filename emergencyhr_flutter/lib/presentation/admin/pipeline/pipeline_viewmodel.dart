import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/pilot_areas.dart';
import '../components/option_picker_sheet.dart';

typedef PipelineItem = ({
  int id,
  String name,
  String stage,
  String agent,
  String progress,
  String? nextAction,
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

  static const allAreas = 'All areas';
  static const allAgents = 'All agents';

  bool get isLoading => isBusy && _board == null;
  String? get errorMessage => modelError?.toString();

  String get targetLabel {
    final b = _board;
    if (b == null) return '';
    return '${b.liveCount} live. Pilot target ${b.targetMin} to ${b.targetMax}.';
  }

  List<String> get stageCounts => [
    for (final c in _board?.counts ?? const <StageCount>[])
      '${c.stage.label} ${c.count}',
  ];

  List<String> get areaOptions => [allAreas, ...PilotAreas.names];
  String get area => _area ?? allAreas;
  List<({int? id, String label})> get agentOptions => [
    (id: null, label: allAgents),
    for (final a in _agents)
      (
        id: a.userId,
        label: Formatters.person(name: a.name, email: a.email, phone: a.phone),
      ),
  ];
  int? get agentId => _agentId;

  bool get hasSelection => _selected.isNotEmpty;
  String get selectionLabel => '${_selected.length} selected';

  List<PipelineItem> get rows => [
    for (final r in _board?.rows ?? const <PipelineRow>[])
      (
        id: r.facility.id,
        name: r.facility.name,
        stage: r.facility.onboardingStage.label,
        agent: r.agentName ?? 'Unassigned',
        progress: '${r.checklistDone}/${r.checklistTotal}',
        nextAction: r.nextActionAt == null
            ? null
            : 'Next ${Formatters.date(r.nextActionAt!)}',
        selected: _selected.contains(r.facility.id),
      ),
  ];

  Future<void> load() async {
    setError(null);
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
        title: 'Assign to field agent',
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
