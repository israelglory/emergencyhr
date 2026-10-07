import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/staff_api.dart';
import '../../../data/models/labels.dart';

/// Creates an invite and shows its QR code, short code and link.
class InviteSheetViewModel extends BaseViewModel {
  InviteSheetViewModel({
    required this.facilityId,
    required this.role,
    this.onCreated,
    StaffApi? api,
    LauncherService? launcher,
    SnackbarService? snackbar,
    BottomSheetService? sheets,
  }) : _api = api ?? locator<StaffApi>(),
       _launcher = launcher ?? launcherService,
       _snackbar = snackbar ?? snackbarService,
       _sheets = sheets ?? bottomSheetService;

  final int facilityId;
  final UserRole role;
  final VoidCallback? onCreated;
  final StaffApi _api;
  final LauncherService _launcher;
  final SnackbarService _snackbar;
  final BottomSheetService _sheets;

  final emailController = TextEditingController();
  InviteCreated? _created;
  String? _emailError;

  String get title => 'Invite ${role.label.toLowerCase()}';
  static const explainer =
      'Optionally add their email so only that account can use the invite. '
      'Then let them scan the code on this screen, or send them the link. '
      'Invites work once and expire in 72 hours.';

  bool get isCreated => _created != null;
  String? get emailError => _emailError;
  String get qrData => _created?.link ?? '';
  String get shortCode {
    final code = _created?.invite.shortCode ?? '';
    return code.length == 8
        ? '${code.substring(0, 4)} ${code.substring(4)}'
        : code;
  }

  String get expiresLabel => _created == null
      ? ''
      : 'Expires ${Formatters.dateTime(_created!.invite.expiresAt)}';
  String get sentLabel {
    final email = _created?.invite.email;
    const how =
        'Ask them to scan this code with their phone camera, or send them the '
        'link. They sign in or create an account, then accept.';
    return email == null ? how : '$how Only $email can accept it.';
  }

  void onEmailChanged(String _) {
    if (_emailError == null) return;
    _emailError = null;
    notifyListeners();
  }

  Future<void> create() async {
    final email = emailController.text.trim();
    final response = await runBusyFuture(
      _api.invite(facilityId, role, email: email.isEmpty ? null : email),
    );
    if (response.success) {
      _created = response.data;
      onCreated?.call();
    } else if (response.field == 'email') {
      _emailError = response.message;
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  Future<void> copyLink() async {
    await _launcher.copy(qrData);
    _snackbar.success(message: 'Invite link copied');
  }

  void close() => _sheets.dismiss<void>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
