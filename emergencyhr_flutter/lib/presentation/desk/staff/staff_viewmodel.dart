import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/api/staff_api.dart';
import '../../../data/models/labels.dart';
import '../../facility/invite_sheet/invite_sheet_view.dart';

typedef StaffRow = ({
  String name,
  String detail,
  String role,
  StaffMember member,
});
typedef InviteRow = ({String label, String detail, FacilityInvite invite});

class StaffViewModel extends BaseViewModel {
  StaffViewModel({
    required this.facilityId,
    StaffApi? api,
    SessionService? session,
    SnackbarService? snackbar,
    DialogService? dialogs,
    BottomSheetService? sheets,
  }) : _api = api ?? locator<StaffApi>(),
       _session = session ?? sessionService,
       _snackbar = snackbar ?? snackbarService,
       _dialogs = dialogs ?? dialogService,
       _sheets = sheets ?? bottomSheetService;

  final int facilityId;
  final StaffApi _api;
  final SessionService _session;
  final SnackbarService _snackbar;
  final DialogService _dialogs;
  final BottomSheetService _sheets;

  List<StaffMember> _staff = const [];
  List<FacilityInvite> _invites = const [];

  String? get errorMessage => modelError?.toString();
  bool get isLoading => isBusy && _staff.isEmpty;
  bool get isEmpty => _staff.isEmpty;

  /// Field agents and admins may also invite hospital admins.
  bool get canInviteAdmins => _session.hasAnyRole({
    UserRole.fieldAgent,
    UserRole.platformAdmin,
  });

  List<StaffRow> get staff => [
    for (final m in _staff)
      (
        name: m.name ?? 'Name not set',
        detail:
            '${Formatters.phone(m.phone)} · since ${Formatters.date(m.since)}',
        role: m.role.label,
        member: m,
      ),
  ];

  List<InviteRow> get pendingInvites {
    final now = DateTime.now().toUtc();
    return [
      for (final i in _invites)
        if (i.usedAt == null && i.revokedAt == null && i.expiresAt.isAfter(now))
          (
            label: '${i.role.label} invite · ${i.shortCode}',
            detail: i.phone == null
                ? 'Expires ${Formatters.dateTime(i.expiresAt)}'
                : 'For ${Formatters.phone(i.phone!)} · expires '
                      '${Formatters.dateTime(i.expiresAt)}',
            invite: i,
          ),
    ];
  }

  bool get hasPendingInvites => pendingInvites.isNotEmpty;

  Future<void> load() async {
    setError(null);
    final results = await runBusyFuture(
      Future.wait([_api.list(facilityId), _api.invites(facilityId)]),
    );
    final staffResponse = results[0];
    final inviteResponse = results[1];
    if (staffResponse.success) {
      _staff = staffResponse.data! as List<StaffMember>;
    } else {
      setError(staffResponse.message);
    }
    if (inviteResponse.success) {
      _invites = inviteResponse.data! as List<FacilityInvite>;
    }
    notifyListeners();
  }

  Future<void> inviteDeskStaff() => _openInvite(UserRole.deskStaff);
  Future<void> inviteHospitalAdmin() => _openInvite(UserRole.hospitalAdmin);

  Future<void> _openInvite(UserRole role) async {
    await _sheets.show<void>(
      InviteSheetView(facilityId: facilityId, role: role),
    );
    await load();
  }

  Future<void> remove(StaffMember member) async {
    final confirmed = await _dialogs.confirm(
      title: 'Remove ${member.name ?? 'this person'}?',
      message:
          'They will no longer be able to update this hospital as '
          '${member.role.label.toLowerCase()}.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (!confirmed) return;
    final response = await runBusyFuture(
      _api.remove(facilityId, member.userId, member.role),
    );
    if (response.success) {
      _snackbar.success(message: 'Removed');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }

  Future<void> revoke(FacilityInvite invite) async {
    final response = await runBusyFuture(_api.revokeInvite(invite.id!));
    if (response.success) {
      _snackbar.success(message: 'Invite cancelled');
      await load();
    } else {
      _snackbar.error(message: response.message!);
    }
  }
}
