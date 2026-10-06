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
import '../../../features/facilities/models/facility_summary.dart' as _i66m7xcg;

abstract class FreshnessRow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FreshnessRow._({
    required this.facility,
    this.lastUpdateAt,
    this.accepting,
    required this.openNow,
  });

  factory FreshnessRow({
    required _i66m7xcg.FacilitySummary facility,
    DateTime? lastUpdateAt,
    bool? accepting,
    required bool openNow,
  }) = _FreshnessRowImpl;

  factory FreshnessRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return FreshnessRow(
      facility: _ivwsyfsq.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      lastUpdateAt: jsonSerialization['lastUpdateAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastUpdateAt'],
            ),
      accepting: jsonSerialization['accepting'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['accepting']),
      openNow: _isc.BoolJsonExtension.fromJson(jsonSerialization['openNow']),
    );
  }

  _i66m7xcg.FacilitySummary facility;

  DateTime? lastUpdateAt;

  bool? accepting;

  bool openNow;

  /// Returns a shallow copy of this [FreshnessRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FreshnessRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    DateTime? lastUpdateAt,
    bool? accepting,
    bool? openNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FreshnessRow',
      'facility': facility.toJson(),
      if (lastUpdateAt != null) 'lastUpdateAt': lastUpdateAt?.toJson(),
      if (accepting != null) 'accepting': accepting,
      'openNow': openNow,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FreshnessRow',
      'facility': facility.toJsonForProtocol(),
      if (lastUpdateAt != null) 'lastUpdateAt': lastUpdateAt?.toJson(),
      if (accepting != null) 'accepting': accepting,
      'openNow': openNow,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FreshnessRowImpl extends FreshnessRow {
  _FreshnessRowImpl({
    required _i66m7xcg.FacilitySummary facility,
    DateTime? lastUpdateAt,
    bool? accepting,
    required bool openNow,
  }) : super._(
         facility: facility,
         lastUpdateAt: lastUpdateAt,
         accepting: accepting,
         openNow: openNow,
       );

  /// Returns a shallow copy of this [FreshnessRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FreshnessRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    Object? lastUpdateAt = _Undefined,
    Object? accepting = _Undefined,
    bool? openNow,
  }) {
    return FreshnessRow(
      facility: facility ?? this.facility.copyWith(),
      lastUpdateAt: lastUpdateAt is DateTime?
          ? lastUpdateAt
          : this.lastUpdateAt,
      accepting: accepting is bool? ? accepting : this.accepting,
      openNow: openNow ?? this.openNow,
    );
  }
}
