import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/admin_api.dart';

typedef ClaimItem = ({
  int id,
  String title,
  String detail,
  String deskBadge,
  StatusTone deskTone,
  ClaimRequest claim,
});

/// Hospitals claiming an existing listing.
class ClaimsViewModel extends BaseViewModel {
  ClaimsViewModel({
    AdminApi? api,
    DialogService? dialogs,
    SnackbarService? snackbar,
    NavigationService? navigation,
  }) : _api = api ?? adminApi,
       _dialogs = dialogs ?? dialogService,
       _snackbar = snackbar ?? snackbarService,
       _navigation = navigation ?? navigationService;

  final AdminApi _api;
  final DialogService _dialogs;
  final SnackbarService _snackbar;
  final NavigationService _navigation;
  List<ClaimQueueItem> _claims = const [];

  String? get errorMessage => modelError?.toString();
  ViewState get state => viewStateOf(
    busy: isBusy,
    hasError: hasError,
    hasData: _claims.isNotEmpty,
  );

  List<ClaimItem> get rows {
    final now = DateTime.now().toUtc();
    return [
      for (final item in _claims)
        (
          id: item.claim.id!,
          title: '${item.claim.contactName} claims ${item.facility.name}',
          detail: [
            item.claimantContact,
            Formatters.ago(item.claim.createdAt, now),
            Formatters.count(item.claim.documents.length, 'document'),
          ].join(' · '),
          deskBadge: item.claim.deskPhoneVerified
              ? 'Desk phone verified'
              : 'Desk phone not verified',
          deskTone: item.claim.deskPhoneVerified
              ? StatusTone.positive
              : StatusTone.warning,
          claim: item.claim,
        ),
    ];
  }

  Future<void> load() async {
    setError(null);
    final response = await runBusyFuture(_api.claims());
    if (response.success) {
      _claims = response.data!;
    } else {
      setError(response.message);
    }
    notifyListeners();
  }

  void openFacility(ClaimItem item) => _navigation.pushNamed<void>(
    AppRoutes.agentFacility(item.claim.facilityId),
  );

  Future<void> approve(ClaimItem item) async {
    final ok = await _dialogs.confirm(
      title: 'Approve this claim?',
      message: '${item.claim.contactName} becomes the hospital admin.',
      confirmLabel: 'Approve',
    );
    if (!ok) return;
    final response = await runBusyFuture(_api.approveClaim(item.id));
    _done(response.success, response.message, 'Claim approved');
  }

  Future<void> reject(ClaimItem item) async {
    final reason = await _dialogs.promptText(
      title: 'Reject claim',
      label: 'Reason',
      confirmLabel: 'Reject',
      destructive: true,
    );
    if (reason == null) return;
    final response = await runBusyFuture(_api.rejectClaim(item.id, reason));
    _done(response.success, response.message, 'Claim rejected');
  }

  void _done(bool ok, String? message, String success) {
    if (ok) {
      _snackbar.success(message: success);
      load();
    } else {
      _snackbar.error(message: message!);
    }
  }
}
