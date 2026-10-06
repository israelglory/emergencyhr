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

/// Live availability, set only by verified staff of the facility.
abstract class FacilityStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilityStatus._({
    this.id,
    required this.facilityId,
    required this.accepting,
    required this.erBedsFree,
    required this.icuBedsFree,
    required this.doctorOnDuty,
    required this.depositRequired,
    this.updatedByUserId,
    required this.updatedAt,
  });

  factory FacilityStatus({
    int? id,
    required int facilityId,
    required bool accepting,
    required int erBedsFree,
    required int icuBedsFree,
    required bool doctorOnDuty,
    required bool depositRequired,
    int? updatedByUserId,
    required DateTime updatedAt,
  }) = _FacilityStatusImpl;

  factory FacilityStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityStatus(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      accepting: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['accepting'],
      ),
      erBedsFree: jsonSerialization['erBedsFree'] as int,
      icuBedsFree: jsonSerialization['icuBedsFree'] as int,
      doctorOnDuty: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['doctorOnDuty'],
      ),
      depositRequired: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['depositRequired'],
      ),
      updatedByUserId: jsonSerialization['updatedByUserId'] as int?,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int facilityId;

  bool accepting;

  int erBedsFree;

  int icuBedsFree;

  bool doctorOnDuty;

  bool depositRequired;

  int? updatedByUserId;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FacilityStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilityStatus copyWith({
    int? id,
    int? facilityId,
    bool? accepting,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
    int? updatedByUserId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityStatus',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'accepting': accepting,
      'erBedsFree': erBedsFree,
      'icuBedsFree': icuBedsFree,
      'doctorOnDuty': doctorOnDuty,
      'depositRequired': depositRequired,
      if (updatedByUserId != null) 'updatedByUserId': updatedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityStatus',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'accepting': accepting,
      'erBedsFree': erBedsFree,
      'icuBedsFree': icuBedsFree,
      'doctorOnDuty': doctorOnDuty,
      'depositRequired': depositRequired,
      if (updatedByUserId != null) 'updatedByUserId': updatedByUserId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityStatusImpl extends FacilityStatus {
  _FacilityStatusImpl({
    int? id,
    required int facilityId,
    required bool accepting,
    required int erBedsFree,
    required int icuBedsFree,
    required bool doctorOnDuty,
    required bool depositRequired,
    int? updatedByUserId,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         accepting: accepting,
         erBedsFree: erBedsFree,
         icuBedsFree: icuBedsFree,
         doctorOnDuty: doctorOnDuty,
         depositRequired: depositRequired,
         updatedByUserId: updatedByUserId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FacilityStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilityStatus copyWith({
    Object? id = _Undefined,
    int? facilityId,
    bool? accepting,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
    Object? updatedByUserId = _Undefined,
    DateTime? updatedAt,
  }) {
    return FacilityStatus(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      accepting: accepting ?? this.accepting,
      erBedsFree: erBedsFree ?? this.erBedsFree,
      icuBedsFree: icuBedsFree ?? this.icuBedsFree,
      doctorOnDuty: doctorOnDuty ?? this.doctorOnDuty,
      depositRequired: depositRequired ?? this.depositRequired,
      updatedByUserId: updatedByUserId is int?
          ? updatedByUserId
          : this.updatedByUserId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
