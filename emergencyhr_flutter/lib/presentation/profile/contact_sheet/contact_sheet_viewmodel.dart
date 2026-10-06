import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/profile_api.dart';

class ContactSheetViewModel extends BaseViewModel {
  ContactSheetViewModel({
    this.contact,
    ProfileApi? api,
    SnackbarService? snackbar,
    BottomSheetService? sheets,
  }) : _api = api ?? profileApi,
       _snackbar = snackbar ?? snackbarService,
       _sheets = sheets ?? bottomSheetService {
    nameController.text = contact?.name ?? '';
    phoneController.text = contact?.phone ?? '';
    _channel = contact?.channel ?? ContactChannel.sms;
  }

  final EmergencyContact? contact;
  final ProfileApi _api;
  final SnackbarService _snackbar;
  final BottomSheetService _sheets;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  late ContactChannel _channel;
  Map<String, String> _errors = {};

  String get title =>
      contact == null ? 'Add emergency contact' : 'Edit contact';
  String? errorFor(String field) => _errors[field];

  List<ChipItem<ContactChannel>> get channelOptions => [
    (
      label: 'SMS',
      value: ContactChannel.sms,
      selected: _channel == ContactChannel.sms,
    ),
    (
      label: 'WhatsApp, SMS if it fails',
      value: ContactChannel.whatsapp,
      selected: _channel == ContactChannel.whatsapp,
    ),
  ];

  void setChannel(ContactChannel c) {
    _channel = c;
    notifyListeners();
  }

  Future<void> save() async {
    final errors = <String, String>{};
    if (nameController.text.trim().isEmpty) errors['name'] = 'Enter a name.';
    if (phoneController.text.replaceAll(RegExp(r'\D'), '').length < 10) {
      errors['phone'] = 'Enter a valid phone number.';
    }
    _errors = errors;
    if (errors.isNotEmpty) {
      notifyListeners();
      return;
    }
    final response = await runBusyFuture(
      _api.saveContact(
        EmergencyContact(
          id: contact?.id,
          userId: contact?.userId ?? 0,
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          channel: _channel,
        ),
      ),
    );
    if (response.success) {
      _sheets.dismiss<bool>(true);
    } else if (response.field != null) {
      _errors = {response.field!: response.message!};
      notifyListeners();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
