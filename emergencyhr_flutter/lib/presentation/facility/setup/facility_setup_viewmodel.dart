import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/facility_api.dart';
import '../../../data/api/onboarding_api.dart';
import '../../../data/models/labels.dart';
import '../../../data/models/route_args.dart';
import '../invite_sheet/invite_sheet_view.dart';

typedef DocumentLine = ({String name, String detail});
typedef StageOption = ({
  String label,
  OnboardingStage stage,
  bool selected,
});

/// One facility's path to go-live, for field agents and hospital admins.
class FacilitySetupViewModel extends ReactiveViewModel {
  FacilitySetupViewModel({
    required this.facilityId,
    FacilityApi? facilities,
    OnboardingApi? onboarding,
    SessionService? session,
    NavigationService? navigation,
    SnackbarService? snackbar,
    DialogService? dialogs,
    BottomSheetService? sheets,
    FilePickService? files,
    PhoneCallService? calls,
  }) : _facilities = facilities ?? locator<FacilityApi>(),
       _onboarding = onboarding ?? locator<OnboardingApi>(),
       _session = session ?? sessionService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService,
       _dialogs = dialogs ?? dialogService,
       _sheets = sheets ?? bottomSheetService,
       _files = files ?? filePickService,
       _calls = calls ?? phoneCallService;

  final int facilityId;
  final FacilityApi _facilities;
  final OnboardingApi _onboarding;
  final SessionService _session;
  final NavigationService _navigation;
  final SnackbarService _snackbar;
  final DialogService _dialogs;
  final BottomSheetService _sheets;
  final FilePickService _files;
  final PhoneCallService _calls;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  FacilityDetail? _detail;
  bool _codeSent = false;
  DateTime? _nextActionAt;

  final notesController = TextEditingController();
  final deskCodeController = TextEditingController();
  final submitNotesController = TextEditingController();

  static const _uploadKey = 'upload';
  static const _deskKey = 'desk';
  static const _submitKey = 'submit';
  static const _notesKey = 'notes';

  Facility? get _f => _detail?.facility;

  bool get isLoading => _detail == null && !hasError;
  String? get errorMessage => modelError?.toString();

  bool get isAgent => _session.hasAnyRole({UserRole.fieldAgent});
  bool get isPlatformAdmin => _session.hasAnyRole({UserRole.platformAdmin});
  bool get canInviteAdmin => isAgent || isPlatformAdmin;

  String get name => _f?.name ?? '';
  String get subtitle => '${_f?.address ?? ''} · ${_f?.area ?? ''}';
  String get stageLabel => 'Stage: ${_f?.onboardingStage.label ?? ''}';
  String get verificationLabel => switch (_f?.verificationStatus) {
    VerificationStatus.seeded || null => 'Not submitted',
    final s => s.label,
  };
  StatusTone get verificationTone => switch (_f?.verificationStatus) {
    VerificationStatus.verified => StatusTone.positive,
    VerificationStatus.rejected ||
    VerificationStatus.suspended => StatusTone.critical,
    _ => StatusTone.warning,
  };

  List<ChecklistLine> get checklist => [
    for (final i in _detail?.checklist.items ?? const <ChecklistItem>[])
      (label: i.label, done: i.done),
  ];

  String get checklistSummary {
    final items = _detail?.checklist.items ?? const <ChecklistItem>[];
    final done = items.where((i) => i.done).length;
    return '$done of ${items.length} done';
  }

  // Documents
  bool get isUploading => busy(_uploadKey);
  bool get canUseCamera => _files.canUseCamera;
  bool get hasDocuments => documents.isNotEmpty;
  List<DocumentLine> get documents => [
    for (final d in _detail?.documents ?? const <FacilityDocument>[])
      (
        name: _docKind(d.kind),
        detail:
            '${_isImage(d.fileName) ? 'Photo' : 'File'} · '
            '${Formatters.date(d.createdAt)}',
      ),
  ];

  static bool _isImage(String name) =>
      RegExp(r'\.(jpe?g|png|webp|heic)$', caseSensitive: false).hasMatch(name);

  // Desk phone
  bool get hasDeskPhone => _f?.deskPhone != null;
  bool get deskPhoneConfirmed => _f?.deskPhoneConfirmedAt != null;
  String get deskPhoneLabel => hasDeskPhone
      ? Formatters.maskedPhone(_f!.deskPhone!)
      : 'No desk phone yet. Add it in the details.';
  String get deskPhoneStatus =>
      deskPhoneConfirmed ? 'Confirmed' : 'Not confirmed';
  StatusTone get deskPhoneTone =>
      deskPhoneConfirmed ? StatusTone.positive : StatusTone.warning;
  String? _deskError;

  /// Why the code could not be sent, e.g. texts are not available yet.
  String? get deskError => _deskError;
  bool get showDeskConfirm => hasDeskPhone && !deskPhoneConfirmed;
  bool get codeSent => _codeSent;
  bool get isConfirmingDesk => busy(_deskKey);

  // Training
  bool get trainingDone => _f?.trainingCompletedAt != null;
  String get trainingLabel => trainingDone
      ? 'Training completed ${Formatters.date(_f!.trainingCompletedAt!)}'
      : 'Desk staff have not done a practice update yet.';

  // Agent record
  String get nextActionLabel => _nextActionAt == null
      ? 'Set next action date'
      : 'Next action: ${Formatters.date(_nextActionAt!)}';
  bool get isSavingNotes => busy(_notesKey);

  List<StageOption> get stageOptions => [
    for (final s in const [
      OnboardingStage.contacted,
      OnboardingStage.visited,
      OnboardingStage.paused,
      OnboardingStage.declined,
    ])
      (label: s.label, stage: s, selected: s == _f?.onboardingStage),
  ];

