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

abstract class StageCount
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StageCount._({
    required this.stage,
    required this.count,
  });

  factory StageCount({
    required _ibrba1hx.OnboardingStage stage,
    required int count,
  }) = _StageCountImpl;

  factory StageCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return StageCount(
      stage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['stage'] as String),
      ),
      count: jsonSerialization['count'] as int,
    );
  }

  _ibrba1hx.OnboardingStage stage;

  int count;

  /// Returns a shallow copy of this [StageCount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StageCount copyWith({
    _ibrba1hx.OnboardingStage? stage,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StageCount',
      'stage': stage.toJson(),
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StageCount',
      'stage': stage.toJson(),
      'count': count,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _StageCountImpl extends StageCount {
  _StageCountImpl({
    required _ibrba1hx.OnboardingStage stage,
    required int count,
  }) : super._(
         stage: stage,
         count: count,
       );

  /// Returns a shallow copy of this [StageCount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StageCount copyWith({
    _ibrba1hx.OnboardingStage? stage,
    int? count,
  }) {
    return StageCount(
      stage: stage ?? this.stage,
      count: count ?? this.count,
    );
  }
}
