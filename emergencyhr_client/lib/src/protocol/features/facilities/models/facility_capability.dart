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
import '../../../features/facilities/models/capability.dart' as _ilg1kmfo;

abstract class FacilityCapability
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilityCapability._({
    this.id,
    required this.facilityId,
    required this.capability,
  });

  factory FacilityCapability({
    int? id,
    required int facilityId,
    required _ilg1kmfo.Capability capability,
  }) = _FacilityCapabilityImpl;

  factory FacilityCapability.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityCapability(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      capability: _ilg1kmfo.Capability.fromJson(
        (jsonSerialization['capability'] as String),
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int facilityId;

  _ilg1kmfo.Capability capability;

  /// Returns a shallow copy of this [FacilityCapability]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilityCapability copyWith({
    int? id,
    int? facilityId,
    _ilg1kmfo.Capability? capability,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityCapability',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'capability': capability.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityCapability',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'capability': capability.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityCapabilityImpl extends FacilityCapability {
  _FacilityCapabilityImpl({
    int? id,
    required int facilityId,
    required _ilg1kmfo.Capability capability,
  }) : super._(
         id: id,
         facilityId: facilityId,
         capability: capability,
       );

  /// Returns a shallow copy of this [FacilityCapability]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilityCapability copyWith({
    Object? id = _Undefined,
    int? facilityId,
    _ilg1kmfo.Capability? capability,
  }) {
    return FacilityCapability(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      capability: capability ?? this.capability,
    );
  }
}
