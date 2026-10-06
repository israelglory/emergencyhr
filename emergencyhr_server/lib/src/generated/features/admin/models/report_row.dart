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

abstract class ReportRow
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ReportRow._({
    required this.facility,
    required this.flagged,
    required this.openReports,
    required this.latestReason,
    required this.latestAt,
  });

  factory ReportRow({
    required _i66m7xcg.FacilitySummary facility,
    required bool flagged,
    required int openReports,
    required String latestReason,
    required DateTime latestAt,
  }) = _ReportRowImpl;

  factory ReportRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportRow(
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      flagged: _is.BoolJsonExtension.fromJson(jsonSerialization['flagged']),
      openReports: jsonSerialization['openReports'] as int,
      latestReason: jsonSerialization['latestReason'] as String,
      latestAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['latestAt'],
      ),
    );
  }

  _i66m7xcg.FacilitySummary facility;

  bool flagged;

  int openReports;

  String latestReason;

  DateTime latestAt;

  /// Returns a shallow copy of this [ReportRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReportRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    bool? flagged,
    int? openReports,
    String? latestReason,
    DateTime? latestAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportRow',
      'facility': facility.toJson(),
      'flagged': flagged,
      'openReports': openReports,
      'latestReason': latestReason,
      'latestAt': latestAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReportRow',
      'facility': facility.toJsonForProtocol(),
      'flagged': flagged,
      'openReports': openReports,
      'latestReason': latestReason,
      'latestAt': latestAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ReportRowImpl extends ReportRow {
  _ReportRowImpl({
    required _i66m7xcg.FacilitySummary facility,
    required bool flagged,
    required int openReports,
    required String latestReason,
    required DateTime latestAt,
  }) : super._(
         facility: facility,
         flagged: flagged,
         openReports: openReports,
         latestReason: latestReason,
         latestAt: latestAt,
       );

  /// Returns a shallow copy of this [ReportRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReportRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    bool? flagged,
    int? openReports,
    String? latestReason,
    DateTime? latestAt,
  }) {
    return ReportRow(
      facility: facility ?? this.facility.copyWith(),
      flagged: flagged ?? this.flagged,
      openReports: openReports ?? this.openReports,
      latestReason: latestReason ?? this.latestReason,
      latestAt: latestAt ?? this.latestAt,
    );
  }
}
