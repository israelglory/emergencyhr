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
import '../../../features/auth/models/user_role.dart' as _it1fawf0;

abstract class UserRow
    implements _is.SerializableModel, _is.ProtocolSerialization {
  UserRow._({
    required this.userId,
    this.name,
    this.email,
    this.phone,
    required this.roles,
    required this.suspended,
  });

  factory UserRow({
    required int userId,
    String? name,
    String? email,
    String? phone,
    required List<_it1fawf0.UserRole> roles,
    required bool suspended,
  }) = _UserRowImpl;

  factory UserRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRow(
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      roles: _ilvcm0hz.Protocol().deserialize<List<_it1fawf0.UserRole>>(
        jsonSerialization['roles'],
      ),
      suspended: _is.BoolJsonExtension.fromJson(jsonSerialization['suspended']),
    );
  }

  int userId;

  String? name;

  String? email;

  String? phone;

  List<_it1fawf0.UserRole> roles;

  bool suspended;

  /// Returns a shallow copy of this [UserRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserRow copyWith({
    int? userId,
    String? name,
    String? email,
    String? phone,
    List<_it1fawf0.UserRole>? roles,
    bool? suspended,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRow',
      'userId': userId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'roles': roles.toJson(valueToJson: (v) => v.toJson()),
      'suspended': suspended,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRow',
      'userId': userId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'roles': roles.toJson(valueToJson: (v) => v.toJson()),
      'suspended': suspended,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRowImpl extends UserRow {
  _UserRowImpl({
    required int userId,
    String? name,
    String? email,
    String? phone,
    required List<_it1fawf0.UserRole> roles,
    required bool suspended,
  }) : super._(
         userId: userId,
         name: name,
         email: email,
         phone: phone,
         roles: roles,
         suspended: suspended,
       );

  /// Returns a shallow copy of this [UserRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserRow copyWith({
    int? userId,
    Object? name = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    List<_it1fawf0.UserRole>? roles,
    bool? suspended,
  }) {
    return UserRow(
      userId: userId ?? this.userId,
      name: name is String? ? name : this.name,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
      suspended: suspended ?? this.suspended,
    );
  }
}