  // Verification
  bool get isSubmitting => busy(_submitKey);
  bool get canSubmit =>
      _f?.verificationStatus == VerificationStatus.seeded ||
      _f?.verificationStatus == VerificationStatus.rejected;
  String get verificationNote => switch (_f?.verificationStatus) {
    VerificationStatus.pending => 'Submitted. A platform admin will review it.',
    VerificationStatus.verified => 'Verified.',
    VerificationStatus.rejected =>
      'Verification was rejected. Fix the issue and submit again.',
    VerificationStatus.suspended => 'This listing is suspended.',
    _ => 'Upload the registration document, then submit for verification.',
  };

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_facilities.detail(facilityId));
    if (response.success) {
      _detail = response.data;
      final record = response.data!.record;
      notesController.text = record?.notes ?? '';
      _nextActionAt = record?.nextActionAt;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  Future<void> editDetails() async {
    await _navigation.pushNamed<bool>(
      AppRoutes.facilityEdit(facilityId),
      args: FacilityEditorArgs(facilityId: facilityId),
    );
    await load();
  }

  Future<void> uploadRegistrationPhoto() =>
      _upload(DocumentKind.registration, camera: true);
  Future<void> uploadRegistrationFile() =>
      _upload(DocumentKind.registration, camera: false);

  /// Camera on phones, file picker elsewhere.
  Future<void> uploadContactDocument() =>
      _upload(DocumentKind.contactDetails, camera: _files.canUseCamera);

  Future<void> _upload(DocumentKind kind, {required bool camera}) async {
    final picked = camera ? await _files.takePhoto() : await _files.pickFile();
    if (picked == null) return;
    final response = await runBusyFuture(
      _onboarding.uploadDocument(
        fileName: picked.name,
        bytes: picked.bytes,
        kind: kind,
        facilityId: facilityId,
      ),
      busyObject: _uploadKey,
    );
    if (response.success) {
      _snackbar.success(message: 'Document uploaded');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  Future<void> sendDeskCode() async {
    final response = await runBusyFuture(
      _onboarding.requestDeskPhoneCode(facilityId),
      busyObject: _deskKey,
    );
    _deskError = response.success ? null : response.message;
    if (response.success) {
      _codeSent = true;
      _snackbar.success(message: 'Code sent to the desk phone');
    }
    notifyListeners();
  }

  Future<void> confirmDeskCode() async {
    final response = await runBusyFuture(
      _onboarding.confirmDeskPhone(facilityId, deskCodeController.text.trim()),
      busyObject: _deskKey,
    );
    if (response.success) {
      _snackbar.success(message: 'Desk phone confirmed');
      deskCodeController.clear();
      _codeSent = false;
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  /// Agent calls the desk, then records that someone answered.
  Future<void> recordTestCall() async {
    final number = _f?.deskPhone;
    if (number == null) return;
    await _calls.callNumber(number: number, title: 'Call the desk');
    final answered = await _dialogs.confirm(
      title: 'Did the emergency desk answer?',
      message: 'Only confirm if someone at the desk picked up.',
      confirmLabel: 'Yes, they answered',
    );
    if (!answered) return;
    final response = await runBusyFuture(
      _onboarding.recordTestCall(facilityId, note: 'Test call answered'),
      busyObject: _deskKey,
    );
    if (response.success) {
      _snackbar.success(message: 'Desk phone confirmed');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  Future<void> inviteHospitalAdmin() => _invite(UserRole.hospitalAdmin);
  Future<void> inviteDeskStaff() => _invite(UserRole.deskStaff);

  Future<void> _invite(UserRole role) async {
    await _sheets.show<void>(
      InviteSheetView(facilityId: facilityId, role: role),
    );
    await load();
  }

  Future<void> openStaff() async {
    await _navigation.pushNamed<void>(AppRoutes.facilityStaff(facilityId));
    await load();
  }

  Future<void> openPractice() async {
    await _navigation.pushNamed<void>(AppRoutes.facilityPractice(facilityId));
    await load();
  }

  Future<void> pickNextAction() async {
    final date = await _dialogs.pickDate(_nextActionAt ?? DateTime.now());
    if (date == null) return;
    _nextActionAt = DateTime.utc(date.year, date.month, date.day, 8);
    await saveNotes();
  }

  Future<void> saveNotes() async {
    final response = await runBusyFuture(
      _onboarding.updateRecord(
        facilityId,
        notes: notesController.text.trim(),
        nextActionAt: _nextActionAt,
      ),
      busyObject: _notesKey,
    );
    if (response.success) {
      _snackbar.success(message: 'Notes saved');
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  Future<void> setStage(OnboardingStage stage) async {
    final ok = await _dialogs.confirm(
      title: 'Move to ${stage.label}?',
      message: 'This is recorded in the onboarding history.',
      confirmLabel: 'Move',
    );
    if (!ok) return;
    final response = await runBusyFuture(
      _onboarding.setStage(facilityId, stage),
    );
    if (response.success) {
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  Future<void> submit() async {
    final response = await runBusyFuture(
      _onboarding.submitForVerification(
        facilityId,
        notes: submitNotesController.text.trim(),
      ),
      busyObject: _submitKey,
    );
    if (response.success) {
      _snackbar.success(message: 'Submitted for verification');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  static String _docKind(DocumentKind kind) => switch (kind) {
    DocumentKind.registration => 'Registration document',
    DocumentKind.contactDetails => 'Contact details',
    DocumentKind.other => 'Other',
  };

  @override
  void dispose() {
    notesController.dispose();
    deskCodeController.dispose();
    submitNotesController.dispose();
    super.dispose();
  }
}
