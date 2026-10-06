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
import '../../../features/facilities/models/facility_summary.dart' as _i66m7xcg;

abstract class PipelineRow
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PipelineRow._({
    required this.facility,
    this.agentUserId,
    this.agentName,
    this.notes,
    this.nextActionAt,
    required this.checklistDone,
    required this.checklistTotal,
  });

  factory PipelineRow({
    required _i66m7xcg.FacilitySummary facility,
    int? agentUserId,
    String? agentName,
    String? notes,
    DateTime? nextActionAt,
    required int checklistDone,
    required int checklistTotal,
  }) = _PipelineRowImpl;

  factory PipelineRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PipelineRow(
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      agentUserId: jsonSerialization['agentUserId'] as int?,
      agentName: jsonSerialization['agentName'] as String?,
      notes: jsonSerialization['notes'] as String?,
      nextActionAt: jsonSerialization['nextActionAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextActionAt'],
            ),
      checklistDone: jsonSerialization['checklistDone'] as int,
      checklistTotal: jsonSerialization['checklistTotal'] as int,
    );
  }

  _i66m7xcg.FacilitySummary facility;

  int? agentUserId;

  String? agentName;

  String? notes;

  DateTime? nextActionAt;

  int checklistDone;

  int checklistTotal;

  /// Returns a shallow copy of this [PipelineRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PipelineRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    int? agentUserId,
    String? agentName,
    String? notes,
    DateTime? nextActionAt,
    int? checklistDone,
    int? checklistTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PipelineRow',
      'facility': facility.toJson(),
      if (agentUserId != null) 'agentUserId': agentUserId,
      if (agentName != null) 'agentName': agentName,
      if (notes != null) 'notes': notes,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      'checklistDone': checklistDone,
      'checklistTotal': checklistTotal,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PipelineRow',
      'facility': facility.toJsonForProtocol(),
      if (agentUserId != null) 'agentUserId': agentUserId,
      if (agentName != null) 'agentName': agentName,
      if (notes != null) 'notes': notes,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      'checklistDone': checklistDone,
      'checklistTotal': checklistTotal,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PipelineRowImpl extends PipelineRow {
  _PipelineRowImpl({
    required _i66m7xcg.FacilitySummary facility,
    int? agentUserId,
    String? agentName,
    String? notes,
    DateTime? nextActionAt,
    required int checklistDone,
    required int checklistTotal,
  }) : super._(
         facility: facility,
         agentUserId: agentUserId,
         agentName: agentName,
         notes: notes,
         nextActionAt: nextActionAt,
         checklistDone: checklistDone,
         checklistTotal: checklistTotal,
       );

  /// Returns a shallow copy of this [PipelineRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PipelineRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    Object? agentUserId = _Undefined,
    Object? agentName = _Undefined,
    Object? notes = _Undefined,
    Object? nextActionAt = _Undefined,
    int? checklistDone,
    int? checklistTotal,
  }) {
    return PipelineRow(
      facility: facility ?? this.facility.copyWith(),
      agentUserId: agentUserId is int? ? agentUserId : this.agentUserId,
      agentName: agentName is String? ? agentName : this.agentName,
      notes: notes is String? ? notes : this.notes,
      nextActionAt: nextActionAt is DateTime?
          ? nextActionAt
          : this.nextActionAt,
      checklistDone: checklistDone ?? this.checklistDone,
      checklistTotal: checklistTotal ?? this.checklistTotal,
    );
  }
}
