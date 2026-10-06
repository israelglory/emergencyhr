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

/// Audit log entry for every status change. oldValue and newValue are JSON.
abstract class StatusChangeLog
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StatusChangeLog._({
    this.id,
    required this.facilityId,
    this.userId,
    this.oldValue,
    required this.newValue,
    bool? practice,
    required this.at,
  }) : practice = practice ?? false;

  factory StatusChangeLog({
    int? id,
    required int facilityId,
    int? userId,
    String? oldValue,
    required String newValue,
    bool? practice,
    required DateTime at,
  }) = _StatusChangeLogImpl;

  factory StatusChangeLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatusChangeLog(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      userId: jsonSerialization['userId'] as int?,
      oldValue: jsonSerialization['oldValue'] as String?,
      newValue: jsonSerialization['newValue'] as String,
      practice: jsonSerialization['practice'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['practice']),
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int facilityId;

  int? userId;

  String? oldValue;

  String newValue;

  /// Training-mode updates are logged but never shown to the public.
  bool practice;

  DateTime at;

  /// Returns a shallow copy of this [StatusChangeLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StatusChangeLog copyWith({
    int? id,
    int? facilityId,
    int? userId,
    String? oldValue,
    String? newValue,
    bool? practice,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StatusChangeLog',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      if (oldValue != null) 'oldValue': oldValue,
      'newValue': newValue,
      'practice': practice,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StatusChangeLog',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      if (oldValue != null) 'oldValue': oldValue,
      'newValue': newValue,
      'practice': practice,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StatusChangeLogImpl extends StatusChangeLog {
  _StatusChangeLogImpl({
    int? id,
    required int facilityId,
    int? userId,
    String? oldValue,
    required String newValue,
    bool? practice,
    required DateTime at,
  }) : super._(
         id: id,
         facilityId: facilityId,
         userId: userId,
         oldValue: oldValue,
         newValue: newValue,
         practice: practice,
         at: at,
       );

  /// Returns a shallow copy of this [StatusChangeLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StatusChangeLog copyWith({
    Object? id = _Undefined,
    int? facilityId,
    Object? userId = _Undefined,
    Object? oldValue = _Undefined,
    String? newValue,
    bool? practice,
    DateTime? at,
  }) {
    return StatusChangeLog(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      userId: userId is int? ? userId : this.userId,
      oldValue: oldValue is String? ? oldValue : this.oldValue,
      newValue: newValue ?? this.newValue,
      practice: practice ?? this.practice,
      at: at ?? this.at,
    );
  }
}
