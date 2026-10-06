/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:emergencyhr_server/src/generated/protocol.dart' as _ilvcm0hz;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../features/auth/models/app_user.dart' as _iqm2x4vz;
import '../../../features/auth/models/role_assignment.dart' as _irnedntr;
import '../../../features/facilities/models/facility_summary.dart' as _i66m7xcg;

/// The signed-in user with their roles and the facilities those roles cover.
abstract class CurrentUser
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CurrentUser._({
    required this.user,
    required this.roles,
    required this.facilities,
  });

  factory CurrentUser({
    required _iqm2x4vz.AppUser user,
    required List<_irnedntr.RoleAssignment> roles,
    required List<_i66m7xcg.FacilitySummary> facilities,
  }) = _CurrentUserImpl;

  factory CurrentUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return CurrentUser(
      user: _ilvcm0hz.Protocol().deserialize<_iqm2x4vz.AppUser>(
        jsonSerialization['user'],
      ),
      roles: _ilvcm0hz.Protocol().deserialize<List<_irnedntr.RoleAssignment>>(
        jsonSerialization['roles'],
      ),
      facilities: _ilvcm0hz.Protocol()
          .deserialize<List<_i66m7xcg.FacilitySummary>>(
            jsonSerialization['facilities'],
          ),
    );
  }

  _iqm2x4vz.AppUser user;

  List<_irnedntr.RoleAssignment> roles;

  List<_i66m7xcg.FacilitySummary> facilities;

  /// Returns a shallow copy of this [CurrentUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CurrentUser copyWith({
    _iqm2x4vz.AppUser? user,
    List<_irnedntr.RoleAssignment>? roles,
    List<_i66m7xcg.FacilitySummary>? facilities,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CurrentUser',
      'user': user.toJson(),
      'roles': roles.toJson(valueToJson: (v) => v.toJson()),
      'facilities': facilities.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CurrentUser',
      'user': user.toJsonForProtocol(),
      'roles': roles.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'facilities': facilities.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CurrentUserImpl extends CurrentUser {
  _CurrentUserImpl({
    required _iqm2x4vz.AppUser user,
    required List<_irnedntr.RoleAssignment> roles,
    required List<_i66m7xcg.FacilitySummary> facilities,
  }) : super._(
         user: user,
         roles: roles,
         facilities: facilities,
       );

  /// Returns a shallow copy of this [CurrentUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CurrentUser copyWith({
    _iqm2x4vz.AppUser? user,
    List<_irnedntr.RoleAssignment>? roles,
    List<_i66m7xcg.FacilitySummary>? facilities,
  }) {
    return CurrentUser(
      user: user ?? this.user.copyWith(),
      roles: roles ?? this.roles.map((e0) => e0.copyWith()).toList(),
      facilities:
          facilities ?? this.facilities.map((e0) => e0.copyWith()).toList(),
    );
  }
}
