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
import '../../../features/onboarding/models/claim_request.dart' as _iusra2vj;

abstract class ClaimQueueItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ClaimQueueItem._({
    required this.claim,
    required this.facility,
    required this.claimantContact,
  });

  factory ClaimQueueItem({
    required _iusra2vj.ClaimRequest claim,
    required _i66m7xcg.FacilitySummary facility,
    required String claimantContact,
  }) = _ClaimQueueItemImpl;

  factory ClaimQueueItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimQueueItem(
      claim: _ilvcm0hz.Protocol().deserialize<_iusra2vj.ClaimRequest>(
        jsonSerialization['claim'],
      ),
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      claimantContact: jsonSerialization['claimantContact'] as String,
    );
  }

  _iusra2vj.ClaimRequest claim;

  _i66m7xcg.FacilitySummary facility;

  String claimantContact;

  /// Returns a shallow copy of this [ClaimQueueItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClaimQueueItem copyWith({
    _iusra2vj.ClaimRequest? claim,
    _i66m7xcg.FacilitySummary? facility,
    String? claimantContact,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClaimQueueItem',
      'claim': claim.toJson(),
      'facility': facility.toJson(),
      'claimantContact': claimantContact,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClaimQueueItem',
      'claim': claim.toJsonForProtocol(),
      'facility': facility.toJsonForProtocol(),
      'claimantContact': claimantContact,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ClaimQueueItemImpl extends ClaimQueueItem {
  _ClaimQueueItemImpl({
    required _iusra2vj.ClaimRequest claim,
    required _i66m7xcg.FacilitySummary facility,
    required String claimantContact,
  }) : super._(
         claim: claim,
         facility: facility,
         claimantContact: claimantContact,
       );

  /// Returns a shallow copy of this [ClaimQueueItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ClaimQueueItem copyWith({
    _iusra2vj.ClaimRequest? claim,
    _i66m7xcg.FacilitySummary? facility,
    String? claimantContact,
  }) {
    return ClaimQueueItem(
      claim: claim ?? this.claim.copyWith(),
      facility: facility ?? this.facility.copyWith(),
      claimantContact: claimantContact ?? this.claimantContact,
    );
  }
}
