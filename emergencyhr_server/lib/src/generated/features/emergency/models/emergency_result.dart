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
import '../../../features/emergency/models/capability_match.dart' as _igae4vn6;
import '../../../features/facilities/models/capability.dart' as _ilg1kmfo;
import '../../../features/status/models/freshness_tier.dart' as _ixumfioy;

/// One hospital in the emergency results, ranked by the server.
abstract class EmergencyResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EmergencyResult._({
    required this.facilityId,
    required this.name,
    required this.address,
    required this.area,
    required this.lat,
    required this.lng,
    this.deskPhone,
    required this.distanceKm,
    required this.etaMinutes,
    required this.rankTier,
    required this.freshness,
    this.statusUpdatedAt,
    this.erBedsFree,
    this.icuBedsFree,
    this.doctorOnDuty,
    this.depositRequired,
    required this.capabilities,
    required this.match,
    required this.flagged,
  });

  factory EmergencyResult({
    required int facilityId,
    required String name,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    required double distanceKm,
    required int etaMinutes,
    required int rankTier,
    required _ixumfioy.FreshnessTier freshness,
    DateTime? statusUpdatedAt,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
    required List<_ilg1kmfo.Capability> capabilities,
    required _igae4vn6.CapabilityMatch match,
    required bool flagged,
  }) = _EmergencyResultImpl;

  factory EmergencyResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencyResult(
      facilityId: jsonSerialization['facilityId'] as int,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      area: jsonSerialization['area'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      deskPhone: jsonSerialization['deskPhone'] as String?,
      distanceKm: (jsonSerialization['distanceKm'] as num).toDouble(),
      etaMinutes: jsonSerialization['etaMinutes'] as int,
      rankTier: jsonSerialization['rankTier'] as int,
      freshness: _ixumfioy.FreshnessTier.fromJson(
        (jsonSerialization['freshness'] as String),
      ),
      statusUpdatedAt: jsonSerialization['statusUpdatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['statusUpdatedAt'],
            ),
      erBedsFree: jsonSerialization['erBedsFree'] as int?,
      icuBedsFree: jsonSerialization['icuBedsFree'] as int?,
      doctorOnDuty: jsonSerialization['doctorOnDuty'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['doctorOnDuty']),
      depositRequired: jsonSerialization['depositRequired'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['depositRequired'],
            ),
      capabilities: _ilvcm0hz.Protocol()
          .deserialize<List<_ilg1kmfo.Capability>>(
            jsonSerialization['capabilities'],
          ),
      match: _igae4vn6.CapabilityMatch.fromJson(
        (jsonSerialization['match'] as String),
      ),
      flagged: _is.BoolJsonExtension.fromJson(jsonSerialization['flagged']),
    );
  }

  int facilityId;

  String name;

  String address;

  String area;

  double lat;

  double lng;

  String? deskPhone;

  double distanceKm;

  int etaMinutes;

  /// 1, 2 or 3. 0 means hidden by default (paused or flagged).
  int rankTier;

  _ixumfioy.FreshnessTier freshness;

  DateTime? statusUpdatedAt;

  int? erBedsFree;

  int? icuBedsFree;

  bool? doctorOnDuty;

  bool? depositRequired;

  List<_ilg1kmfo.Capability> capabilities;

  _igae4vn6.CapabilityMatch match;

  bool flagged;

  /// Returns a shallow copy of this [EmergencyResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmergencyResult copyWith({
    int? facilityId,
    String? name,
    String? address,
    String? area,
    double? lat,
    double? lng,
    String? deskPhone,
    double? distanceKm,
    int? etaMinutes,
    int? rankTier,
    _ixumfioy.FreshnessTier? freshness,
    DateTime? statusUpdatedAt,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
    List<_ilg1kmfo.Capability>? capabilities,
    _igae4vn6.CapabilityMatch? match,
    bool? flagged,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmergencyResult',
      'facilityId': facilityId,
      'name': name,
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      'distanceKm': distanceKm,
      'etaMinutes': etaMinutes,
      'rankTier': rankTier,
      'freshness': freshness.toJson(),
      if (statusUpdatedAt != null) 'statusUpdatedAt': statusUpdatedAt?.toJson(),
      if (erBedsFree != null) 'erBedsFree': erBedsFree,
      if (icuBedsFree != null) 'icuBedsFree': icuBedsFree,
      if (doctorOnDuty != null) 'doctorOnDuty': doctorOnDuty,
      if (depositRequired != null) 'depositRequired': depositRequired,
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
      'match': match.toJson(),
      'flagged': flagged,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmergencyResult',
      'facilityId': facilityId,
      'name': name,
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      'distanceKm': distanceKm,
      'etaMinutes': etaMinutes,
      'rankTier': rankTier,
      'freshness': freshness.toJson(),
      if (statusUpdatedAt != null) 'statusUpdatedAt': statusUpdatedAt?.toJson(),
      if (erBedsFree != null) 'erBedsFree': erBedsFree,
      if (icuBedsFree != null) 'icuBedsFree': icuBedsFree,
      if (doctorOnDuty != null) 'doctorOnDuty': doctorOnDuty,
      if (depositRequired != null) 'depositRequired': depositRequired,
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
      'match': match.toJson(),
      'flagged': flagged,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencyResultImpl extends EmergencyResult {
  _EmergencyResultImpl({
    required int facilityId,
    required String name,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    required double distanceKm,
    required int etaMinutes,
    required int rankTier,
    required _ixumfioy.FreshnessTier freshness,
    DateTime? statusUpdatedAt,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
    required List<_ilg1kmfo.Capability> capabilities,
    required _igae4vn6.CapabilityMatch match,
    required bool flagged,
  }) : super._(
         facilityId: facilityId,
         name: name,
         address: address,
         area: area,
         lat: lat,
         lng: lng,
         deskPhone: deskPhone,
         distanceKm: distanceKm,
         etaMinutes: etaMinutes,
         rankTier: rankTier,
         freshness: freshness,
         statusUpdatedAt: statusUpdatedAt,
         erBedsFree: erBedsFree,
         icuBedsFree: icuBedsFree,
         doctorOnDuty: doctorOnDuty,
         depositRequired: depositRequired,
         capabilities: capabilities,
         match: match,
         flagged: flagged,
       );

  /// Returns a shallow copy of this [EmergencyResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmergencyResult copyWith({
    int? facilityId,
    String? name,
    String? address,
    String? area,
    double? lat,
    double? lng,
    Object? deskPhone = _Undefined,
    double? distanceKm,
    int? etaMinutes,
    int? rankTier,
    _ixumfioy.FreshnessTier? freshness,
    Object? statusUpdatedAt = _Undefined,
    Object? erBedsFree = _Undefined,
    Object? icuBedsFree = _Undefined,
    Object? doctorOnDuty = _Undefined,
    Object? depositRequired = _Undefined,
    List<_ilg1kmfo.Capability>? capabilities,
    _igae4vn6.CapabilityMatch? match,
    bool? flagged,
  }) {
    return EmergencyResult(
      facilityId: facilityId ?? this.facilityId,
      name: name ?? this.name,
      address: address ?? this.address,
      area: area ?? this.area,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      deskPhone: deskPhone is String? ? deskPhone : this.deskPhone,
      distanceKm: distanceKm ?? this.distanceKm,
      etaMinutes: etaMinutes ?? this.etaMinutes,
      rankTier: rankTier ?? this.rankTier,
      freshness: freshness ?? this.freshness,
      statusUpdatedAt: statusUpdatedAt is DateTime?
          ? statusUpdatedAt
          : this.statusUpdatedAt,
      erBedsFree: erBedsFree is int? ? erBedsFree : this.erBedsFree,
      icuBedsFree: icuBedsFree is int? ? icuBedsFree : this.icuBedsFree,
      doctorOnDuty: doctorOnDuty is bool? ? doctorOnDuty : this.doctorOnDuty,
      depositRequired: depositRequired is bool?
          ? depositRequired
          : this.depositRequired,
      capabilities: capabilities ?? this.capabilities.map((e0) => e0).toList(),
      match: match ?? this.match,
      flagged: flagged ?? this.flagged,
    );
  }
}
