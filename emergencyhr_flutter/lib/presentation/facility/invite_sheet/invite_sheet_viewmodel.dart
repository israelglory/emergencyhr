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

  final phoneController = TextEditingController();
  InviteCreated? _created;
  String? _phoneError;

  String get title => 'Invite ${role.label.toLowerCase()}';
  static const explainer =
      'Add their phone number to text them the invite, or leave it empty and '
      'let them scan the code on this screen. Invites work once and expire '
      'in 72 hours.';

  bool get isCreated => _created != null;
  String? get phoneError => _phoneError;
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
  String get sentLabel => _created?.invite.phone == null
      ? 'Ask them to scan this code with their phone camera, or open the '
            'link and enter the code.'
      : 'We texted the invite to ${Formatters.phone(_created!.invite.phone!)}.';

  void onPhoneChanged(String _) {
    if (_phoneError == null) return;
    _phoneError = null;
    notifyListeners();
  }

  Future<void> create() async {
    final phone = phoneController.text.trim();
    final response = await runBusyFuture(
      _api.invite(facilityId, role, phone: phone.isEmpty ? null : phone),
    );
    if (response.success) {
      _created = response.data;
      onCreated?.call();
    } else if (response.field == 'phone') {
      _phoneError = response.message;
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
    phoneController.dispose();
    super.dispose();
  }
}
