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

/// A user's report that a facility's status was wrong.
abstract class StatusReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StatusReport._({
    this.id,
    required this.sessionId,
    required this.facilityId,
    this.userId,
    required this.reason,
    required this.createdAt,
    this.reviewedAt,
    this.reviewedByUserId,
  });

  factory StatusReport({
    int? id,
    required int sessionId,
    required int facilityId,
    int? userId,
    required String reason,
    required DateTime createdAt,
    DateTime? reviewedAt,
    int? reviewedByUserId,
  }) = _StatusReportImpl;

  factory StatusReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatusReport(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as int,
      facilityId: jsonSerialization['facilityId'] as int,
      userId: jsonSerialization['userId'] as int?,
      reason: jsonSerialization['reason'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['reviewedAt'],
            ),
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int sessionId;

  int facilityId;

  int? userId;

  String reason;

  DateTime createdAt;

  DateTime? reviewedAt;

  int? reviewedByUserId;

  /// Returns a shallow copy of this [StatusReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StatusReport copyWith({
    int? id,
    int? sessionId,
    int? facilityId,
    int? userId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
    int? reviewedByUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StatusReport',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StatusReport',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'facilityId': facilityId,
      if (userId != null) 'userId': userId,
      'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StatusReportImpl extends StatusReport {
  _StatusReportImpl({
    int? id,
    required int sessionId,
    required int facilityId,
    int? userId,
    required String reason,
    required DateTime createdAt,
    DateTime? reviewedAt,
    int? reviewedByUserId,
  }) : super._(
         id: id,
         sessionId: sessionId,
         facilityId: facilityId,
         userId: userId,
         reason: reason,
         createdAt: createdAt,
         reviewedAt: reviewedAt,
         reviewedByUserId: reviewedByUserId,
       );

  /// Returns a shallow copy of this [StatusReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StatusReport copyWith({
    Object? id = _Undefined,
    int? sessionId,
    int? facilityId,
    Object? userId = _Undefined,
    String? reason,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
    Object? reviewedByUserId = _Undefined,
  }) {
    return StatusReport(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      facilityId: facilityId ?? this.facilityId,
      userId: userId is int? ? userId : this.userId,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      reviewedByUserId: reviewedByUserId is int?
          ? reviewedByUserId
          : this.reviewedByUserId,
    );
  }
}
