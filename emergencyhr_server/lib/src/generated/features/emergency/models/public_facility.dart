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
import '../../../features/facilities/models/capability.dart' as _ilg1kmfo;
import '../../../features/facilities/models/facility_type.dart' as _ieko45br;
import '../../../features/facilities/models/opening_hours.dart' as _iy9wan3d;
import '../../../features/status/models/facility_status.dart' as _ih95nrbj;
import '../../../features/status/models/freshness_tier.dart' as _ixumfioy;

/// What the public may see about a hospital.
abstract class PublicFacility
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PublicFacility._({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.area,
    required this.lat,
    required this.lng,
    this.deskPhone,
    this.openingHours,
    required this.capabilities,
    required this.freshness,
    this.status,
    required this.live,
    this.dataSource,
  });

  factory PublicFacility({
    required int id,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    _iy9wan3d.OpeningHours? openingHours,
    required List<_ilg1kmfo.Capability> capabilities,
    required _ixumfioy.FreshnessTier freshness,
    _ih95nrbj.FacilityStatus? status,
    required bool live,
    String? dataSource,
  }) = _PublicFacilityImpl;

  factory PublicFacility.fromJson(Map<String, dynamic> jsonSerialization) {
    return PublicFacility(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      type: _ieko45br.FacilityType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      address: jsonSerialization['address'] as String,
      area: jsonSerialization['area'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      deskPhone: jsonSerialization['deskPhone'] as String?,
      openingHours: jsonSerialization['openingHours'] == null
          ? null
          : _ilvcm0hz.Protocol().deserialize<_iy9wan3d.OpeningHours>(
              jsonSerialization['openingHours'],
            ),
      capabilities: _ilvcm0hz.Protocol()
          .deserialize<List<_ilg1kmfo.Capability>>(
            jsonSerialization['capabilities'],
          ),
      freshness: _ixumfioy.FreshnessTier.fromJson(
        (jsonSerialization['freshness'] as String),
      ),
      status: jsonSerialization['status'] == null
          ? null
          : _ilvcm0hz.Protocol().deserialize<_ih95nrbj.FacilityStatus>(
              jsonSerialization['status'],
            ),
      live: _is.BoolJsonExtension.fromJson(jsonSerialization['live']),
      dataSource: jsonSerialization['dataSource'] as String?,
    );
  }

  int id;

  String name;

  _ieko45br.FacilityType type;

  String address;

  String area;

  double lat;

  double lng;

  String? deskPhone;

  _iy9wan3d.OpeningHours? openingHours;

  List<_ilg1kmfo.Capability> capabilities;

  _ixumfioy.FreshnessTier freshness;

  _ih95nrbj.FacilityStatus? status;

  bool live;

  /// Credit for imported listings, e.g. "Location from GRID3 (CC BY 4.0)".
  String? dataSource;

  /// Returns a shallow copy of this [PublicFacility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PublicFacility copyWith({
    int? id,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    String? deskPhone,
    _iy9wan3d.OpeningHours? openingHours,
    List<_ilg1kmfo.Capability>? capabilities,
    _ixumfioy.FreshnessTier? freshness,
    _ih95nrbj.FacilityStatus? status,
    bool? live,
    String? dataSource,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PublicFacility',
      'id': id,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (openingHours != null) 'openingHours': openingHours?.toJson(),
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
      'freshness': freshness.toJson(),
      if (status != null) 'status': status?.toJson(),
      'live': live,
      if (dataSource != null) 'dataSource': dataSource,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PublicFacility',
      'id': id,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (openingHours != null)
        'openingHours': openingHours?.toJsonForProtocol(),
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
      'freshness': freshness.toJson(),
      if (status != null) 'status': status?.toJsonForProtocol(),
      'live': live,
      if (dataSource != null) 'dataSource': dataSource,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PublicFacilityImpl extends PublicFacility {
  _PublicFacilityImpl({
    required int id,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    _iy9wan3d.OpeningHours? openingHours,
    required List<_ilg1kmfo.Capability> capabilities,
    required _ixumfioy.FreshnessTier freshness,
    _ih95nrbj.FacilityStatus? status,
    required bool live,
    String? dataSource,
  }) : super._(
         id: id,
         name: name,
         type: type,
         address: address,
         area: area,
         lat: lat,
         lng: lng,
         deskPhone: deskPhone,
         openingHours: openingHours,
         capabilities: capabilities,
         freshness: freshness,
         status: status,
         live: live,
         dataSource: dataSource,
       );

  /// Returns a shallow copy of this [PublicFacility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PublicFacility copyWith({
    int? id,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    Object? deskPhone = _Undefined,
    Object? openingHours = _Undefined,
    List<_ilg1kmfo.Capability>? capabilities,
    _ixumfioy.FreshnessTier? freshness,
    Object? status = _Undefined,
    bool? live,
    Object? dataSource = _Undefined,
  }) {
    return PublicFacility(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      area: area ?? this.area,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      deskPhone: deskPhone is String? ? deskPhone : this.deskPhone,
      openingHours: openingHours is _iy9wan3d.OpeningHours?
          ? openingHours
          : this.openingHours?.copyWith(),
      capabilities: capabilities ?? this.capabilities.map((e0) => e0).toList(),
      freshness: freshness ?? this.freshness,
      status: status is _ih95nrbj.FacilityStatus?
          ? status
          : this.status?.copyWith(),
      live: live ?? this.live,
      dataSource: dataSource is String? ? dataSource : this.dataSource,
    );
  }
}
