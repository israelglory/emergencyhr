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
import 'package:serverpod/serverpod.dart' as _is;
import '../../../features/auth/models/user_role.dart' as _it1fawf0;

abstract class InvitePreview
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InvitePreview._({
    required this.facilityName,
    required this.role,
    required this.expiresAt,
    required this.valid,
    this.reason,
    this.invitedBy,
  });

  factory InvitePreview({
    required String facilityName,
    required _it1fawf0.UserRole role,
    required DateTime expiresAt,
    required bool valid,
    String? reason,
    String? invitedBy,
  }) = _InvitePreviewImpl;

  factory InvitePreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvitePreview(
      facilityName: jsonSerialization['facilityName'] as String,
      role: _it1fawf0.UserRole.fromJson((jsonSerialization['role'] as String)),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      valid: _is.BoolJsonExtension.fromJson(jsonSerialization['valid']),
      reason: jsonSerialization['reason'] as String?,
      invitedBy: jsonSerialization['invitedBy'] as String?,
    );
  }

  String facilityName;

  _it1fawf0.UserRole role;

  DateTime expiresAt;

  bool valid;

  String? reason;

  /// Name of the person who sent the invite, when they gave one.
  String? invitedBy;

  /// Returns a shallow copy of this [InvitePreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InvitePreview copyWith({
    String? facilityName,
    _it1fawf0.UserRole? role,
    DateTime? expiresAt,
    bool? valid,
    String? reason,
    String? invitedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvitePreview',
      'facilityName': facilityName,
      'role': role.toJson(),
      'expiresAt': expiresAt.toJson(),
      'valid': valid,
      if (reason != null) 'reason': reason,
      if (invitedBy != null) 'invitedBy': invitedBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvitePreview',
      'facilityName': facilityName,
      'role': role.toJson(),
      'expiresAt': expiresAt.toJson(),
      'valid': valid,
      if (reason != null) 'reason': reason,
      if (invitedBy != null) 'invitedBy': invitedBy,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvitePreviewImpl extends InvitePreview {
  _InvitePreviewImpl({
    required String facilityName,
    required _it1fawf0.UserRole role,
    required DateTime expiresAt,
    required bool valid,
    String? reason,
    String? invitedBy,
  }) : super._(
         facilityName: facilityName,
         role: role,
         expiresAt: expiresAt,
         valid: valid,
         reason: reason,
         invitedBy: invitedBy,
       );

  /// Returns a shallow copy of this [InvitePreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InvitePreview copyWith({
    String? facilityName,
    _it1fawf0.UserRole? role,
    DateTime? expiresAt,
    bool? valid,
    Object? reason = _Undefined,
    Object? invitedBy = _Undefined,
  }) {
    return InvitePreview(
      facilityName: facilityName ?? this.facilityName,
      role: role ?? this.role,
      expiresAt: expiresAt ?? this.expiresAt,
      valid: valid ?? this.valid,
      reason: reason is String? ? reason : this.reason,
      invitedBy: invitedBy is String? ? invitedBy : this.invitedBy,
    );
  }
}
