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
import '../../../features/facilities/models/facility_source.dart' as _i33gs98b;
import '../../../features/facilities/models/facility_type.dart' as _ieko45br;
import '../../../features/facilities/models/onboarding_stage.dart' as _ibrba1hx;
import '../../../features/facilities/models/opening_hours.dart' as _iy9wan3d;
import '../../../features/facilities/models/verification_status.dart'
    as _ipq8k6fl;

abstract class Facility
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Facility._({
    this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.area,
    required this.lat,
    required this.lng,
    this.deskPhone,
    this.deskPhoneConfirmedAt,
    this.contactName,
    this.contactPhone,
    required this.verificationStatus,
    required this.onboardingStage,
    required this.source,
    this.sourceRef,
    this.liveAt,
    this.openingHours,
    this.trainingCompletedAt,
    this.flaggedAt,
    this.suspendedAt,
    this.suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Facility({
    int? id,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    DateTime? deskPhoneConfirmedAt,
    String? contactName,
    String? contactPhone,
    required _ipq8k6fl.VerificationStatus verificationStatus,
    required _ibrba1hx.OnboardingStage onboardingStage,
    required _i33gs98b.FacilitySource source,
    String? sourceRef,
    DateTime? liveAt,
    _iy9wan3d.OpeningHours? openingHours,
    DateTime? trainingCompletedAt,
    DateTime? flaggedAt,
    DateTime? suspendedAt,
    String? suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FacilityImpl;

  factory Facility.fromJson(Map<String, dynamic> jsonSerialization) {
    return Facility(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: _ieko45br.FacilityType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      address: jsonSerialization['address'] as String,
      area: jsonSerialization['area'] as String,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      deskPhone: jsonSerialization['deskPhone'] as String?,
      deskPhoneConfirmedAt: jsonSerialization['deskPhoneConfirmedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['deskPhoneConfirmedAt'],
            ),
      contactName: jsonSerialization['contactName'] as String?,
      contactPhone: jsonSerialization['contactPhone'] as String?,
      verificationStatus: _ipq8k6fl.VerificationStatus.fromJson(
        (jsonSerialization['verificationStatus'] as String),
      ),
      onboardingStage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['onboardingStage'] as String),
      ),
      source: _i33gs98b.FacilitySource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      sourceRef: jsonSerialization['sourceRef'] as String?,
      liveAt: jsonSerialization['liveAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['liveAt']),
      openingHours: jsonSerialization['openingHours'] == null
          ? null
          : _ivwsyfsq.Protocol().deserialize<_iy9wan3d.OpeningHours>(
              jsonSerialization['openingHours'],
            ),
      trainingCompletedAt: jsonSerialization['trainingCompletedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['trainingCompletedAt'],
            ),
      flaggedAt: jsonSerialization['flaggedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['flaggedAt']),
      suspendedAt: jsonSerialization['suspendedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['suspendedAt'],
            ),
      suspendReason: jsonSerialization['suspendReason'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  _ieko45br.FacilityType type;

  String address;

  /// Pilot area name, e.g. "Ikeja".
  String area;

  double lat;

  double lng;

  String? deskPhone;

  DateTime? deskPhoneConfirmedAt;

  String? contactName;

  String? contactPhone;

  _ipq8k6fl.VerificationStatus verificationStatus;

  _ibrba1hx.OnboardingStage onboardingStage;

  _i33gs98b.FacilitySource source;

  /// Where an imported listing came from, e.g. "grid3-nga-v2:<id>". Lets
  /// the same file be imported again without creating duplicates.
  String? sourceRef;

  DateTime? liveAt;

  _iy9wan3d.OpeningHours? openingHours;

  DateTime? trainingCompletedAt;

  /// Set when three wrong-status reports arrive within 24 hours.
  DateTime? flaggedAt;

  DateTime? suspendedAt;

  String? suspendReason;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Facility copyWith({
    int? id,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    String? deskPhone,
    DateTime? deskPhoneConfirmedAt,
    String? contactName,
    String? contactPhone,
    _ipq8k6fl.VerificationStatus? verificationStatus,
    _ibrba1hx.OnboardingStage? onboardingStage,
    _i33gs98b.FacilitySource? source,
    String? sourceRef,
    DateTime? liveAt,
    _iy9wan3d.OpeningHours? openingHours,
    DateTime? trainingCompletedAt,
    DateTime? flaggedAt,
    DateTime? suspendedAt,
    String? suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Facility',
      if (id != null) 'id': id,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (deskPhoneConfirmedAt != null)
        'deskPhoneConfirmedAt': deskPhoneConfirmedAt?.toJson(),
      if (contactName != null) 'contactName': contactName,
      if (contactPhone != null) 'contactPhone': contactPhone,
      'verificationStatus': verificationStatus.toJson(),
      'onboardingStage': onboardingStage.toJson(),
      'source': source.toJson(),
      if (sourceRef != null) 'sourceRef': sourceRef,
      if (liveAt != null) 'liveAt': liveAt?.toJson(),
      if (openingHours != null) 'openingHours': openingHours?.toJson(),
      if (trainingCompletedAt != null)
        'trainingCompletedAt': trainingCompletedAt?.toJson(),
      if (flaggedAt != null) 'flaggedAt': flaggedAt?.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Facility',
      if (id != null) 'id': id,
      'name': name,
      'type': type.toJson(),
      'address': address,
      'area': area,
      'lat': lat,
      'lng': lng,
      if (deskPhone != null) 'deskPhone': deskPhone,
      if (deskPhoneConfirmedAt != null)
        'deskPhoneConfirmedAt': deskPhoneConfirmedAt?.toJson(),
      if (contactName != null) 'contactName': contactName,
      if (contactPhone != null) 'contactPhone': contactPhone,
      'verificationStatus': verificationStatus.toJson(),
      'onboardingStage': onboardingStage.toJson(),
      'source': source.toJson(),
      if (sourceRef != null) 'sourceRef': sourceRef,
      if (liveAt != null) 'liveAt': liveAt?.toJson(),
      if (openingHours != null)
        'openingHours': openingHours?.toJsonForProtocol(),
      if (trainingCompletedAt != null)
        'trainingCompletedAt': trainingCompletedAt?.toJson(),
      if (flaggedAt != null) 'flaggedAt': flaggedAt?.toJson(),
      if (suspendedAt != null) 'suspendedAt': suspendedAt?.toJson(),
      if (suspendReason != null) 'suspendReason': suspendReason,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityImpl extends Facility {
  _FacilityImpl({
    int? id,
    required String name,
    required _ieko45br.FacilityType type,
    required String address,
    required String area,
    required double lat,
    required double lng,
    String? deskPhone,
    DateTime? deskPhoneConfirmedAt,
    String? contactName,
    String? contactPhone,
    required _ipq8k6fl.VerificationStatus verificationStatus,
    required _ibrba1hx.OnboardingStage onboardingStage,
    required _i33gs98b.FacilitySource source,
    String? sourceRef,
    DateTime? liveAt,
    _iy9wan3d.OpeningHours? openingHours,
    DateTime? trainingCompletedAt,
    DateTime? flaggedAt,
    DateTime? suspendedAt,
    String? suspendReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         type: type,
         address: address,
         area: area,
         lat: lat,
         lng: lng,
         deskPhone: deskPhone,
         deskPhoneConfirmedAt: deskPhoneConfirmedAt,
         contactName: contactName,
         contactPhone: contactPhone,
         verificationStatus: verificationStatus,
         onboardingStage: onboardingStage,
         source: source,
         sourceRef: sourceRef,
         liveAt: liveAt,
         openingHours: openingHours,
         trainingCompletedAt: trainingCompletedAt,
         flaggedAt: flaggedAt,
         suspendedAt: suspendedAt,
         suspendReason: suspendReason,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Facility]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Facility copyWith({
    Object? id = _Undefined,
    String? name,
    _ieko45br.FacilityType? type,
    String? address,
    String? area,
    double? lat,
    double? lng,
    Object? deskPhone = _Undefined,
    Object? deskPhoneConfirmedAt = _Undefined,
    Object? contactName = _Undefined,
    Object? contactPhone = _Undefined,
    _ipq8k6fl.VerificationStatus? verificationStatus,
    _ibrba1hx.OnboardingStage? onboardingStage,
    _i33gs98b.FacilitySource? source,
    Object? sourceRef = _Undefined,
    Object? liveAt = _Undefined,
    Object? openingHours = _Undefined,
    Object? trainingCompletedAt = _Undefined,
    Object? flaggedAt = _Undefined,
    Object? suspendedAt = _Undefined,
    Object? suspendReason = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Facility(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      area: area ?? this.area,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      deskPhone: deskPhone is String? ? deskPhone : this.deskPhone,
      deskPhoneConfirmedAt: deskPhoneConfirmedAt is DateTime?
          ? deskPhoneConfirmedAt
          : this.deskPhoneConfirmedAt,
      contactName: contactName is String? ? contactName : this.contactName,
      contactPhone: contactPhone is String? ? contactPhone : this.contactPhone,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      onboardingStage: onboardingStage ?? this.onboardingStage,
      source: source ?? this.source,
      sourceRef: sourceRef is String? ? sourceRef : this.sourceRef,
      liveAt: liveAt is DateTime? ? liveAt : this.liveAt,
      openingHours: openingHours is _iy9wan3d.OpeningHours?
          ? openingHours
          : this.openingHours?.copyWith(),
      trainingCompletedAt: trainingCompletedAt is DateTime?
          ? trainingCompletedAt
          : this.trainingCompletedAt,
      flaggedAt: flaggedAt is DateTime? ? flaggedAt : this.flaggedAt,
      suspendedAt: suspendedAt is DateTime? ? suspendedAt : this.suspendedAt,
      suspendReason: suspendReason is String?
          ? suspendReason
          : this.suspendReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
