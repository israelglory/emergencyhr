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

/// A facility in a field agent's list.
abstract class AgentFacility
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AgentFacility._({
    required this.facility,
    required this.address,
    this.nextActionAt,
    this.notes,
    required this.checklistDone,
    required this.checklistTotal,
    required this.submitted,
    this.distanceMeters,
  });

  factory AgentFacility({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    DateTime? nextActionAt,
    String? notes,
    required int checklistDone,
    required int checklistTotal,
    required bool submitted,
    double? distanceMeters,
  }) = _AgentFacilityImpl;

  factory AgentFacility.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentFacility(
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      address: jsonSerialization['address'] as String,
      nextActionAt: jsonSerialization['nextActionAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextActionAt'],
            ),
      notes: jsonSerialization['notes'] as String?,
      checklistDone: jsonSerialization['checklistDone'] as int,
      checklistTotal: jsonSerialization['checklistTotal'] as int,
      submitted: _is.BoolJsonExtension.fromJson(jsonSerialization['submitted']),
      distanceMeters: (jsonSerialization['distanceMeters'] as num?)?.toDouble(),
    );
  }

  _i66m7xcg.FacilitySummary facility;

  String address;

  DateTime? nextActionAt;

  String? notes;

  int checklistDone;

  int checklistTotal;

  bool submitted;

  double? distanceMeters;

  /// Returns a shallow copy of this [AgentFacility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AgentFacility copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    DateTime? nextActionAt,
    String? notes,
    int? checklistDone,
    int? checklistTotal,
    bool? submitted,
    double? distanceMeters,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentFacility',
      'facility': facility.toJson(),
      'address': address,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      if (notes != null) 'notes': notes,
      'checklistDone': checklistDone,
      'checklistTotal': checklistTotal,
      'submitted': submitted,
      if (distanceMeters != null) 'distanceMeters': distanceMeters,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentFacility',
      'facility': facility.toJsonForProtocol(),
      'address': address,
      if (nextActionAt != null) 'nextActionAt': nextActionAt?.toJson(),
      if (notes != null) 'notes': notes,
      'checklistDone': checklistDone,
      'checklistTotal': checklistTotal,
      'submitted': submitted,
      if (distanceMeters != null) 'distanceMeters': distanceMeters,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentFacilityImpl extends AgentFacility {
  _AgentFacilityImpl({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    DateTime? nextActionAt,
    String? notes,
    required int checklistDone,
    required int checklistTotal,
    required bool submitted,
    double? distanceMeters,
  }) : super._(
         facility: facility,
         address: address,
         nextActionAt: nextActionAt,
         notes: notes,
         checklistDone: checklistDone,
         checklistTotal: checklistTotal,
         submitted: submitted,
         distanceMeters: distanceMeters,
       );

  /// Returns a shallow copy of this [AgentFacility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AgentFacility copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    Object? nextActionAt = _Undefined,
    Object? notes = _Undefined,
    int? checklistDone,
    int? checklistTotal,
    bool? submitted,
    Object? distanceMeters = _Undefined,
  }) {
    return AgentFacility(
      facility: facility ?? this.facility.copyWith(),
      address: address ?? this.address,
      nextActionAt: nextActionAt is DateTime?
          ? nextActionAt
          : this.nextActionAt,
      notes: notes is String? ? notes : this.notes,
      checklistDone: checklistDone ?? this.checklistDone,
      checklistTotal: checklistTotal ?? this.checklistTotal,
      submitted: submitted ?? this.submitted,
      distanceMeters: distanceMeters is double?
          ? distanceMeters
          : this.distanceMeters,
    );
  }
}
