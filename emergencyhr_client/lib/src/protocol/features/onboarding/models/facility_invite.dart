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

/// Single-use invite for a facility role. Only the token hash is stored.
abstract class FacilityInvite
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilityInvite._({
    this.id,
    required this.facilityId,
    required this.role,
    this.phone,
    required this.shortCode,
    required this.createdByUserId,
    required this.expiresAt,
    this.usedAt,
    this.usedByUserId,
    this.revokedAt,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory FacilityInvite({
    int? id,
    required int facilityId,
    required _it1fawf0.UserRole role,
    String? phone,
    required String shortCode,
    required int createdByUserId,
    required DateTime expiresAt,
    DateTime? usedAt,
    int? usedByUserId,
    DateTime? revokedAt,
    DateTime? createdAt,
  }) = _FacilityInviteImpl;

  factory FacilityInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityInvite(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      role: _it1fawf0.UserRole.fromJson((jsonSerialization['role'] as String)),
      phone: jsonSerialization['phone'] as String?,
      shortCode: jsonSerialization['shortCode'] as String,
      createdByUserId: jsonSerialization['createdByUserId'] as int,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      usedAt: jsonSerialization['usedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['usedAt']),
      usedByUserId: jsonSerialization['usedByUserId'] as int?,
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int facilityId;

  _it1fawf0.UserRole role;

  String? phone;

  String shortCode;

  int createdByUserId;

  DateTime expiresAt;

  DateTime? usedAt;

  int? usedByUserId;

  DateTime? revokedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [FacilityInvite]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilityInvite copyWith({
    int? id,
    int? facilityId,
    _it1fawf0.UserRole? role,
    String? phone,
    String? shortCode,
    int? createdByUserId,
    DateTime? expiresAt,
    DateTime? usedAt,
    int? usedByUserId,
    DateTime? revokedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityInvite',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'role': role.toJson(),
      if (phone != null) 'phone': phone,
      'shortCode': shortCode,
      'createdByUserId': createdByUserId,
      'expiresAt': expiresAt.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      if (usedByUserId != null) 'usedByUserId': usedByUserId,
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityInvite',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'role': role.toJson(),
      if (phone != null) 'phone': phone,
      'shortCode': shortCode,
      'createdByUserId': createdByUserId,
      'expiresAt': expiresAt.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      if (usedByUserId != null) 'usedByUserId': usedByUserId,
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityInviteImpl extends FacilityInvite {
  _FacilityInviteImpl({
    int? id,
    required int facilityId,
    required _it1fawf0.UserRole role,
    String? phone,
    required String shortCode,
    required int createdByUserId,
    required DateTime expiresAt,
    DateTime? usedAt,
    int? usedByUserId,
    DateTime? revokedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         role: role,
         phone: phone,
         shortCode: shortCode,
         createdByUserId: createdByUserId,
         expiresAt: expiresAt,
         usedAt: usedAt,
         usedByUserId: usedByUserId,
         revokedAt: revokedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FacilityInvite]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilityInvite copyWith({
    Object? id = _Undefined,
    int? facilityId,
    _it1fawf0.UserRole? role,
    Object? phone = _Undefined,
    String? shortCode,
    int? createdByUserId,
    DateTime? expiresAt,
    Object? usedAt = _Undefined,
    Object? usedByUserId = _Undefined,
    Object? revokedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return FacilityInvite(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      role: role ?? this.role,
      phone: phone is String? ? phone : this.phone,
      shortCode: shortCode ?? this.shortCode,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      expiresAt: expiresAt ?? this.expiresAt,
      usedAt: usedAt is DateTime? ? usedAt : this.usedAt,
      usedByUserId: usedByUserId is int? ? usedByUserId : this.usedByUserId,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
