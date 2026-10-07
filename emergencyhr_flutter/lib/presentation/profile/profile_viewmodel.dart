import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import '../../data/api/auth_api.dart';
import '../../data/api/profile_api.dart';
import '../../data/models/labels.dart';
import 'contact_sheet/contact_sheet_view.dart';
import 'export/export_view.dart';

typedef ContactRow = ({String name, String detail, EmergencyContact contact});

class ProfileViewModel extends ReactiveViewModel {
  ProfileViewModel({
    AuthApi? api,
    ProfileApi? profile,
    SessionService? session,
    BottomSheetService? sheets,
    LauncherService? launcher,
    NavigationService? navigation,
    SnackbarService? snackbar,
    DialogService? dialogs,
  }) : _api = api ?? authApi,
       _profile = profile ?? profileApi,
       _session = session ?? sessionService,
       _sheets = sheets ?? bottomSheetService,
       _launcher = launcher ?? launcherService,
       _navigation = navigation ?? navigationService,
       _snackbar = snackbar ?? snackbarService,
       _dialogs = dialogs ?? dialogService;

  final AuthApi _api;
  final ProfileApi _profile;
  final SessionService _session;
  final BottomSheetService _sheets;
  final LauncherService _launcher;
  final NavigationService _navigation;
  final SnackbarService _snackbar;
  final DialogService _dialogs;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  final nameController = TextEditingController();
  String? _nameError;
  String? get nameError => _nameError;

  static const _saveKey = 'saveName';
  bool get isSavingName => busy(_saveKey);

  bool get isSignedIn => _session.isSignedIn;
  bool get isLoading => isSignedIn && _session.currentUser == null;

  static const signedOutTitle = 'Sign in to use your profile';
  static const signedOutMessage =
      'Save emergency contacts and medical details, and use the Health '
      'Assistant. Emergency works without an account.';

  String get emailLabel => _session.currentUser?.user.email ?? 'Not set';

  final phoneController = TextEditingController();
  String? _phoneError;
  String? get phoneError => _phoneError;
  static const _phoneKey = 'savePhone';
  bool get isSavingPhone => busy(_phoneKey);
  static const phoneHint =
      'Optional. Lets your hospital send quick WhatsApp status updates and '
      'reminders to you.';

  List<String> get roleLabels {
    final user = _session.currentUser;
    if (user == null) return const [];
    final names = {for (final f in user.facilities) f.id: f.name};
    return [
      for (final r in user.roles)
        r.facilityId == null
            ? r.role.label
            : '${r.role.label}, ${names[r.facilityId] ?? 'facility'}',
    ];
  }

  List<EmergencyContact> _contacts = const [];
  static const maxContacts = 3;

  List<ContactRow> get contacts => [
    for (final c in _contacts)
      (
        name: c.name,
        detail:
            '${Formatters.phone(c.phone)} · '
            '${c.channel == ContactChannel.whatsapp ? 'WhatsApp' : 'SMS'}',
        contact: c,
      ),
  ];
  bool get canAddContact => _contacts.length < maxContacts;
  String get contactsSubtitle =>
      'Up to $maxContacts people we text when you use Emergency.';

  static const _exportKey = 'export';
  bool get isExporting => busy(_exportKey);

  Future<void> onReady() async {
    _fillFromUser();
    if (!isSignedIn) return;
    if (_session.currentUser == null) {
      await _session.refresh();
      _fillFromUser();
    }
    await loadContacts();
  }

  void _fillFromUser() {
    final user = _session.currentUser?.user;
    nameController.text = user?.name ?? '';
    phoneController.text = user?.phone == null
        ? ''
        : Formatters.phone(user!.phone!);
  }

  void onPhoneChanged(String _) {
    if (_phoneError == null) return;
    _phoneError = null;
    notifyListeners();
  }

  /// Saves the phone number, or removes it when the field is empty.
  Future<void> savePhone() async {
    final phone = phoneController.text.trim();
    final response = await runBusyFuture(
      _api.updatePhone(phone.isEmpty ? null : phone),
      busyObject: _phoneKey,
    );
    if (response.success) {
      _session.update(response.data!);
      _snackbar.success(
        message: phone.isEmpty ? 'Phone number removed' : 'Phone number saved',
      );
    } else {
      _phoneError = response.message;
      notifyListeners();
    }
  }

  Future<void> loadContacts() async {
    final response = await _profile.contacts();
    if (response.success) _contacts = response.data!;
    notifyListeners();
  }

  Future<void> addContact() => _editContact(null);
  Future<void> editContact(EmergencyContact c) => _editContact(c);

  Future<void> _editContact(EmergencyContact? c) async {
    final saved = await _sheets.show<bool>(ContactSheetView(contact: c));
    if (saved == true) await loadContacts();
  }

  Future<void> deleteContact(EmergencyContact c) async {
    final ok = await _dialogs.confirm(
      title: 'Remove ${c.name}?',
      message: 'They will no longer get emergency alerts from you.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (!ok) return;
    final response = await _profile.deleteContact(c.id!);
    if (!response.success) _snackbar.error(message: response.message!);
    await loadContacts();
  }

  void openMedical() => _navigation.pushNamed<void>(AppRoutes.medicalProfile);

  Future<void> exportData() async {
    final response = await runBusyFuture(
      _profile.exportMyData(),
      busyObject: _exportKey,
    );
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    final json = response.data!;
    await _sheets.show<void>(
      ExportSheet(
        json: json,
        onCopy: () async {
          await _launcher.copy(json);
          _snackbar.success(message: 'Copied');
        },
      ),
    );
  }

  Future<void> deleteAccount() async {
    final first = await _dialogs.confirm(
      title: 'Delete your account?',
      message:
          'This deletes your profile, contacts, medical details and Health '
          'Assistant history. It cannot be undone.',
      confirmLabel: 'Continue',
      destructive: true,
    );
    if (!first) return;
    final second = await _dialogs.confirm(
      title: 'Are you sure?',
      message: 'Your account will be deleted now.',
      confirmLabel: 'Delete account',
      destructive: true,
    );
    if (!second) return;
    final response = await runBusyFuture(_profile.deleteMyAccount());
    if (!response.success) {
      _snackbar.error(message: response.message!);
      return;
    }
    await _session.signOut();
    _snackbar.success(message: 'Your account has been deleted');
    await _navigation.clearStackAndShow<void>(AppRoutes.home);
  }

  void signIn() =>
      _navigation.pushNamed<void>(AppRoutes.signInWithNext(AppRoutes.profile));

  void onNameChanged(String _) {
    if (_nameError == null) return;
    _nameError = null;
    notifyListeners();
  }

  Future<void> saveName() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      _nameError = 'Enter your name.';
      notifyListeners();
      return;
    }
    final response = await runBusyFuture(
      _api.updateName(name),
      busyObject: _saveKey,
    );
    if (response.success) {
      _session.update(response.data!);
      _snackbar.success(message: 'Name saved');
    } else {
      _nameError = response.message;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    final confirmed = await _dialogs.confirm(
      title: 'Sign out?',
      message: 'You can still use Emergency without an account.',
      confirmLabel: 'Sign out',
    );
    if (!confirmed) return;
    await _session.signOut();
    await _navigation.clearStackAndShow<void>(AppRoutes.home);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
