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

  final List<FacilityDocument> _documents = [];
  String? _deskCodeSentTo;
  String? _contactError;
  bool _submitted = false;

  static const _uploadKey = 'upload';
  static const _codeKey = 'code';

  String get title => 'Claim ${args?.name ?? 'this hospital'}';
  static const intro =
      'Tell us who you are and upload the hospital registration document. '
      'A platform admin reviews every claim.';
  bool get submitted => _submitted;
  static const submittedTitle = 'Claim sent';
  static const submittedMessage =
      'We will review it and text you. Once approved you can manage this '
      'hospital and update its status.';

  bool get isUploading => busy(_uploadKey);
  bool get isSendingCode => busy(_codeKey);
  bool get canUseCamera => _files.canUseCamera;
  String get addDocumentLabel =>
      canUseCamera ? 'Photograph the document' : 'Upload the document';
  String? get contactError => _contactError;
  List<String> get documentNames => [for (final d in _documents) d.fileName];
  bool get codeSent => _deskCodeSentTo != null;
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

  Future<void> addDocument() async {
    final picked = _files.canUseCamera
        ? await _files.takePhoto()
        : await _files.pickFile();
    await _upload(picked);
  }

  Future<void> addDocumentFile() async => _upload(await _files.pickFile());

  Future<void> _upload(PickedDocument? picked) async {
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
      _documents.add(response.data!);
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
    if (response.success) {
      _deskCodeSentTo = response.data!.phone.replaceAll(RegExp(r'\D'), '');
    } else {
      _snackbar.error(message: response.message!);
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
        documentPaths: [for (final d in _documents) d.storagePath],
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
