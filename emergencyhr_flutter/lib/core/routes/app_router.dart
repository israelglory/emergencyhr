import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/models/route_args.dart';
import '../../presentation/admin/admin_shell/admin_shell_view.dart';
import '../../presentation/agent/agent_shell/agent_shell_view.dart';
import '../../presentation/auth/accept_invite/accept_invite_view.dart';
import '../../presentation/auth/sign_in/sign_in_view.dart';
import '../../presentation/auth/create_account/create_account_view.dart';
import '../../presentation/auth/reset_password/reset_password_view.dart';
import '../../presentation/common/not_found/not_found_view.dart';
import '../../presentation/desk/desk_shell/desk_shell_view.dart';
import '../../presentation/design/design_view.dart';
import '../../presentation/emergency/after_action/after_action_view.dart';
import '../../presentation/emergency/area_picker/area_picker_view.dart';
import '../../presentation/emergency/results/results_view.dart';
import '../../presentation/emergency/type_filter/type_filter_view.dart';
import '../../presentation/facility/editor/facility_editor_view.dart';
import '../../presentation/first_aid/card/first_aid_card_view.dart';
import '../../presentation/first_aid/list/first_aid_list_view.dart';
import '../../presentation/facility/pages/facility_pages.dart';
import '../../presentation/join/claim/claim_view.dart';
import '../../presentation/join/join_hospital/join_hospital_view.dart';
import '../../presentation/join/join_request/join_request_view.dart';
import '../../presentation/profile/medical/medical_profile_view.dart';
import '../../presentation/public/hospital_detail/hospital_detail_view.dart';
import '../../presentation/public/tabs/public_tabs_view.dart';
import '../services/public_tabs_service.dart';
import 'app_routes.dart';

/// Maps URLs to views. Access checks happen in viewmodels and, always, on
/// the server.
abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? AppRoutes.home);
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (_) => _page(uri, settings.arguments),
    );
  }

  static Widget _page(Uri uri, Object? args) {
    final s = uri.pathSegments.where((p) => p.isNotEmpty).toList();
    final path = '/${s.join('/')}';
    final next = uri.queryParameters['next'];
    int? idAt(int i) => s.length > i ? int.tryParse(s[i]) : null;

    switch (path) {
      case AppRoutes.home:
        return const PublicTabsView();
      case AppRoutes.signIn:
        return SignInView(next: next);
      case AppRoutes.createAccount:
        return CreateAccountView(next: next);
      case AppRoutes.resetPassword:
        return ResetPasswordView(email: args is String ? args : null);
      case AppRoutes.profile:
        return const PublicTabsView(initial: PublicTab.profile);
      case AppRoutes.medicalProfile:
        return const MedicalProfileView();
      case AppRoutes.emergency:
        return ResultsView(args: args is EmergencyResultsArgs ? args : null);
      case AppRoutes.emergencyArea:
        return const AreaPickerView();
      case AppRoutes.emergencyType:
        return TypeFilterView(
          current: args is EmergencyType ? args : EmergencyType.skipped,
        );
      case AppRoutes.emergencyAfter:
        return const AfterActionView();
      case AppRoutes.firstAid:
        return const FirstAidListView();
      case AppRoutes.assistant:
        return const PublicTabsView(initial: PublicTab.assistant);
      case AppRoutes.desk:
        return const DeskShellView();
      case AppRoutes.agent:
        return const AgentShellView();
      case AppRoutes.admin:
        return const AdminShellView();
      case AppRoutes.joinHospital:
        return const JoinHospitalView();
      case AppRoutes.joinRequest:
        return const JoinRequestView();
      case AppRoutes.facilityNew:
        return FacilityEditorView(
          args: args is FacilityEditorArgs ? args : const FacilityEditorArgs(),
        );
      case AppRoutes.design when kDebugMode:
        return const DesignView();
    }

    // /invite/:code
    if (s.length == 2 && s[0] == 'invite') return AcceptInviteView(code: s[1]);

    // /hospitals/join/claim/:id
    if (s.length == 4 && path.startsWith(AppRoutes.claimBase)) {
      final id = idAt(3);
      if (id != null) {
        return ClaimView(
          args: args is ClaimArgs ? args : ClaimArgs(facilityId: id),
        );
      }
    }

    // /first-aid/:type
    if (s.length == 2 && s[0] == 'first-aid') {
      return FirstAidCardView(typeName: s[1]);
    }

    // /hospitals/:id
    if (s.length == 2 && s[0] == 'hospitals') {
      final id = idAt(1);
      if (id != null) return HospitalDetailView(facilityId: id);
    }

    // /agent/facilities/:id
    if (s.length == 3 && s[0] == 'agent' && s[1] == 'facilities') {
      final id = idAt(2);
      if (id != null) return FacilitySetupPage(facilityId: id);
    }

    // /facilities/:id/{edit,staff,practice}
    if (s.length == 3 && s[0] == 'facilities') {
      final id = idAt(1);
      if (id != null) {
        switch (s[2]) {
          case 'edit':
            return FacilityEditorView(args: FacilityEditorArgs(facilityId: id));
          case 'staff':
            return FacilityStaffPage(facilityId: id);
          case 'practice':
            return FacilityPracticePage(facilityId: id);
        }
      }
    }
    return const NotFoundView();
  }
}
