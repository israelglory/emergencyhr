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
import '../../../features/admin/models/pipeline_row.dart' as _iu4x2rho;
import '../../../features/admin/models/stage_count.dart' as _i5sdg22r;

/// Onboarding pipeline with counts against the pilot target.
abstract class PipelineBoard
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PipelineBoard._({
    required this.counts,
    required this.liveCount,
    required this.targetMin,
    required this.targetMax,
    required this.rows,
  });

  factory PipelineBoard({
    required List<_i5sdg22r.StageCount> counts,
    required int liveCount,
    required int targetMin,
    required int targetMax,
    required List<_iu4x2rho.PipelineRow> rows,
  }) = _PipelineBoardImpl;

  factory PipelineBoard.fromJson(Map<String, dynamic> jsonSerialization) {
    return PipelineBoard(
      counts: _ivwsyfsq.Protocol().deserialize<List<_i5sdg22r.StageCount>>(
        jsonSerialization['counts'],
      ),
      liveCount: jsonSerialization['liveCount'] as int,
      targetMin: jsonSerialization['targetMin'] as int,
      targetMax: jsonSerialization['targetMax'] as int,
      rows: _ivwsyfsq.Protocol().deserialize<List<_iu4x2rho.PipelineRow>>(
        jsonSerialization['rows'],
      ),
    );
  }

  List<_i5sdg22r.StageCount> counts;

  int liveCount;

  int targetMin;

  int targetMax;

  List<_iu4x2rho.PipelineRow> rows;

  /// Returns a shallow copy of this [PipelineBoard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PipelineBoard copyWith({
    List<_i5sdg22r.StageCount>? counts,
    int? liveCount,
    int? targetMin,
    int? targetMax,
    List<_iu4x2rho.PipelineRow>? rows,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PipelineBoard',
      'counts': counts.toJson(valueToJson: (v) => v.toJson()),
      'liveCount': liveCount,
      'targetMin': targetMin,
      'targetMax': targetMax,
      'rows': rows.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PipelineBoard',
      'counts': counts.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'liveCount': liveCount,
      'targetMin': targetMin,
      'targetMax': targetMax,
      'rows': rows.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PipelineBoardImpl extends PipelineBoard {
  _PipelineBoardImpl({
    required List<_i5sdg22r.StageCount> counts,
    required int liveCount,
    required int targetMin,
    required int targetMax,
    required List<_iu4x2rho.PipelineRow> rows,
  }) : super._(
         counts: counts,
         liveCount: liveCount,
         targetMin: targetMin,
         targetMax: targetMax,
         rows: rows,
       );

  /// Returns a shallow copy of this [PipelineBoard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PipelineBoard copyWith({
    List<_i5sdg22r.StageCount>? counts,
    int? liveCount,
    int? targetMin,
    int? targetMax,
    List<_iu4x2rho.PipelineRow>? rows,
  }) {
    return PipelineBoard(
      counts: counts ?? this.counts.map((e0) => e0.copyWith()).toList(),
      liveCount: liveCount ?? this.liveCount,
      targetMin: targetMin ?? this.targetMin,
      targetMax: targetMax ?? this.targetMax,
      rows: rows ?? this.rows.map((e0) => e0.copyWith()).toList(),
    );
  }
}
