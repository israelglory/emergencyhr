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

/// A pilot area assigned to a field agent.
abstract class FieldAgentArea
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FieldAgentArea._({
    this.id,
    required this.userId,
    required this.area,
  });

  factory FieldAgentArea({
    int? id,
    required int userId,
    required String area,
  }) = _FieldAgentAreaImpl;

  factory FieldAgentArea.fromJson(Map<String, dynamic> jsonSerialization) {
    return FieldAgentArea(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      area: jsonSerialization['area'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String area;

  /// Returns a shallow copy of this [FieldAgentArea]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FieldAgentArea copyWith({
    int? id,
    int? userId,
    String? area,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FieldAgentArea',
      if (id != null) 'id': id,
      'userId': userId,
      'area': area,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FieldAgentArea',
      if (id != null) 'id': id,
      'userId': userId,
      'area': area,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FieldAgentAreaImpl extends FieldAgentArea {
  _FieldAgentAreaImpl({
    int? id,
    required int userId,
    required String area,
  }) : super._(
         id: id,
         userId: userId,
         area: area,
       );

  /// Returns a shallow copy of this [FieldAgentArea]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FieldAgentArea copyWith({
    Object? id = _Undefined,
    int? userId,
    String? area,
  }) {
    return FieldAgentArea(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      area: area ?? this.area,
    );
  }
}
