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
import '../../../features/emergency/models/emergency_action.dart' as _i479lbe3;
import '../../../features/emergency/models/emergency_type.dart' as _iurmpi7d;

/// One use of the Emergency flow. startedAt to actedAt is the north star metric.
abstract class EmergencySession
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmergencySession._({
    this.id,
    this.userId,
    required this.lat,
    required this.lng,
    this.area,
    required this.emergencyType,
    required this.resultsShown,
    bool? emptyResult,
    required this.action,
    this.facilityId,
    required this.startedAt,
    this.actedAt,
  }) : emptyResult = emptyResult ?? false;

  factory EmergencySession({
    int? id,
    int? userId,
    required double lat,
    required double lng,
    String? area,
    required _iurmpi7d.EmergencyType emergencyType,
    required List<int> resultsShown,
    bool? emptyResult,
    required _i479lbe3.EmergencyAction action,
    int? facilityId,
    required DateTime startedAt,
    DateTime? actedAt,
  }) = _EmergencySessionImpl;

  factory EmergencySession.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencySession(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      lat: (jsonSerialization['lat'] as num).toDouble(),
      lng: (jsonSerialization['lng'] as num).toDouble(),
      area: jsonSerialization['area'] as String?,
      emergencyType: _iurmpi7d.EmergencyType.fromJson(
        (jsonSerialization['emergencyType'] as String),
      ),
      resultsShown: _ivwsyfsq.Protocol().deserialize<List<int>>(
        jsonSerialization['resultsShown'],
      ),
      emptyResult: jsonSerialization['emptyResult'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['emptyResult']),
      action: _i479lbe3.EmergencyAction.fromJson(
        (jsonSerialization['action'] as String),
      ),
      facilityId: jsonSerialization['facilityId'] as int?,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      actedAt: jsonSerialization['actedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['actedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? userId;

  double lat;

  double lng;

  String? area;

  _iurmpi7d.EmergencyType emergencyType;

  List<int> resultsShown;

  bool emptyResult;

  _i479lbe3.EmergencyAction action;

  int? facilityId;

  DateTime startedAt;

  DateTime? actedAt;

  /// Returns a shallow copy of this [EmergencySession]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmergencySession copyWith({
    int? id,
    int? userId,
    double? lat,
    double? lng,
    String? area,
    _iurmpi7d.EmergencyType? emergencyType,
    List<int>? resultsShown,
    bool? emptyResult,
    _i479lbe3.EmergencyAction? action,
    int? facilityId,
    DateTime? startedAt,
    DateTime? actedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmergencySession',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'lat': lat,
      'lng': lng,
      if (area != null) 'area': area,
      'emergencyType': emergencyType.toJson(),
      'resultsShown': resultsShown.toJson(),
      'emptyResult': emptyResult,
      'action': action.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'startedAt': startedAt.toJson(),
      if (actedAt != null) 'actedAt': actedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmergencySession',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      'lat': lat,
      'lng': lng,
      if (area != null) 'area': area,
      'emergencyType': emergencyType.toJson(),
      'resultsShown': resultsShown.toJson(),
      'emptyResult': emptyResult,
      'action': action.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'startedAt': startedAt.toJson(),
      if (actedAt != null) 'actedAt': actedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmergencySessionImpl extends EmergencySession {
  _EmergencySessionImpl({
    int? id,
    int? userId,
    required double lat,
    required double lng,
    String? area,
    required _iurmpi7d.EmergencyType emergencyType,
    required List<int> resultsShown,
    bool? emptyResult,
    required _i479lbe3.EmergencyAction action,
    int? facilityId,
    required DateTime startedAt,
    DateTime? actedAt,
  }) : super._(
         id: id,
         userId: userId,
         lat: lat,
         lng: lng,
         area: area,
         emergencyType: emergencyType,
         resultsShown: resultsShown,
         emptyResult: emptyResult,
         action: action,
         facilityId: facilityId,
         startedAt: startedAt,
         actedAt: actedAt,
       );

  /// Returns a shallow copy of this [EmergencySession]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmergencySession copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    double? lat,
    double? lng,
    Object? area = _Undefined,
    _iurmpi7d.EmergencyType? emergencyType,
    List<int>? resultsShown,
    bool? emptyResult,
    _i479lbe3.EmergencyAction? action,
    Object? facilityId = _Undefined,
    DateTime? startedAt,
    Object? actedAt = _Undefined,
  }) {
    return EmergencySession(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      area: area is String? ? area : this.area,
      emergencyType: emergencyType ?? this.emergencyType,
      resultsShown: resultsShown ?? this.resultsShown.map((e0) => e0).toList(),
      emptyResult: emptyResult ?? this.emptyResult,
      action: action ?? this.action,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      startedAt: startedAt ?? this.startedAt,
      actedAt: actedAt is DateTime? ? actedAt : this.actedAt,
    );
  }
}
