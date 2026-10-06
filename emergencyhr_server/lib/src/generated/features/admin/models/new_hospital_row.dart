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

/// Early health of a facility in its first 14 days live.
abstract class NewHospitalRow
    implements _is.SerializableModel, _is.ProtocolSerialization {
  NewHospitalRow._({
    required this.facility,
    required this.liveAt,
    required this.statusUpdates,
    this.lastUpdateAt,
    required this.quiet,
    this.agentName,
  });

  factory NewHospitalRow({
    required _i66m7xcg.FacilitySummary facility,
    required DateTime liveAt,
    required int statusUpdates,
    DateTime? lastUpdateAt,
    required bool quiet,
    String? agentName,
  }) = _NewHospitalRowImpl;

  factory NewHospitalRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return NewHospitalRow(
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      liveAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['liveAt']),
      statusUpdates: jsonSerialization['statusUpdates'] as int,
      lastUpdateAt: jsonSerialization['lastUpdateAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastUpdateAt'],
            ),
      quiet: _is.BoolJsonExtension.fromJson(jsonSerialization['quiet']),
      agentName: jsonSerialization['agentName'] as String?,
    );
  }

  _i66m7xcg.FacilitySummary facility;

  DateTime liveAt;

  int statusUpdates;

  DateTime? lastUpdateAt;

  /// No update for 48 hours during opening hours.
  bool quiet;

  String? agentName;

  /// Returns a shallow copy of this [NewHospitalRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NewHospitalRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    DateTime? liveAt,
    int? statusUpdates,
    DateTime? lastUpdateAt,
    bool? quiet,
    String? agentName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NewHospitalRow',
      'facility': facility.toJson(),
      'liveAt': liveAt.toJson(),
      'statusUpdates': statusUpdates,
      if (lastUpdateAt != null) 'lastUpdateAt': lastUpdateAt?.toJson(),
      'quiet': quiet,
      if (agentName != null) 'agentName': agentName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NewHospitalRow',
      'facility': facility.toJsonForProtocol(),
      'liveAt': liveAt.toJson(),
      'statusUpdates': statusUpdates,
      if (lastUpdateAt != null) 'lastUpdateAt': lastUpdateAt?.toJson(),
      'quiet': quiet,
      if (agentName != null) 'agentName': agentName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NewHospitalRowImpl extends NewHospitalRow {
  _NewHospitalRowImpl({
    required _i66m7xcg.FacilitySummary facility,
    required DateTime liveAt,
    required int statusUpdates,
    DateTime? lastUpdateAt,
    required bool quiet,
    String? agentName,
  }) : super._(
         facility: facility,
         liveAt: liveAt,
         statusUpdates: statusUpdates,
         lastUpdateAt: lastUpdateAt,
         quiet: quiet,
         agentName: agentName,
       );

  /// Returns a shallow copy of this [NewHospitalRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NewHospitalRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    DateTime? liveAt,
    int? statusUpdates,
    Object? lastUpdateAt = _Undefined,
    bool? quiet,
    Object? agentName = _Undefined,
  }) {
    return NewHospitalRow(
      facility: facility ?? this.facility.copyWith(),
      liveAt: liveAt ?? this.liveAt,
      statusUpdates: statusUpdates ?? this.statusUpdates,
      lastUpdateAt: lastUpdateAt is DateTime?
          ? lastUpdateAt
          : this.lastUpdateAt,
      quiet: quiet ?? this.quiet,
      agentName: agentName is String? ? agentName : this.agentName,
    );
  }
}
