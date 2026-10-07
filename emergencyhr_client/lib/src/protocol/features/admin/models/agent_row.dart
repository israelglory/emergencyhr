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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class AgentRow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgentRow._({
    required this.userId,
    this.name,
    this.email,
    this.phone,
    required this.areas,
    required this.facilityCount,
    required this.active,
  });

  factory AgentRow({
    required int userId,
    String? name,
    String? email,
    String? phone,
    required List<String> areas,
    required int facilityCount,
    required bool active,
  }) = _AgentRowImpl;

  factory AgentRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentRow(
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      areas: _ivwsyfsq.Protocol().deserialize<List<String>>(
        jsonSerialization['areas'],
      ),
      facilityCount: jsonSerialization['facilityCount'] as int,
      active: _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
    );
  }

  int userId;

  String? name;

  String? email;

  String? phone;

  List<String> areas;

  int facilityCount;

  bool active;

  /// Returns a shallow copy of this [AgentRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgentRow copyWith({
    int? userId,
    String? name,
    String? email,
    String? phone,
    List<String>? areas,
    int? facilityCount,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentRow',
      'userId': userId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'areas': areas.toJson(),
      'facilityCount': facilityCount,
      'active': active,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentRow',
      'userId': userId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'areas': areas.toJson(),
      'facilityCount': facilityCount,
      'active': active,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentRowImpl extends AgentRow {
  _AgentRowImpl({
    required int userId,
    String? name,
    String? email,
    String? phone,
    required List<String> areas,
    required int facilityCount,
    required bool active,
  }) : super._(
         userId: userId,
         name: name,
         email: email,
         phone: phone,
         areas: areas,
         facilityCount: facilityCount,
         active: active,
       );

  /// Returns a shallow copy of this [AgentRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgentRow copyWith({
    int? userId,
    Object? name = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    List<String>? areas,
    int? facilityCount,
    bool? active,
  }) {
    return AgentRow(
      userId: userId ?? this.userId,
      name: name is String? ? name : this.name,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      areas: areas ?? this.areas.map((e0) => e0).toList(),
      facilityCount: facilityCount ?? this.facilityCount,
      active: active ?? this.active,
    );
  }
}
