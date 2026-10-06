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

abstract class FacilitySearchResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilitySearchResult._({
    required this.facility,
    required this.address,
    this.distanceMeters,
  });

  factory FacilitySearchResult({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    double? distanceMeters,
  }) = _FacilitySearchResultImpl;

  factory FacilitySearchResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FacilitySearchResult(
      facility: _ivwsyfsq.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      address: jsonSerialization['address'] as String,
      distanceMeters: (jsonSerialization['distanceMeters'] as num?)?.toDouble(),
    );
  }

  _i66m7xcg.FacilitySummary facility;

  String address;

  double? distanceMeters;

  /// Returns a shallow copy of this [FacilitySearchResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilitySearchResult copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    double? distanceMeters,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilitySearchResult',
      'facility': facility.toJson(),
      'address': address,
      if (distanceMeters != null) 'distanceMeters': distanceMeters,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilitySearchResult',
      'facility': facility.toJsonForProtocol(),
      'address': address,
      if (distanceMeters != null) 'distanceMeters': distanceMeters,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilitySearchResultImpl extends FacilitySearchResult {
  _FacilitySearchResultImpl({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    double? distanceMeters,
  }) : super._(
         facility: facility,
         address: address,
         distanceMeters: distanceMeters,
       );

  /// Returns a shallow copy of this [FacilitySearchResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilitySearchResult copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    Object? distanceMeters = _Undefined,
  }) {
    return FacilitySearchResult(
      facility: facility ?? this.facility.copyWith(),
      address: address ?? this.address,
      distanceMeters: distanceMeters is double?
          ? distanceMeters
          : this.distanceMeters,
    );
  }
}
