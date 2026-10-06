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
import '../../../features/emergency/models/emergency_result.dart' as _i53udy69;
import '../../../features/emergency/models/emergency_type.dart' as _iurmpi7d;

/// Ranked results for one emergency session.
abstract class EmergencySearch
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmergencySearch._({
    required this.sessionId,
    required this.accessToken,
    required this.emergencyType,
    required this.radiusKm,
    required this.results,
    required this.showCall112,
    required this.computedAt,
  });

  factory EmergencySearch({
    required int sessionId,
    required String accessToken,
    required _iurmpi7d.EmergencyType emergencyType,
    required double radiusKm,
    required List<_i53udy69.EmergencyResult> results,
    required bool showCall112,
    required DateTime computedAt,
  }) = _EmergencySearchImpl;

  factory EmergencySearch.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmergencySearch(
      sessionId: jsonSerialization['sessionId'] as int,
      accessToken: jsonSerialization['accessToken'] as String,
      emergencyType: _iurmpi7d.EmergencyType.fromJson(
        (jsonSerialization['emergencyType'] as String),
      ),
      radiusKm: (jsonSerialization['radiusKm'] as num).toDouble(),
      results: _ivwsyfsq.Protocol()
          .deserialize<List<_i53udy69.EmergencyResult>>(
            jsonSerialization['results'],
          ),
      showCall112: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['showCall112'],
      ),
      computedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['computedAt'],
      ),
    );
  }

  int sessionId;

  /// Lets a guest record actions on their own session. Keep it private.
  String accessToken;

  _iurmpi7d.EmergencyType emergencyType;

  double radiusKm;

  List<_i53udy69.EmergencyResult> results;

  /// No accepting facility within 25 km: show Call 112 prominently.
  bool showCall112;

  DateTime computedAt;

  /// Returns a shallow copy of this [EmergencySearch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmergencySearch copyWith({
    int? sessionId,
    String? accessToken,
    _iurmpi7d.EmergencyType? emergencyType,
    double? radiusKm,
    List<_i53udy69.EmergencyResult>? results,
    bool? showCall112,
    DateTime? computedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmergencySearch',
      'sessionId': sessionId,
      'accessToken': accessToken,
      'emergencyType': emergencyType.toJson(),
      'radiusKm': radiusKm,
      'results': results.toJson(valueToJson: (v) => v.toJson()),
      'showCall112': showCall112,
      'computedAt': computedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmergencySearch',
      'sessionId': sessionId,
      'accessToken': accessToken,
      'emergencyType': emergencyType.toJson(),
      'radiusKm': radiusKm,
      'results': results.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'showCall112': showCall112,
      'computedAt': computedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _EmergencySearchImpl extends EmergencySearch {
  _EmergencySearchImpl({
    required int sessionId,
    required String accessToken,
    required _iurmpi7d.EmergencyType emergencyType,
    required double radiusKm,
    required List<_i53udy69.EmergencyResult> results,
    required bool showCall112,
    required DateTime computedAt,
  }) : super._(
         sessionId: sessionId,
         accessToken: accessToken,
         emergencyType: emergencyType,
         radiusKm: radiusKm,
         results: results,
         showCall112: showCall112,
         computedAt: computedAt,
       );

  /// Returns a shallow copy of this [EmergencySearch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmergencySearch copyWith({
    int? sessionId,
    String? accessToken,
    _iurmpi7d.EmergencyType? emergencyType,
    double? radiusKm,
    List<_i53udy69.EmergencyResult>? results,
    bool? showCall112,
    DateTime? computedAt,
  }) {
    return EmergencySearch(
      sessionId: sessionId ?? this.sessionId,
      accessToken: accessToken ?? this.accessToken,
      emergencyType: emergencyType ?? this.emergencyType,
      radiusKm: radiusKm ?? this.radiusKm,
      results: results ?? this.results.map((e0) => e0.copyWith()).toList(),
      showCall112: showCall112 ?? this.showCall112,
      computedAt: computedAt ?? this.computedAt,
    );
  }
}
