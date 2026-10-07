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
import '../../../features/facilities/models/facility_type.dart' as _ieko45br;

/// One hospital in an import file (Admin, Directory, Import hospitals).
abstract class FacilityImportRow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilityImportRow._({
    required this.sourceRef,
    required this.name,
    required this.type,
    required this.address,
    required this.area,
    required this.lat,
    required this.lng,
  });

  factory FacilityImportRow({
    required String sourceRef,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
  }) = _FacilityImportRowImpl;

  factory FacilityImportRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityImportRow(
      sourceRef: jsonSerialization['sourceRef'] as String,
      name: jsonSerialization['name'] as String,
      type: _ieko45br.FacilityType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      address: jsonSerialization['address'] as String,
      area: jsonSerialization['area'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
    );
  }

  /// Stable id from the source dataset, e.g. "grid3-nga-v2:<id>".
  String sourceRef;

  String name;

  _ieko45br.FacilityType type;

  String address;

  String area;

  double lat;

  double lng;

  /// Returns a shallow copy of this [FacilityImportRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilityImportRow copyWith({
    String? sourceRef,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityImportRow',
      'sourceRef': sourceRef,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityImportRow',
      'sourceRef': sourceRef,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _FacilityImportRowImpl extends FacilityImportRow {
  _FacilityImportRowImpl({
    required String sourceRef,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
  }) : super._(
         sourceRef: sourceRef,
         name: name,
         type: type,
         address: address,
         area: area,
         lat: lat,
         lng: lng,
       );

  /// Returns a shallow copy of this [FacilityImportRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilityImportRow copyWith({
    String? sourceRef,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
  }) {
    return FacilityImportRow(
      sourceRef: sourceRef ?? this.sourceRef,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      area: area ?? this.area,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
