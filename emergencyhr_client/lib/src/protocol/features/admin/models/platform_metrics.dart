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

abstract class PlatformMetrics
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlatformMetrics._({
    required this.periodDays,
    required this.sessions,
    required this.actedSessions,
    this.medianSecondsToAction,
    required this.emptyResultRate,
    required this.liveFacilities,
    required this.freshUnder60Share,
  });

  factory PlatformMetrics({
    required int periodDays,
    required int sessions,
    required int actedSessions,
    int? medianSecondsToAction,
    required double emptyResultRate,
    required int liveFacilities,
    required double freshUnder60Share,
  }) = _PlatformMetricsImpl;

  factory PlatformMetrics.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformMetrics(
      periodDays: jsonSerialization['periodDays'] as int,
      sessions: jsonSerialization['sessions'] as int,
      actedSessions: jsonSerialization['actedSessions'] as int,
      medianSecondsToAction: jsonSerialization['medianSecondsToAction'] as int?,
      emptyResultRate: (jsonSerialization['emptyResultRate'] as num).toDouble(),
      liveFacilities: jsonSerialization['liveFacilities'] as int,
      freshUnder60Share: (jsonSerialization['freshUnder60Share'] as num)
          .toDouble(),
    );
  }

  int periodDays;

  int sessions;

  int actedSessions;

  int? medianSecondsToAction;

  double emptyResultRate;

  int liveFacilities;

  double freshUnder60Share;

  /// Returns a shallow copy of this [PlatformMetrics]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlatformMetrics copyWith({
    int? periodDays,
    int? sessions,
    int? actedSessions,
    int? medianSecondsToAction,
    double? emptyResultRate,
    int? liveFacilities,
    double? freshUnder60Share,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlatformMetrics',
      'periodDays': periodDays,
      'sessions': sessions,
      'actedSessions': actedSessions,
      if (medianSecondsToAction != null)
        'medianSecondsToAction': medianSecondsToAction,
      'emptyResultRate': emptyResultRate,
      'liveFacilities': liveFacilities,
      'freshUnder60Share': freshUnder60Share,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlatformMetrics',
      'periodDays': periodDays,
      'sessions': sessions,
      'actedSessions': actedSessions,
      if (medianSecondsToAction != null)
        'medianSecondsToAction': medianSecondsToAction,
      'emptyResultRate': emptyResultRate,
      'liveFacilities': liveFacilities,
      'freshUnder60Share': freshUnder60Share,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformMetricsImpl extends PlatformMetrics {
  _PlatformMetricsImpl({
    required int periodDays,
    required int sessions,
    required int actedSessions,
    int? medianSecondsToAction,
    required double emptyResultRate,
    required int liveFacilities,
    required double freshUnder60Share,
  }) : super._(
         periodDays: periodDays,
         sessions: sessions,
         actedSessions: actedSessions,
         medianSecondsToAction: medianSecondsToAction,
         emptyResultRate: emptyResultRate,
         liveFacilities: liveFacilities,
         freshUnder60Share: freshUnder60Share,
       );

  /// Returns a shallow copy of this [PlatformMetrics]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlatformMetrics copyWith({
    int? periodDays,
    int? sessions,
    int? actedSessions,
    Object? medianSecondsToAction = _Undefined,
    double? emptyResultRate,
    int? liveFacilities,
    double? freshUnder60Share,
  }) {
    return PlatformMetrics(
      periodDays: periodDays ?? this.periodDays,
      sessions: sessions ?? this.sessions,
      actedSessions: actedSessions ?? this.actedSessions,
      medianSecondsToAction: medianSecondsToAction is int?
          ? medianSecondsToAction
          : this.medianSecondsToAction,
      emptyResultRate: emptyResultRate ?? this.emptyResultRate,
      liveFacilities: liveFacilities ?? this.liveFacilities,
      freshUnder60Share: freshUnder60Share ?? this.freshUnder60Share,
    );
  }
}
