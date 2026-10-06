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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../features/auth/models/user_role.dart' as _it1fawf0;

abstract class InvitePreview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvitePreview._({
    required this.facilityName,
    required this.role,
    required this.expiresAt,
    required this.valid,
    this.reason,
  });

  factory InvitePreview({
    required String facilityName,
    required _it1fawf0.UserRole role,
    required DateTime expiresAt,
    required bool valid,
    String? reason,
  }) = _InvitePreviewImpl;

  factory InvitePreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvitePreview(
      facilityName: jsonSerialization['facilityName'] as String,
      role: _it1fawf0.UserRole.fromJson((jsonSerialization['role'] as String)),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      valid: _isc.BoolJsonExtension.fromJson(jsonSerialization['valid']),
      reason: jsonSerialization['reason'] as String?,
    );
  }

  String facilityName;

  _it1fawf0.UserRole role;

  DateTime expiresAt;

  bool valid;

  String? reason;

  /// Returns a shallow copy of this [InvitePreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvitePreview copyWith({
    String? facilityName,
    _it1fawf0.UserRole? role,
    DateTime? expiresAt,
    bool? valid,
    String? reason,
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
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  }) : super._(
         facilityName: facilityName,
         role: role,
         expiresAt: expiresAt,
         valid: valid,
         reason: reason,
       );

  /// Returns a shallow copy of this [InvitePreview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvitePreview copyWith({
    String? facilityName,
    _it1fawf0.UserRole? role,
    DateTime? expiresAt,
    bool? valid,
    Object? reason = _Undefined,
  }) {
    return InvitePreview(
      facilityName: facilityName ?? this.facilityName,
      role: role ?? this.role,
      expiresAt: expiresAt ?? this.expiresAt,
      valid: valid ?? this.valid,
      reason: reason is String? ? reason : this.reason,
    );
  }
}
