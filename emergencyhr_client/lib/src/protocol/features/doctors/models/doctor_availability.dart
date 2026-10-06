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

/// V2 only.
abstract class DoctorAvailability
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DoctorAvailability._({
    this.id,
    required this.doctorId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    bool? onlineNow,
  }) : onlineNow = onlineNow ?? false;

  factory DoctorAvailability({
    int? id,
    required int doctorId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    bool? onlineNow,
  }) = _DoctorAvailabilityImpl;

  factory DoctorAvailability.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoctorAvailability(
      id: jsonSerialization['id'] as int?,
      doctorId: jsonSerialization['doctorId'] as int,
      weekday: jsonSerialization['weekday'] as int,
      startMinute: jsonSerialization['startMinute'] as int,
      endMinute: jsonSerialization['endMinute'] as int,
      onlineNow: jsonSerialization['onlineNow'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['onlineNow']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int doctorId;

  int weekday;

  int startMinute;

  int endMinute;

  bool onlineNow;

  /// Returns a shallow copy of this [DoctorAvailability]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DoctorAvailability copyWith({
    int? id,
    int? doctorId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    bool? onlineNow,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoctorAvailability',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'onlineNow': onlineNow,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoctorAvailability',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'weekday': weekday,
      'startMinute': startMinute,
      'endMinute': endMinute,
      'onlineNow': onlineNow,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoctorAvailabilityImpl extends DoctorAvailability {
  _DoctorAvailabilityImpl({
    int? id,
    required int doctorId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    bool? onlineNow,
  }) : super._(
         id: id,
         doctorId: doctorId,
         weekday: weekday,
         startMinute: startMinute,
         endMinute: endMinute,
         onlineNow: onlineNow,
       );

  /// Returns a shallow copy of this [DoctorAvailability]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DoctorAvailability copyWith({
    Object? id = _Undefined,
    int? doctorId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    bool? onlineNow,
  }) {
    return DoctorAvailability(
      id: id is int? ? id : this.id,
      doctorId: doctorId ?? this.doctorId,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      onlineNow: onlineNow ?? this.onlineNow,
    );
  }
}
