import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/onboarding_api.dart';
import '../../../data/models/route_args.dart';

/// Claim an existing listing: registration document plus, where possible,
/// a code sent to the listed desk phone.
class ClaimViewModel extends BaseViewModel {
  ClaimViewModel({
    required this.args,
    OnboardingApi? api,
    SessionService? session,
    NavigationService? navigation,
    SnackbarService? snackbar,
    FilePickService? files,
  }) : _api = api ?? locator<OnboardingApi>(),
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService,
       _files = files ?? filePickService;

  final ClaimArgs? args;
  final OnboardingApi _api;
  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;
  final FilePickService _files;

  final contactNameController = TextEditingController();
  final deskCodeController = TextEditingController();

  final List<({FacilityDocument doc, String meta})> _documents = [];
  String? _deskCodeSentTo;
  bool _deskCodeFailed = false;
  String? _contactError;
  bool _submitted = false;

  static const _uploadKey = 'upload';
  static const _codeKey = 'code';

  static const title = 'Join Emergencyhr';
  String get heading => 'Claim ${args?.name ?? 'this hospital'}';
  static const intro =
      'Prove you run this hospital to take over its listing. A platform '
      'admin reviews every claim.';
  static const deskTitle = 'Desk phone check';
  static const deskHint =
      'Recommended. We text a code to the desk phone on this listing.';
  static const deskFailed =
      'We could not send a code right now. You can send your claim without '
      'it.';
  bool get submitted => _submitted;
  static const submittedTitle = 'Claim sent';
  static const submittedMessage =
      'We will review it and text you when it is approved.';

  bool get isUploading => busy(_uploadKey);
  bool get isSendingCode => busy(_codeKey);
  bool get canUseCamera => _files.canUseCamera;
  String? get contactError => _contactError;
  List<({String name, String meta, VoidCallback onRemove})> get documents => [
    for (final (i, d) in _documents.indexed)
      (name: d.doc.fileName, meta: d.meta, onRemove: () => removeDocument(i)),
  ];
  bool get hasDocuments => _documents.isNotEmpty;
  bool get codeSent => _deskCodeSentTo != null;
  bool get deskCodeFailed => _deskCodeFailed;
  String get codeSentLabel =>
      'We texted a code to the desk phone ending $_deskCodeSentTo. Ask the '
      'desk for it and enter it here.';

  void onReady() {
    if (args == null) {
      _navigation.replaceWith<void>(AppRoutes.joinHospital);
      return;
    }
    contactNameController.text = _session.currentUser?.user.name ?? '';
  }

  Future<void> photograph() async =>
      _upload(await _files.takePhoto(), photo: true);

  Future<void> upload() async => _upload(await _files.pickFile());

  void removeDocument(int index) {
    _documents.removeAt(index);
    notifyListeners();
  }

  Future<void> _upload(PickedDocument? picked, {bool photo = false}) async {
    if (picked == null) return;
    final response = await runBusyFuture(
      _api.uploadDocument(
        fileName: picked.name,
        bytes: picked.bytes,
        kind: DocumentKind.registration,
      ),
      busyObject: _uploadKey,
    );
    if (response.success) {
      _documents.add((
        doc: response.data!,
        meta:
            '${photo ? 'Photo' : 'File'} · '
            '${Formatters.fileSize(picked.bytes.length)}',
      ));
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  Future<void> sendDeskCode() async {
    final response = await runBusyFuture(
      _api.requestClaimCode(args!.facilityId),
      busyObject: _codeKey,
    );
    _deskCodeFailed = !response.success;
    if (response.success) {
      _deskCodeSentTo = response.data!.phone.replaceAll(RegExp(r'\D'), '');
    }
    notifyListeners();
  }

  Future<void> submit() async {
    if (contactNameController.text.trim().isEmpty) {
      _contactError = 'Enter your full name.';
      notifyListeners();
      return;
    }
    if (_documents.isEmpty) {
      _snackbar.error(message: 'Upload the registration document first.');
      return;
    }
    final code = deskCodeController.text.trim();
    final response = await runBusyFuture(
      _api.submitClaim(
        facilityId: args!.facilityId,
        contactName: contactNameController.text.trim(),
        documentPaths: [for (final d in _documents) d.doc.storagePath],
        deskPhoneCode: code.isEmpty ? null : code,
      ),
    );
    if (response.success) {
      _submitted = true;
    } else if (response.field == 'contactName') {
      _contactError = response.message;
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  void done() => _navigation.clearStackAndShow<void>(AppRoutes.home);

  @override
  void dispose() {
    contactNameController.dispose();
    deskCodeController.dispose();
    super.dispose();
  }
}
