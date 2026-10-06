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
import '../../../features/facilities/models/facility_summary.dart' as _i66m7xcg;

abstract class DuplicateCandidate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DuplicateCandidate._({
    required this.facility,
    required this.address,
    required this.distanceMeters,
    required this.strong,
  });

  factory DuplicateCandidate({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    required double distanceMeters,
    required bool strong,
  }) = _DuplicateCandidateImpl;

  factory DuplicateCandidate.fromJson(Map<String, dynamic> jsonSerialization) {
    return DuplicateCandidate(
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      address: jsonSerialization['address'] as String,
      distanceMeters: (jsonSerialization['distanceMeters'] as num).toDouble(),
      strong: _is.BoolJsonExtension.fromJson(jsonSerialization['strong']),
    );
  }

  _i66m7xcg.FacilitySummary facility;

  String address;

  double distanceMeters;

  /// Strong matches block creating a new facility.
  bool strong;

  /// Returns a shallow copy of this [DuplicateCandidate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DuplicateCandidate copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    double? distanceMeters,
    bool? strong,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DuplicateCandidate',
      'facility': facility.toJson(),
      'address': address,
      'distanceMeters': distanceMeters,
      'strong': strong,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DuplicateCandidate',
      'facility': facility.toJsonForProtocol(),
      'address': address,
      'distanceMeters': distanceMeters,
      'strong': strong,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DuplicateCandidateImpl extends DuplicateCandidate {
  _DuplicateCandidateImpl({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    required double distanceMeters,
    required bool strong,
  }) : super._(
         facility: facility,
         address: address,
         distanceMeters: distanceMeters,
         strong: strong,
       );

  /// Returns a shallow copy of this [DuplicateCandidate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DuplicateCandidate copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    double? distanceMeters,
    bool? strong,
  }) {
    return DuplicateCandidate(
      facility: facility ?? this.facility.copyWith(),
      address: address ?? this.address,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      strong: strong ?? this.strong,
    );
  }
}
