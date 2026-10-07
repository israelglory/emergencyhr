import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/shell_kind.dart';

enum DeskTab { status, audit, staff, hospital }

typedef FacilityOption = ({int id, String name, bool selected});

class DeskShellViewModel extends ReactiveViewModel {
  DeskShellViewModel({
    SessionService? session,
    AccessService? access,
    NavigationService? navigation,
    BottomSheetService? sheets,
  }) : _session = session ?? sessionService,
       _access = access ?? accessService,
       _navigation = navigation ?? navigationService,
       _sheetsOverride = sheets;

  final SessionService _session;
  final AccessService _access;
  final NavigationService _navigation;
  final BottomSheetService? _sheetsOverride;
  BottomSheetService get _sheets => _sheetsOverride ?? bottomSheetService;

  @override
  List<ListenableServiceMixin> get listenableServices => [_session];

  bool _allowed = false;
  int _index = 0;

  bool get isReady => _allowed && facilityId != null;
  int? get facilityId => _session.activeFacilityId;

  List<FacilitySummary> get _facilities =>
      _session.facilitiesFor(ShellKind.desk.roles);

  String get title =>
      _facilities.where((f) => f.id == facilityId).firstOrNull?.name ??
      'Hospital desk';
  static const subtitle = 'Hospital desk';

  bool get isHospitalAdmin =>
      facilityId != null &&
      _session.hasFacilityRole(facilityId!, {UserRole.hospitalAdmin});

  List<DeskTab> get tabs => [
    DeskTab.status,
    DeskTab.audit,
    if (isHospitalAdmin) DeskTab.staff,
    if (isHospitalAdmin) DeskTab.hospital,
  ];

  List<ShellDestination> get destinations => [
    for (final t in tabs)
      switch (t) {
        DeskTab.status => (icon: Icons.monitor_heart_outlined, label: 'Status'),
        DeskTab.audit => (icon: Icons.history, label: 'Audit log'),
        DeskTab.staff => (icon: Icons.group_outlined, label: 'Staff'),
        DeskTab.hospital => (icon: Icons.domain_outlined, label: 'Hospital'),
      },
  ];

  int get selectedIndex => _index.clamp(0, tabs.length - 1);
  DeskTab get currentTab => tabs[selectedIndex];

  bool get showFacilitySwitcher => _facilities.length > 1;
  List<FacilityOption> get facilityOptions => [
    for (final f in _facilities)
      (id: f.id, name: f.name, selected: f.id == facilityId),
  ];

  Future<void> onReady() async {
    _allowed = await _access.ensure(ShellKind.desk, returnTo: AppRoutes.desk);
    notifyListeners();
  }

  void select(int index) {
    _index = index;
    notifyListeners();
  }

  void selectFacility(int id) {
    _index = 0;
    _session.selectFacility(id);
  }

  void goHome() => _navigation.clearStackAndShow<void>(AppRoutes.home);

  void openAuditLog() => select(tabs.indexOf(DeskTab.audit));

  /// Tapping the hospital name when the person works at more than one.
  Future<void> switchHospital() => _sheets.show<void>(
    OptionPickerSheet<int>(
      title: 'Switch hospital',
      options: [
        for (final f in facilityOptions)
          (label: f.name, detail: f.selected ? 'Current' : null, value: f.id),
      ],
      onPick: (id) {
        _navigation.pop<void>();
        selectFacility(id);
      },
    ),
  );
}
