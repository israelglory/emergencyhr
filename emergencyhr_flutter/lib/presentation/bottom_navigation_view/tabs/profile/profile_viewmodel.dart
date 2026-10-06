import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/auth_repo.dart';
import 'package:emergencyhr_flutter/presentation/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/update_bank_details_bottom_sheet.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthRepo _authRepo;

  ProfileViewModel({AuthRepo? authRepo})
    : _authRepo = authRepo ?? authRepoLocator;

  static AuthRepo get authRepoLocator => authRepo;

  String get businessName => appGlobals.user?.businessName?.isNotEmpty == true
      ? appGlobals.user!.businessName!
      : 'BGlow Creation';

  String get ownerName => appGlobals.user?.fullName.isNotEmpty == true
      ? appGlobals.user!.fullName
      : 'Sunday Olaifa';

  String get email => appGlobals.user?.email.isNotEmpty == true
      ? appGlobals.user!.email
      : 'sunday@bglow.com';

  String get phone => appGlobals.user?.branch?.phone.isNotEmpty == true
      ? appGlobals.user!.branch!.phone
      : (appGlobals.user?.branches.isNotEmpty == true &&
            appGlobals.user!.branches.first.phone.isNotEmpty)
      ? appGlobals.user!.branches.first.phone
      : '+2347067376069';

  String get rawPhone => phone.replaceAll('+', '').replaceAll('-', '');

  String get office1 => appGlobals.user?.branch?.address.isNotEmpty == true
      ? appGlobals.user!.branch!.address
      : (appGlobals.user?.branches.isNotEmpty == true &&
            appGlobals.user!.branches.first.address.isNotEmpty)
      ? appGlobals.user!.branches.first.address
      : 'Shop 6, Fasogbon factory, Abegunde, Ibadan';

  String get office2 => (appGlobals.user?.branches.length ?? 0) > 1
      ? appGlobals.user!.branches[1].address
      : 'No 26, Surulere Makun, Sagamu, Ogun state';

  String get bankName =>
      appGlobals.user?.bankDetails?.bankName.isNotEmpty == true
      ? appGlobals.user!.bankDetails!.bankName
      : 'Moniepoint MFB';

  String get accountNumber =>
      appGlobals.user?.bankDetails?.accountNumber.isNotEmpty == true
      ? appGlobals.user!.bankDetails!.accountNumber
      : '7067376069';

  String get accountName =>
      appGlobals.user?.bankDetails?.accountName.isNotEmpty == true
      ? appGlobals.user!.bankDetails!.accountName
      : 'Bglow creations ent.';

  final String appVersion = '1.0.1';

  void openUpdateBankDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UpdateBankDetailsBottomSheet(
        onSaved: () => notifyListeners(),
      ),
    );
  }

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    snackbarService.success(message: '$label copied to clipboard!');
  }

  Future<void> callBusiness() async {
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        copyToClipboard(phone, 'Phone number');
      }
    } catch (e) {
      copyToClipboard(phone, 'Phone number');
    }
  }

  Future<void> emailBusiness() async {
    final uri = Uri.parse('mailto:$email');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        copyToClipboard(email, 'Email address');
      }
    } catch (e) {
      copyToClipboard(email, 'Email address');
    }
  }

  Future<void> shareApp() async {
    try {
      await Share.share(
        'Check out $businessName - Fashion, Custom Designs, and Invoicing app!\nContact: $phone',
      );
    } catch (e) {
      // Ignored
    }
  }

  void logout() {
    _authRepo.logOut();
    snackbarService.success(message: 'Signed out successfully');
    navigationService.pushAndRemoveUntil(const LoginView());
  }
}
