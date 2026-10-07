import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/status_api.dart';

typedef AuditRow = ({String meta, String summary, bool practice});

class AuditLogViewModel extends BaseViewModel {
  AuditLogViewModel({required this.facilityId, StatusApi? api})
    : _api = api ?? locator<StatusApi>();

  final int facilityId;
  final StatusApi _api;

  static const pageSize = 50;
  final List<AuditEntry> _entries = [];
  bool _hasMore = true;

  String? get errorMessage => modelError?.toString();
  bool get isLoading => isBusy && _entries.isEmpty;
  bool get isEmpty => !isBusy && _entries.isEmpty && !hasError;
  bool get canLoadMore => _hasMore && _entries.isNotEmpty;
  bool get isLoadingMore => isBusy && _entries.isNotEmpty;

  List<AuditRow> get rows => [
    for (final e in _entries)
      (
        meta:
            '${e.userName} · '
            '${Formatters.auditTime(e.at, DateTime.now().toUtc())}',
        summary: e.summary,
        practice: e.practice,
      ),
  ];

  Future<void> load() async {
    _entries.clear();
    _hasMore = true;
    await loadMore();
  }

  Future<void> loadMore() async {
    setError(null);
    final response = await runBusyFuture(
      _api.auditLog(facilityId, limit: pageSize, offset: _entries.length),
    );
    if (response.success) {
      _entries.addAll(response.data!);
      _hasMore = response.data!.length == pageSize;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }
}
