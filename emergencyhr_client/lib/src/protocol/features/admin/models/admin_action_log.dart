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

/// Every admin and agent action, with actor and time.
abstract class AdminActionLog
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminActionLog._({
    this.id,
    required this.actorUserId,
    required this.action,
    required this.targetType,
    required this.targetId,
    this.reason,
    required this.at,
  });

  factory AdminActionLog({
    int? id,
    required int actorUserId,
    required String action,
    required String targetType,
    required int targetId,
    String? reason,
    required DateTime at,
  }) = _AdminActionLogImpl;

  factory AdminActionLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminActionLog(
      id: jsonSerialization['id'] as int?,
      actorUserId: jsonSerialization['actorUserId'] as int,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      reason: jsonSerialization['reason'] as String?,
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int actorUserId;

  String action;

  String targetType;

  int targetId;

  String? reason;

  DateTime at;

  /// Returns a shallow copy of this [AdminActionLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminActionLog copyWith({
    int? id,
    int? actorUserId,
    String? action,
    String? targetType,
    int? targetId,
    String? reason,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminActionLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (reason != null) 'reason': reason,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminActionLog',
      if (id != null) 'id': id,
      'actorUserId': actorUserId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (reason != null) 'reason': reason,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminActionLogImpl extends AdminActionLog {
  _AdminActionLogImpl({
    int? id,
    required int actorUserId,
    required String action,
    required String targetType,
    required int targetId,
    String? reason,
    required DateTime at,
  }) : super._(
         id: id,
         actorUserId: actorUserId,
         action: action,
         targetType: targetType,
         targetId: targetId,
         reason: reason,
         at: at,
       );

  /// Returns a shallow copy of this [AdminActionLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminActionLog copyWith({
    Object? id = _Undefined,
    int? actorUserId,
    String? action,
    String? targetType,
    int? targetId,
    Object? reason = _Undefined,
    DateTime? at,
  }) {
    return AdminActionLog(
      id: id is int? ? id : this.id,
      actorUserId: actorUserId ?? this.actorUserId,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      reason: reason is String? ? reason : this.reason,
      at: at ?? this.at,
    );
  }
}
