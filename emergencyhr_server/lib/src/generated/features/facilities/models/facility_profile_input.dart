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

abstract class FacilityProfileInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FacilityProfileInput._({
    required this.name,
    required this.type,
    required this.address,
    required this.area,
    required this.lat,
    required this.lng,
    this.deskPhone,
    this.contactName,
    this.contactPhone,
    this.openingHours,
    required this.capabilities,
  });

  factory FacilityProfileInput({
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    String? contactName,
    String? contactPhone,
    _iy9wan3d.OpeningHours? openingHours,
    required List<_ilg1kmfo.Capability> capabilities,
  }) = _FacilityProfileInputImpl;

  factory FacilityProfileInput.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FacilityProfileInput(
      name: jsonSerialization['name'] as String,
      type: _ieko45br.FacilityType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      address: jsonSerialization['address'] as String,
      area: jsonSerialization['area'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      deskPhone: jsonSerialization['deskPhone'] as String?,
      contactName: jsonSerialization['contactName'] as String?,
      contactPhone: jsonSerialization['contactPhone'] as String?,
      openingHours: jsonSerialization['openingHours'] == null
          ? null
          : _ilvcm0hz.Protocol().deserialize<_iy9wan3d.OpeningHours>(
              jsonSerialization['openingHours'],
            ),
      capabilities: _ilvcm0hz.Protocol()
          .deserialize<List<_ilg1kmfo.Capability>>(
            jsonSerialization['capabilities'],
          ),
    );
  }

  String name;

  _ieko45br.FacilityType type;

  String address;

  String area;

  double lat;

  double lng;

  String? deskPhone;

  String? contactName;

  String? contactPhone;

  _iy9wan3d.OpeningHours? openingHours;

  List<_ilg1kmfo.Capability> capabilities;

  /// Returns a shallow copy of this [FacilityProfileInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FacilityProfileInput copyWith({
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    String? deskPhone,
    String? contactName,
    String? contactPhone,
    _iy9wan3d.OpeningHours? openingHours,
    List<_ilg1kmfo.Capability>? capabilities,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityProfileInput',
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (contactName != null) 'contactName': contactName,
      if (contactPhone != null) 'contactPhone': contactPhone,
      if (openingHours != null) 'openingHours': openingHours?.toJson(),
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityProfileInput',
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (contactName != null) 'contactName': contactName,
      if (contactPhone != null) 'contactPhone': contactPhone,
      if (openingHours != null)
        'openingHours': openingHours?.toJsonForProtocol(),
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityProfileInputImpl extends FacilityProfileInput {
  _FacilityProfileInputImpl({
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    String? contactName,
    String? contactPhone,
    _iy9wan3d.OpeningHours? openingHours,
    required List<_ilg1kmfo.Capability> capabilities,
  }) : super._(
         name: name,
         type: type,
         address: address,
         area: area,
         lat: lat,
         lng: lng,
         deskPhone: deskPhone,
         contactName: contactName,
         contactPhone: contactPhone,
         openingHours: openingHours,
         capabilities: capabilities,
       );

  /// Returns a shallow copy of this [FacilityProfileInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FacilityProfileInput copyWith({
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    Object? deskPhone = _Undefined,
    Object? contactName = _Undefined,
    Object? contactPhone = _Undefined,
    Object? openingHours = _Undefined,
    List<_ilg1kmfo.Capability>? capabilities,
  }) {
    return FacilityProfileInput(
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      area: area ?? this.area,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      deskPhone: deskPhone is String? ? deskPhone : this.deskPhone,
      contactName: contactName is String? ? contactName : this.contactName,
      contactPhone: contactPhone is String? ? contactPhone : this.contactPhone,
      openingHours: openingHours is _iy9wan3d.OpeningHours?
          ? openingHours
          : this.openingHours?.copyWith(),
      capabilities: capabilities ?? this.capabilities.map((e0) => e0).toList(),
    );
  }
}
