import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import 'agent_form_sheet.dart';

typedef AgentItem = ({int id, String name, String detail, AgentRow agent});

class AgentsViewModel extends BaseViewModel {
  AgentsViewModel({
    AdminApi? api,
    BottomSheetService? sheets,
    DialogService? dialogs,
    SnackbarService? snackbar,
  }) : _api = api ?? adminApi,
       _sheets = sheets ?? bottomSheetService,
       _dialogs = dialogs ?? dialogService,
       _snackbar = snackbar ?? snackbarService;

  final AdminApi _api;
  final BottomSheetService _sheets;
  final DialogService _dialogs;
  final SnackbarService _snackbar;
  List<AgentRow> _rows = const [];

  String? get errorMessage => modelError?.toString();
  ViewState get state =>
      viewStateOf(busy: isBusy, hasError: hasError, hasData: _rows.isNotEmpty);

  List<AgentItem> get rows => [
    for (final a in _rows)
      (
        id: a.userId,
        name: a.name ?? 'Name not set',
        detail: [
          Formatters.phone(a.phone),
          a.areas.isEmpty ? 'No areas' : a.areas.join(', '),
          Formatters.count(a.facilityCount, 'hospital'),
        ].join(' · '),
        agent: a,
      ),
  ];

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.agents());
    if (response.success) {
      _rows = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> add() async {
    final saved = await _sheets.show<bool>(const AgentFormSheet());
    if (saved == true) await load();
  }

  Future<void> editAreas(AgentItem item) async {
    final saved = await _sheets.show<bool>(
      AgentFormSheet(userId: item.id, areas: item.agent.areas),
    );
    if (saved == true) await load();
  }

  Future<void> deactivate(AgentItem item) async {
    final ok = await _dialogs.confirm(
      title: 'Deactivate ${item.name}?',
      message:
          'They lose field agent access. Their hospitals stay assigned '
          'until you reassign them.',
      confirmLabel: 'Deactivate',
      destructive: true,
    );
    if (!ok) return;
    final response = await runBusyFuture(_api.deactivateAgent(item.id));
    if (response.success) {
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }
}
