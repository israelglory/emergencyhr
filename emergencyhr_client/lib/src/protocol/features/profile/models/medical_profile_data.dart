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

/// Decrypted medical profile as shown to its owner.
abstract class MedicalProfileData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MedicalProfileData._({
    this.bloodGroup,
    this.allergies,
    this.conditions,
    this.medications,
    this.consentAt,
  });

  factory MedicalProfileData({
    String? bloodGroup,
    String? allergies,
    String? conditions,
    String? medications,
    DateTime? consentAt,
  }) = _MedicalProfileDataImpl;

  factory MedicalProfileData.fromJson(Map<String, dynamic> jsonSerialization) {
    return MedicalProfileData(
      bloodGroup: jsonSerialization['bloodGroup'] as String?,
      allergies: jsonSerialization['allergies'] as String?,
      conditions: jsonSerialization['conditions'] as String?,
      medications: jsonSerialization['medications'] as String?,
      consentAt: jsonSerialization['consentAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['consentAt']),
    );
  }

  String? bloodGroup;

  String? allergies;

  String? conditions;

  String? medications;

  DateTime? consentAt;

  /// Returns a shallow copy of this [MedicalProfileData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MedicalProfileData copyWith({
    String? bloodGroup,
    String? allergies,
    String? conditions,
    String? medications,
    DateTime? consentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MedicalProfileData',
      if (bloodGroup != null) 'bloodGroup': bloodGroup,
      if (allergies != null) 'allergies': allergies,
      if (conditions != null) 'conditions': conditions,
      if (medications != null) 'medications': medications,
      if (consentAt != null) 'consentAt': consentAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MedicalProfileData',
      if (bloodGroup != null) 'bloodGroup': bloodGroup,
      if (allergies != null) 'allergies': allergies,
      if (conditions != null) 'conditions': conditions,
      if (medications != null) 'medications': medications,
      if (consentAt != null) 'consentAt': consentAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MedicalProfileDataImpl extends MedicalProfileData {
  _MedicalProfileDataImpl({
    String? bloodGroup,
    String? allergies,
    String? conditions,
    String? medications,
    DateTime? consentAt,
  }) : super._(
         bloodGroup: bloodGroup,
         allergies: allergies,
         conditions: conditions,
         medications: medications,
         consentAt: consentAt,
       );

  /// Returns a shallow copy of this [MedicalProfileData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MedicalProfileData copyWith({
    Object? bloodGroup = _Undefined,
    Object? allergies = _Undefined,
    Object? conditions = _Undefined,
    Object? medications = _Undefined,
    Object? consentAt = _Undefined,
  }) {
    return MedicalProfileData(
      bloodGroup: bloodGroup is String? ? bloodGroup : this.bloodGroup,
      allergies: allergies is String? ? allergies : this.allergies,
      conditions: conditions is String? ? conditions : this.conditions,
      medications: medications is String? ? medications : this.medications,
      consentAt: consentAt is DateTime? ? consentAt : this.consentAt,
    );
  }
}
