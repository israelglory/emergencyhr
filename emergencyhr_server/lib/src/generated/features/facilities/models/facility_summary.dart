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
import 'package:serverpod/serverpod.dart' as _is;
import '../../../features/facilities/models/onboarding_stage.dart' as _ibrba1hx;
import '../../../features/facilities/models/verification_status.dart'
    as _ipq8k6fl;

/// Lightweight facility reference for lists and role context.
abstract class FacilitySummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FacilitySummary._({
    required this.id,
    required this.name,
    required this.area,
    required this.onboardingStage,
    required this.verificationStatus,
  });

  factory FacilitySummary({
    required int id,
    required String name,
    required String area,
    required _ibrba1hx.OnboardingStage onboardingStage,
    required _ipq8k6fl.VerificationStatus verificationStatus,
  }) = _FacilitySummaryImpl;

  factory FacilitySummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilitySummary(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      area: jsonSerialization['area'] as String,
      onboardingStage: _ibrba1hx.OnboardingStage.fromJson(
        (jsonSerialization['onboardingStage'] as String),
      ),
      verificationStatus: _ipq8k6fl.VerificationStatus.fromJson(
        (jsonSerialization['verificationStatus'] as String),
      ),
    );
  }

  int id;

  String name;

  String area;

  _ibrba1hx.OnboardingStage onboardingStage;

  _ipq8k6fl.VerificationStatus verificationStatus;

  /// Returns a shallow copy of this [FacilitySummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FacilitySummary copyWith({
    int? id,
    String? name,
    String? area,
    _ibrba1hx.OnboardingStage? onboardingStage,
    _ipq8k6fl.VerificationStatus? verificationStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilitySummary',
      'id': id,
      'name': name,
      'area': area,
      'onboardingStage': onboardingStage.toJson(),
      'verificationStatus': verificationStatus.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilitySummary',
      'id': id,
      'name': name,
      'area': area,
      'onboardingStage': onboardingStage.toJson(),
      'verificationStatus': verificationStatus.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FacilitySummaryImpl extends FacilitySummary {
  _FacilitySummaryImpl({
    required int id,
    required String name,
    required String area,
    required _ibrba1hx.OnboardingStage onboardingStage,
    required _ipq8k6fl.VerificationStatus verificationStatus,
  }) : super._(
         id: id,
         name: name,
         area: area,
         onboardingStage: onboardingStage,
         verificationStatus: verificationStatus,
       );

  /// Returns a shallow copy of this [FacilitySummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FacilitySummary copyWith({
    int? id,
    String? name,
    String? area,
    _ibrba1hx.OnboardingStage? onboardingStage,
    _ipq8k6fl.VerificationStatus? verificationStatus,
  }) {
    return FacilitySummary(
      id: id ?? this.id,
      name: name ?? this.name,
      area: area ?? this.area,
      onboardingStage: onboardingStage ?? this.onboardingStage,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}
