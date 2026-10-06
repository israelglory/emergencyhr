import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';
import '../../../data/models/pilot_areas.dart';
import '../components/option_picker_sheet.dart';

typedef JoinItem = ({
  int id,
  String title,
  String detail,
  String? message,
  String status,
  bool open,
  JoinRequest request,
});

/// Hospitals that sent the short "join" form.
class JoinsViewModel extends BaseViewModel {
  JoinsViewModel({
    AdminApi? api,
    DialogService? dialogs,
    BottomSheetService? sheets,
    SnackbarService? snackbar,
  }) : _api = api ?? adminApi,
       _dialogs = dialogs ?? dialogService,
       _sheets = sheets ?? bottomSheetService,
       _snackbar = snackbar ?? snackbarService;

  final AdminApi _api;
  final DialogService _dialogs;
  final BottomSheetService _sheets;
  final SnackbarService _snackbar;
  List<JoinRequest> _rows = const [];

  String? get errorMessage => modelError?.toString();
  ViewState get state =>
      viewStateOf(busy: isBusy, hasError: hasError, hasData: _rows.isNotEmpty);

  List<JoinItem> get rows {
    final now = DateTime.now().toUtc();
    return [
      for (final r in _rows)
        (
          id: r.id!,
          title: r.hospitalName,
          detail:
              '${r.contactName} · ${Formatters.phone(r.phone)} · ${r.area} · '
              '${Formatters.ago(r.createdAt, now)}',
          message: r.message,
          status: switch (r.status) {
            JoinRequestStatus.received => 'New',
            JoinRequestStatus.contacted => 'Contacted',
            JoinRequestStatus.converted => 'Converted',
            JoinRequestStatus.closed => 'Closed',
          },
          open:
              r.status == JoinRequestStatus.received ||
              r.status == JoinRequestStatus.contacted,
          request: r,
        ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.joinRequests());
    if (response.success) {
      _rows = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> markContacted(JoinItem item) =>
      _setStatus(item, JoinRequestStatus.contacted);
  Future<void> close(JoinItem item) =>
      _setStatus(item, JoinRequestStatus.closed);

  Future<void> _setStatus(JoinItem item, JoinRequestStatus status) async {
    final response = await runBusyFuture(_api.setJoinStatus(item.id, status));
    if (response.success) {
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  /// Creates a listing in the area and assigns a field agent to visit.
  Future<void> convert(JoinItem item) async {
    final agents = await _api.agents();
    if (!agents.success || agents.data!.isEmpty) {
      _snackbar.error(message: 'Add a field agent first.');
      return;
    }
    final agentId = await _sheets.show<int>(
      OptionPickerSheet<int>(
        title: 'Who should visit?',
        options: [
          for (final a in agents.data!)
            (
              label: a.name ?? a.phone,
              detail: a.areas.join(', '),
              value: a.userId,
            ),
        ],
        onPick: (id) => _sheets.dismiss<int>(id),
      ),
    );
    if (agentId == null) return;
    final address = await _dialogs.promptText(
      title: 'Hospital address',
      label: 'Street address in ${item.request.area}',
      confirmLabel: 'Create visit',
    );
    if (address == null) return;
    final area =
        PilotAreas.all.where((a) => a.name == item.request.area).firstOrNull ??
        PilotAreas.all.first;
    final response = await runBusyFuture(
      _api.convertJoin(
        id: item.id,
        agentUserId: agentId,
        lat: area.lat,
        lng: area.lng,
        address: address,
      ),
    );
    if (response.success) {
      _snackbar.success(
        message: 'Visit assigned. The agent sets the exact map pin on site.',
      );
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }
}
