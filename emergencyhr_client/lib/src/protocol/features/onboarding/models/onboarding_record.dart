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
import '../../../features/facilities/models/onboarding_stage.dart' as _ibrba1hx;

abstract class OnboardingRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OnboardingRecord._({
    this.id,
    required this.facilityId,
    required this.stage,
    this.assignedAgentUserId,
    this.notes,
    this.nextActionAt,
    this.submittedAt,
    this.submittedByUserId,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory OnboardingRecord({
    int? id,
    required int facilityId,
    required _ibrba1hx.OnboardingStage stage,
    int? assignedAgentUserId,
    String? notes,
    DateTime? nextActionAt,
    DateTime? submittedAt,
    int? submittedByUserId,
    DateTime? updatedAt,
  }) = _OnboardingRecordImpl;

  factory OnboardingRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return OnboardingRecord(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      stage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['stage'] as String),
      ),
      assignedAgentUserId: jsonSerialization['assignedAgentUserId'] as int?,
      notes: jsonSerialization['notes'] as String?,
      nextActionAt: jsonSerialization['nextActionAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextActionAt'],
            ),
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      submittedByUserId: jsonSerialization['submittedByUserId'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int facilityId;

  _ibrba1hx.OnboardingStage stage;

  int? assignedAgentUserId;

  String? notes;

  DateTime? nextActionAt;

  DateTime? submittedAt;

  int? submittedByUserId;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OnboardingRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OnboardingRecord copyWith({
    int? id,
    int? facilityId,
    _ibrba1hx.OnboardingStage? stage,
    int? assignedAgentUserId,
    String? notes,
    DateTime? nextActionAt,
    DateTime? submittedAt,
    int? submittedByUserId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnboardingRecord',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'stage': stage.toJson(),
      if (assignedAgentUserId != null)
        'assignedAgentUserId': assignedAgentUserId,
      if (notes != null) 'notes': notes,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (submittedByUserId != null) 'submittedByUserId': submittedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnboardingRecord',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'stage': stage.toJson(),
      if (assignedAgentUserId != null)
        'assignedAgentUserId': assignedAgentUserId,
      if (notes != null) 'notes': notes,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (submittedByUserId != null) 'submittedByUserId': submittedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OnboardingRecordImpl extends OnboardingRecord {
  _OnboardingRecordImpl({
    int? id,
    required int facilityId,
    required _ibrba1hx.OnboardingStage stage,
    int? assignedAgentUserId,
    String? notes,
    DateTime? nextActionAt,
    DateTime? submittedAt,
    int? submittedByUserId,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         stage: stage,
         assignedAgentUserId: assignedAgentUserId,
         notes: notes,
         nextActionAt: nextActionAt,
         submittedAt: submittedAt,
         submittedByUserId: submittedByUserId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OnboardingRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OnboardingRecord copyWith({
    Object? id = _Undefined,
    int? facilityId,
    _ibrba1hx.OnboardingStage? stage,
    Object? assignedAgentUserId = _Undefined,
    Object? notes = _Undefined,
    Object? nextActionAt = _Undefined,
    Object? submittedAt = _Undefined,
    Object? submittedByUserId = _Undefined,
    DateTime? updatedAt,
  }) {
    return OnboardingRecord(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      stage: stage ?? this.stage,
      assignedAgentUserId: assignedAgentUserId is int?
          ? assignedAgentUserId
          : this.assignedAgentUserId,
      notes: notes is String? ? notes : this.notes,
      nextActionAt: nextActionAt is DateTime?
          ? nextActionAt
          : this.nextActionAt,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      submittedByUserId: submittedByUserId is int?
          ? submittedByUserId
          : this.submittedByUserId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
