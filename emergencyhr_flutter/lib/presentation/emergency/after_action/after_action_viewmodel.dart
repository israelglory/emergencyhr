import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/profile_api.dart';
import '../../first_aid/components/first_aid_content.dart';
import '../../first_aid/first_aid_presenter.dart';
import '../report_sheet/report_sheet_view.dart';

enum FamilyAlertState { signedOut, loading, noContacts, ready, sent }

typedef AlertRow = ({
  String name,
  String detail,
  StatusTone tone,
  String label,
});

/// After Call or Directions: notify family, first aid, report.
class AfterActionViewModel extends ReactiveViewModel {
  AfterActionViewModel({
    ProfileApi? profile,
    EmergencySessionService? emergency,
    SessionService? session,
    FirstAidService? firstAid,
    NavigationService? navigation,
    LauncherService? launcher,
    PhoneCallService? calls,
    SnackbarService? snackbar,
    BottomSheetService? sheets,
  }) : _profile = profile ?? profileApi,
       _emergency = emergency ?? emergencySession,
       _session = session ?? sessionService,
       _firstAid = firstAid ?? firstAidService,
       _navigation = navigation ?? navigationService,
       _launcher = launcher ?? launcherService,
       _calls = calls ?? phoneCallService,
       _snackbar = snackbar ?? snackbarService,
       _sheets = sheets ?? bottomSheetService;

  final ProfileApi _profile;
  final EmergencySessionService _emergency;
  final SessionService _session;
  final FirstAidService _firstAid;
  final NavigationService _navigation;
  final LauncherService _launcher;
  final PhoneCallService _calls;
  final SnackbarService _snackbar;
  final BottomSheetService _sheets;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session, _emergency];

  List<EmergencyContact>? _contacts;
  FamilyAlertResult? _alert;
  static const _alertKey = 'alert';

  EmergencyResult? get _hospital => _emergency.actedOn;

  String get heading => switch (_emergency.action) {
    EmergencyAction.call => 'Calling ${_hospital?.name ?? 'the hospital'}',
    EmergencyAction.directions =>
      'Heading to ${_hospital?.name ?? 'the hospital'}',
    EmergencyAction.call112 => 'Calling 112',
    _ => 'Getting help',
  };

  static const tip =
      'If the hospital cannot take you, go back and choose another one.';

  // Family alert
  bool get isSignedIn => _session.isSignedIn;

  FamilyAlertState get familyState => !isSignedIn
      ? FamilyAlertState.signedOut
      : !contactsLoaded
      ? FamilyAlertState.loading
      : !hasContacts
      ? FamilyAlertState.noContacts
      : alertSent
      ? FamilyAlertState.sent
      : FamilyAlertState.ready;
  bool get hasContacts => (_contacts ?? const []).isNotEmpty;
  bool get contactsLoaded => _contacts != null;
  bool get isAlerting => busy(_alertKey);
  bool get alertSent => _alert != null;
  String get alertButtonLabel => 'Notify family (${_contacts?.length ?? 0})';

  List<AlertRow> get alertRows => [
    for (final r in _alert?.results ?? const <ContactAlertResult>[])
      (
        name: r.name,
        detail: Formatters.phone(r.phone),
        tone: r.sentVia == null ? StatusTone.critical : StatusTone.positive,
        label: switch (r.sentVia) {
          ContactChannel.sms => 'Sent by SMS',
          ContactChannel.whatsapp => 'Sent on WhatsApp',
          null => 'Not sent',
        },
      ),
  ];

  List<String> get _failedPhones => [
    for (final r in _alert?.results ?? const <ContactAlertResult>[])
      if (r.sentVia == null) r.phone,
  ];

  bool get showSmsFallback =>
      _failedPhones.isNotEmpty && _launcher.canComposeSms;

  // First aid
  FirstAidDisplay? get firstAid {
    final card = _firstAid.forType(_emergency.type);
    return card == null ? null : FirstAidPresenter.display(card);
  }

  // Report
  bool get canReport => isSignedIn && _hospital != null;
  bool get canCallAgain => _hospital?.deskPhone != null;

  Future<void> onReady() async {
    if (!isSignedIn) return;
    final response = await _profile.contacts();
    _contacts = response.data ?? const [];
    notifyListeners();
  }

  Future<void> notifyFamily() async {
    final s = _emergency.search;
    if (s == null) return;
    final response = await runBusyFuture(
      _profile.notifyFamily(s.sessionId, s.accessToken),
      busyObject: _alertKey,
    );
    if (response.success) {
      _alert = response.data;
    } else {
      _snackbar.error(message: response.message!);
    }
    notifyListeners();
  }

  /// When the server could not send, open the phone's own SMS app.
  Future<void> sendFromPhone() async {
    final message = _alert?.message;
    if (message == null) return;
    if (!await _launcher.composeSms(_failedPhones, message)) {
      _snackbar.error(message: 'Could not open your SMS app.');
    }
  }

  void addContacts() => _navigation.pushNamed<void>(AppRoutes.profile);

  void signIn() => _navigation.pushNamed<void>(
    AppRoutes.signInWithNext(AppRoutes.emergencyAfter),
  );

  Future<void> report() async {
    final h = _hospital;
    if (h == null) return;
    await _sheets.show<void>(
      ReportSheetView(facilityId: h.facilityId, facilityName: h.name),
    );
  }

  Future<void> callAgain() async {
    final h = _hospital;
    if (h?.deskPhone == null) return;
    await _calls.callNumber(number: h!.deskPhone!, title: 'Call ${h.name}');
  }

  Future<void> call112() => _calls.callNumber(number: '112', title: 'Call 112');

  void backToResults() =>
      _navigation.popUntilOrShow(AppRoutes.emergencyResults);

  VoidCallback? get onCallAgain => canCallAgain ? callAgain : null;
}
