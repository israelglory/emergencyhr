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
import '../../../features/status/models/facility_status.dart' as _ih95nrbj;

/// Posted on the facility status channel whenever a live status changes.
abstract class FacilityStatusChanged
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FacilityStatusChanged._({
    required this.facilityId,
    this.status,
    required this.flagged,
  });

  factory FacilityStatusChanged({
    required int facilityId,
    _ih95nrbj.FacilityStatus? status,
    required bool flagged,
  }) = _FacilityStatusChangedImpl;

  factory FacilityStatusChanged.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FacilityStatusChanged(
      facilityId: jsonSerialization['facilityId'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _ilvcm0hz.Protocol().deserialize<_ih95nrbj.FacilityStatus>(
              jsonSerialization['status'],
            ),
      flagged: _is.BoolJsonExtension.fromJson(jsonSerialization['flagged']),
    );
  }

  int facilityId;

  _ih95nrbj.FacilityStatus? status;

  bool flagged;

  /// Returns a shallow copy of this [FacilityStatusChanged]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FacilityStatusChanged copyWith({
    int? facilityId,
    _ih95nrbj.FacilityStatus? status,
    bool? flagged,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityStatusChanged',
      'facilityId': facilityId,
      if (status != null) 'status': status?.toJson(),
      'flagged': flagged,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityStatusChanged',
      'facilityId': facilityId,
      if (status != null) 'status': status?.toJsonForProtocol(),
      'flagged': flagged,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityStatusChangedImpl extends FacilityStatusChanged {
  _FacilityStatusChangedImpl({
    required int facilityId,
    _ih95nrbj.FacilityStatus? status,
    required bool flagged,
  }) : super._(
         facilityId: facilityId,
         status: status,
         flagged: flagged,
       );

  /// Returns a shallow copy of this [FacilityStatusChanged]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FacilityStatusChanged copyWith({
    int? facilityId,
    Object? status = _Undefined,
    bool? flagged,
  }) {
    return FacilityStatusChanged(
      facilityId: facilityId ?? this.facilityId,
      status: status is _ih95nrbj.FacilityStatus?
          ? status
          : this.status?.copyWith(),
      flagged: flagged ?? this.flagged,
    );
  }
}
