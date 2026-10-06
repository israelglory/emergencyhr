import 'dart:convert';

import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';

typedef DocRow = ({int id, String name});
typedef VerificationRow = ({
  int facilityId,
  String name,
  String detail,
  String submitted,
  String? notes,
  List<ChecklistLine> checklist,
  List<DocRow> documents,
});

class VerificationViewModel extends BaseViewModel {
  VerificationViewModel({
    AdminApi? api,
    DialogService? dialogs,
    SnackbarService? snackbar,
    LauncherService? launcher,
  }) : _api = api ?? adminApi,
       _dialogs = dialogs ?? dialogService,
       _snackbar = snackbar ?? snackbarService,
       _launcher = launcher ?? launcherService;

  final AdminApi _api;
  final DialogService _dialogs;
  final SnackbarService _snackbar;
  final LauncherService _launcher;

  List<VerificationItem> _items = const [];

  bool get isLoading => isBusy && _items.isEmpty;
  String? get errorMessage => modelError?.toString();
  bool get isEmpty => !isBusy && !hasError && _items.isEmpty;

  List<VerificationRow> get rows {
    final now = DateTime.now().toUtc();
    return [
      for (final i in _items)
        (
          facilityId: i.facility.id,
          name: i.facility.name,
          detail: '${i.address} · ${i.facility.area}',
          submitted: i.submittedAt == null
              ? 'Submitted'
              : 'Submitted ${Formatters.ago(i.submittedAt!, now)}'
                    '${i.submittedByName == null ? '' : ' by ${i.submittedByName}'}',
          notes: i.notes,
          checklist: [
            for (final c in i.checklist.items) (label: c.label, done: c.done),
          ],
          documents: [
            for (final d in i.documents) (id: d.id!, name: d.fileName),
          ],
        ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.verificationQueue());
    if (response.success) {
      _items = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> openDocument(DocRow doc) async {
    final response = await runBusyFuture(_api.document(doc.id));
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    final bytes = response.data!.buffer.asUint8List();
    final isPdf = doc.name.toLowerCase().endsWith('.pdf');
    if (isPdf) {
      final opened = await _launcher.openUrl(
        Uri.parse('data:application/pdf;base64,${base64Encode(bytes)}'),
      );
      if (!opened) _snackbar.info(message: 'Could not open the PDF here.');
      return;
    }
    await _dialogs.show<void>(
      Dialog(
        child: InteractiveViewer(
          child: Image.memory(bytes, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Future<void> approve(int facilityId, String name) async {
    final ok = await _dialogs.confirm(
      title: 'Approve $name?',
      message:
          'It will go live automatically once the rest of the checklist is '
          'complete.',
      confirmLabel: 'Approve',
    );
    if (!ok) return;
    final response = await runBusyFuture(_api.approve(facilityId));
    _report(response.success, response.message, 'Approved');
  }

  Future<void> reject(int facilityId, String name) async {
    final reason = await _dialogs.promptText(
      title: 'Reject $name',
      label: 'Reason, shown to the agent and hospital',
      confirmLabel: 'Reject',
      destructive: true,
    );
    if (reason == null) return;
    final response = await runBusyFuture(_api.reject(facilityId, reason));
    _report(response.success, response.message, 'Rejected');
  }

  void _report(bool ok, String? message, String success) {
    if (ok) {
      _snackbar.success(message: success);
      load();
    } else {
      _snackbar.error(message: message!);
    }
  }
}
