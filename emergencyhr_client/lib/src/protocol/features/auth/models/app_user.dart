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
import 'package:emergencyhr_client/src/protocol/protocol.dart' as _ivwsyfsq;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// One account per person. People sign in with email; a phone number can
/// be added later in their profile.
abstract class AppUser
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AppUser._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.email,
    this.phone,
    this.name,
    DateTime? createdAt,
    this.suspendedAt,
    this.suspendReason,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppUser({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    String? email,
    String? phone,
    String? name,
    DateTime? createdAt,
    DateTime? suspendedAt,
    String? suspendReason,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _ivwsyfsq.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      name: jsonSerialization['name'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      suspendedAt: jsonSerialization['suspendedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['suspendedAt'],
            ),
      suspendReason: jsonSerialization['suspendReason'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  /// The Serverpod auth user this account signs in as.
  _iacc.AuthUser? authUser;

  /// Lower-case sign-in email.
  String? email;

  /// Optional E.164 phone number, e.g. +2348012345678. Not verified.
  String? phone;

  String? name;

  DateTime createdAt;

  DateTime? suspendedAt;

  String? suspendReason;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppUser copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? email,
    String? phone,
    String? name,
    DateTime? createdAt,
    DateTime? suspendedAt,
    String? suspendReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (name != null) 'name': name,
      'createdAt': createdAt.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (name != null) 'name': name,
      'createdAt': createdAt.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    String? email,
    String? phone,
    String? name,
    DateTime? createdAt,
    DateTime? suspendedAt,
    String? suspendReason,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         email: email,
         phone: phone,
         name: name,
         createdAt: createdAt,
         suspendedAt: suspendedAt,
         suspendReason: suspendReason,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? name = _Undefined,
    DateTime? createdAt,
    Object? suspendedAt = _Undefined,
    Object? suspendReason = _Undefined,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      name: name is String? ? name : this.name,
      createdAt: createdAt ?? this.createdAt,
      suspendedAt: suspendedAt is DateTime? ? suspendedAt : this.suspendedAt,
      suspendReason: suspendReason is String?
          ? suspendReason
          : this.suspendReason,
    );
  }
}
