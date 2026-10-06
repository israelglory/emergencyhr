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
import '../../../features/facilities/models/facility_source.dart' as _i33gs98b;
import '../../../features/facilities/models/facility_summary.dart' as _i66m7xcg;

abstract class DirectoryRow
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DirectoryRow._({
    required this.facility,
    required this.address,
    required this.source,
    required this.suspended,
    required this.flagged,
  });

  factory DirectoryRow({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    required _i33gs98b.FacilitySource source,
    required bool suspended,
    required bool flagged,
  }) = _DirectoryRowImpl;

  factory DirectoryRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return DirectoryRow(
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      address: jsonSerialization['address'] as String,
      source: _i33gs98b.FacilitySource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      suspended: _is.BoolJsonExtension.fromJson(jsonSerialization['suspended']),
      flagged: _is.BoolJsonExtension.fromJson(jsonSerialization['flagged']),
    );
  }

  _i66m7xcg.FacilitySummary facility;

  String address;

  _i33gs98b.FacilitySource source;

  bool suspended;

  bool flagged;

  /// Returns a shallow copy of this [DirectoryRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DirectoryRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    _i33gs98b.FacilitySource? source,
    bool? suspended,
    bool? flagged,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DirectoryRow',
      'facility': facility.toJson(),
      'address': address,
      'source': source.toJson(),
      'suspended': suspended,
      'flagged': flagged,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DirectoryRow',
      'facility': facility.toJsonForProtocol(),
      'address': address,
      'source': source.toJson(),
      'suspended': suspended,
      'flagged': flagged,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DirectoryRowImpl extends DirectoryRow {
  _DirectoryRowImpl({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    required _i33gs98b.FacilitySource source,
    required bool suspended,
    required bool flagged,
  }) : super._(
         facility: facility,
         address: address,
         source: source,
         suspended: suspended,
         flagged: flagged,
       );

  /// Returns a shallow copy of this [DirectoryRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DirectoryRow copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    _i33gs98b.FacilitySource? source,
    bool? suspended,
    bool? flagged,
  }) {
    return DirectoryRow(
      facility: facility ?? this.facility.copyWith(),
      address: address ?? this.address,
      source: source ?? this.source,
      suspended: suspended ?? this.suspended,
      flagged: flagged ?? this.flagged,
    );
  }
}
