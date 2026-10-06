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
import '../../../features/emergency/models/emergency_type.dart' as _iurmpi7d;

/// Reviewed first-aid guidance for one emergency type.
abstract class FirstAidCard
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FirstAidCard._({
    required this.type,
    required this.title,
    required this.summary,
    required this.doSteps,
    required this.dontSteps,
    this.reviewedBy,
    this.reviewedAt,
    required this.version,
  });

  factory FirstAidCard({
    required _iurmpi7d.EmergencyType type,
    required String title,
    required String summary,
    required List<String> doSteps,
    required List<String> dontSteps,
    String? reviewedBy,
    String? reviewedAt,
    required int version,
  }) = _FirstAidCardImpl;

  factory FirstAidCard.fromJson(Map<String, dynamic> jsonSerialization) {
    return FirstAidCard(
      type: _iurmpi7d.EmergencyType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      title: jsonSerialization['title'] as String,
      summary: jsonSerialization['summary'] as String,
      doSteps: _ilvcm0hz.Protocol().deserialize<List<String>>(
        jsonSerialization['doSteps'],
      ),
      dontSteps: _ilvcm0hz.Protocol().deserialize<List<String>>(
        jsonSerialization['dontSteps'],
      ),
      reviewedBy: jsonSerialization['reviewedBy'] as String?,
      reviewedAt: jsonSerialization['reviewedAt'] as String?,
      version: jsonSerialization['version'] as int,
    );
  }

  _iurmpi7d.EmergencyType type;

  String title;

  String summary;

  List<String> doSteps;

  List<String> dontSteps;

  /// Empty until a clinician signs off. Unreviewed cards are drafts.
  String? reviewedBy;

  String? reviewedAt;

  int version;

  /// Returns a shallow copy of this [FirstAidCard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FirstAidCard copyWith({
    _iurmpi7d.EmergencyType? type,
    String? title,
    String? summary,
    List<String>? doSteps,
    List<String>? dontSteps,
    String? reviewedBy,
    String? reviewedAt,
    int? version,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FirstAidCard',
      'type': type.toJson(),
      'title': title,
      'summary': summary,
      'doSteps': doSteps.toJson(),
      'dontSteps': dontSteps.toJson(),
      if (reviewedBy != null) 'reviewedBy': reviewedBy,
      if (reviewedAt != null) 'reviewedAt': reviewedAt,
      'version': version,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FirstAidCard',
      'type': type.toJson(),
      'title': title,
      'summary': summary,
      'doSteps': doSteps.toJson(),
      'dontSteps': dontSteps.toJson(),
      if (reviewedBy != null) 'reviewedBy': reviewedBy,
      if (reviewedAt != null) 'reviewedAt': reviewedAt,
      'version': version,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FirstAidCardImpl extends FirstAidCard {
  _FirstAidCardImpl({
    required _iurmpi7d.EmergencyType type,
    required String title,
    required String summary,
    required List<String> doSteps,
    required List<String> dontSteps,
    String? reviewedBy,
    String? reviewedAt,
    required int version,
  }) : super._(
         type: type,
         title: title,
         summary: summary,
         doSteps: doSteps,
         dontSteps: dontSteps,
         reviewedBy: reviewedBy,
         reviewedAt: reviewedAt,
         version: version,
       );

  /// Returns a shallow copy of this [FirstAidCard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FirstAidCard copyWith({
    _iurmpi7d.EmergencyType? type,
    String? title,
    String? summary,
    List<String>? doSteps,
    List<String>? dontSteps,
    Object? reviewedBy = _Undefined,
    Object? reviewedAt = _Undefined,
    int? version,
  }) {
    return FirstAidCard(
      type: type ?? this.type,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      doSteps: doSteps ?? this.doSteps.map((e0) => e0).toList(),
      dontSteps: dontSteps ?? this.dontSteps.map((e0) => e0).toList(),
      reviewedBy: reviewedBy is String? ? reviewedBy : this.reviewedBy,
      reviewedAt: reviewedAt is String? ? reviewedAt : this.reviewedAt,
      version: version ?? this.version,
    );
  }
}
