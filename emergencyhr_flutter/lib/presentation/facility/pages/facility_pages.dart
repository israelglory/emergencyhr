import 'package:flutter/material.dart';

import '../../../core/cores.dart';
import '../../desk/staff/staff_view.dart';
import '../../desk/status/status_view.dart';
import '../setup/facility_setup_view.dart';

/// Full-screen wrappers so these bodies have their own URLs.
class FacilityStaffPage extends StatelessWidget {
  const FacilityStaffPage({super.key, required this.facilityId});

  final int facilityId;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Staff and invites',
    scrollable: false,
    padding: EdgeInsets.zero,
    body: StaffView(facilityId: facilityId),
  );
}

class FacilityPracticePage extends StatelessWidget {
  const FacilityPracticePage({super.key, required this.facilityId});

  final int facilityId;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Practice update',
    scrollable: false,
    padding: EdgeInsets.zero,
    body: StatusView(facilityId: facilityId, startInPractice: true),
  );
}

class FacilitySetupPage extends StatelessWidget {
  const FacilitySetupPage({super.key, required this.facilityId});

  final int facilityId;

  @override
  Widget build(BuildContext context) => AppPage(
    title: 'Onboarding',
    scrollable: false,
    padding: EdgeInsets.zero,
    maxWidth: AppSizes.wideContentMaxWidth,
    body: FacilitySetupView(facilityId: facilityId),
  );
}
