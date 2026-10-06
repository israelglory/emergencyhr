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
import '../../../features/facilities/models/onboarding_stage.dart' as _ibrba1hx;

abstract class OnboardingEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OnboardingEvent._({
    this.id,
    required this.facilityId,
    this.fromStage,
    required this.toStage,
    this.byUserId,
    this.note,
    required this.at,
  });

  factory OnboardingEvent({
    int? id,
    required int facilityId,
    _ibrba1hx.OnboardingStage? fromStage,
    required _ibrba1hx.OnboardingStage toStage,
    int? byUserId,
    String? note,
    required DateTime at,
  }) = _OnboardingEventImpl;

  factory OnboardingEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return OnboardingEvent(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      fromStage: jsonSerialization['fromStage'] == null
          ? null
          : _ibrba1hx.OnboardingStage.fromJson(
              (jsonSerialization['fromStage'] as String),
            ),
      toStage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['toStage'] as String),
      ),
      byUserId: jsonSerialization['byUserId'] as int?,
      note: jsonSerialization['note'] as String?,
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int facilityId;

  _ibrba1hx.OnboardingStage? fromStage;

  _ibrba1hx.OnboardingStage toStage;

  int? byUserId;

  String? note;

  DateTime at;

  /// Returns a shallow copy of this [OnboardingEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OnboardingEvent copyWith({
    int? id,
    int? facilityId,
    _ibrba1hx.OnboardingStage? fromStage,
    _ibrba1hx.OnboardingStage? toStage,
    int? byUserId,
    String? note,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnboardingEvent',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (fromStage != null) 'fromStage': fromStage?.toJson(),
      'toStage': toStage.toJson(),
      if (byUserId != null) 'byUserId': byUserId,
      if (note != null) 'note': note,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnboardingEvent',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      if (fromStage != null) 'fromStage': fromStage?.toJson(),
      'toStage': toStage.toJson(),
      if (byUserId != null) 'byUserId': byUserId,
      if (note != null) 'note': note,
      'at': at.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OnboardingEventImpl extends OnboardingEvent {
  _OnboardingEventImpl({
    int? id,
    required int facilityId,
    _ibrba1hx.OnboardingStage? fromStage,
    required _ibrba1hx.OnboardingStage toStage,
    int? byUserId,
    String? note,
    required DateTime at,
  }) : super._(
         id: id,
         facilityId: facilityId,
         fromStage: fromStage,
         toStage: toStage,
         byUserId: byUserId,
         note: note,
         at: at,
       );

  /// Returns a shallow copy of this [OnboardingEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OnboardingEvent copyWith({
    Object? id = _Undefined,
    int? facilityId,
    Object? fromStage = _Undefined,
    _ibrba1hx.OnboardingStage? toStage,
    Object? byUserId = _Undefined,
    Object? note = _Undefined,
    DateTime? at,
  }) {
    return OnboardingEvent(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      fromStage: fromStage is _ibrba1hx.OnboardingStage?
          ? fromStage
          : this.fromStage,
      toStage: toStage ?? this.toStage,
      byUserId: byUserId is int? ? byUserId : this.byUserId,
      note: note is String? ? note : this.note,
      at: at ?? this.at,
    );
  }
}
