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

abstract class StaffMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StaffMember._({
    required this.userId,
    this.name,
    required this.phone,
    required this.role,
    required this.since,
  });

  factory StaffMember({
    required int userId,
    String? name,
    required String phone,
    required _it1fawf0.UserRole role,
    required DateTime since,
  }) = _StaffMemberImpl;

  factory StaffMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return StaffMember(
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String?,
      phone: jsonSerialization['phone'] as String,
      role: _it1fawf0.UserRole.fromJson((jsonSerialization['role'] as String)),
      since: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['since']),
    );
  }

  int userId;

  String? name;

  String phone;

  _it1fawf0.UserRole role;

  DateTime since;

  /// Returns a shallow copy of this [StaffMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StaffMember copyWith({
    int? userId,
    String? name,
    String? phone,
    _it1fawf0.UserRole? role,
    DateTime? since,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StaffMember',
      'userId': userId,
      if (name != null) 'name': name,
      'phone': phone,
      'role': role.toJson(),
      'since': since.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StaffMember',
      'userId': userId,
      if (name != null) 'name': name,
      'phone': phone,
      'role': role.toJson(),
      'since': since.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffMemberImpl extends StaffMember {
  _StaffMemberImpl({
    required int userId,
    String? name,
    required String phone,
    required _it1fawf0.UserRole role,
    required DateTime since,
  }) : super._(
         userId: userId,
         name: name,
         phone: phone,
         role: role,
         since: since,
       );

  /// Returns a shallow copy of this [StaffMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StaffMember copyWith({
    int? userId,
    Object? name = _Undefined,
    String? phone,
    _it1fawf0.UserRole? role,
    DateTime? since,
  }) {
    return StaffMember(
      userId: userId ?? this.userId,
      name: name is String? ? name : this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      since: since ?? this.since,
    );
  }
}
