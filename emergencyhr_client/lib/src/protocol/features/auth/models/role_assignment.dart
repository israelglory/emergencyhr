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

/// A role held by a user. facilityId is set for facility-scoped roles.
abstract class RoleAssignment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RoleAssignment._({
    this.id,
    required this.userId,
    required this.role,
    this.facilityId,
    DateTime? createdAt,
    this.createdByUserId,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RoleAssignment({
    int? id,
    required int userId,
    required _it1fawf0.UserRole role,
    int? facilityId,
    DateTime? createdAt,
    int? createdByUserId,
  }) = _RoleAssignmentImpl;

  factory RoleAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoleAssignment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      role: _it1fawf0.UserRole.fromJson((jsonSerialization['role'] as String)),
      facilityId: jsonSerialization['facilityId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      createdByUserId: jsonSerialization['createdByUserId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _it1fawf0.UserRole role;

  int? facilityId;

  DateTime createdAt;

  int? createdByUserId;

  /// Returns a shallow copy of this [RoleAssignment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RoleAssignment copyWith({
    int? id,
    int? userId,
    _it1fawf0.UserRole? role,
    int? facilityId,
    DateTime? createdAt,
    int? createdByUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoleAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      'role': role.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'createdAt': createdAt.toJson(),
      if (createdByUserId != null) 'createdByUserId': createdByUserId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoleAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      'role': role.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'createdAt': createdAt.toJson(),
      if (createdByUserId != null) 'createdByUserId': createdByUserId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoleAssignmentImpl extends RoleAssignment {
  _RoleAssignmentImpl({
    int? id,
    required int userId,
    required _it1fawf0.UserRole role,
    int? facilityId,
    DateTime? createdAt,
    int? createdByUserId,
  }) : super._(
         id: id,
         userId: userId,
         role: role,
         facilityId: facilityId,
         createdAt: createdAt,
         createdByUserId: createdByUserId,
       );

  /// Returns a shallow copy of this [RoleAssignment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RoleAssignment copyWith({
    Object? id = _Undefined,
    int? userId,
    _it1fawf0.UserRole? role,
    Object? facilityId = _Undefined,
    DateTime? createdAt,
    Object? createdByUserId = _Undefined,
  }) {
    return RoleAssignment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      createdAt: createdAt ?? this.createdAt,
      createdByUserId: createdByUserId is int?
          ? createdByUserId
          : this.createdByUserId,
    );
  }
}
