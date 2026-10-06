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
import '../../../features/facilities/models/capability.dart' as _ilg1kmfo;
import '../../../features/facilities/models/facility.dart' as _ipkjk0ay;
import '../../../features/facilities/models/facility_document.dart'
    as _i3riwkpy;
import '../../../features/onboarding/models/go_live_checklist.dart'
    as _i6d3gdzv;
import '../../../features/onboarding/models/onboarding_record.dart'
    as _i0x8ufab;
import '../../../features/status/models/facility_status.dart' as _ih95nrbj;

/// Everything staff, agents and admins need about one facility.
abstract class FacilityDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilityDetail._({
    required this.facility,
    required this.capabilities,
    this.status,
    this.record,
    required this.checklist,
    required this.documents,
  });

  factory FacilityDetail({
    required _ipkjk0ay.Facility facility,
    required List<_ilg1kmfo.Capability> capabilities,
    _ih95nrbj.FacilityStatus? status,
    _i0x8ufab.OnboardingRecord? record,
    required _i6d3gdzv.GoLiveChecklist checklist,
    required List<_i3riwkpy.FacilityDocument> documents,
  }) = _FacilityDetailImpl;

  factory FacilityDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityDetail(
      facility: _ivwsyfsq.Protocol().deserialize<_ipkjk0ay.Facility>(
        jsonSerialization['facility'],
      ),
      capabilities: _ivwsyfsq.Protocol()
          .deserialize<List<_ilg1kmfo.Capability>>(
            jsonSerialization['capabilities'],
          ),
      status: jsonSerialization['status'] == null
          ? null
          : _ivwsyfsq.Protocol().deserialize<_ih95nrbj.FacilityStatus>(
              jsonSerialization['status'],
            ),
      record: jsonSerialization['record'] == null
          ? null
          : _ivwsyfsq.Protocol().deserialize<_i0x8ufab.OnboardingRecord>(
              jsonSerialization['record'],
            ),
      checklist: _ivwsyfsq.Protocol().deserialize<_i6d3gdzv.GoLiveChecklist>(
        jsonSerialization['checklist'],
      ),
      documents: _ivwsyfsq.Protocol()
          .deserialize<List<_i3riwkpy.FacilityDocument>>(
            jsonSerialization['documents'],
          ),
    );
  }

  _ipkjk0ay.Facility facility;

  List<_ilg1kmfo.Capability> capabilities;

  _ih95nrbj.FacilityStatus? status;

  _i0x8ufab.OnboardingRecord? record;

  _i6d3gdzv.GoLiveChecklist checklist;

  List<_i3riwkpy.FacilityDocument> documents;

  /// Returns a shallow copy of this [FacilityDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilityDetail copyWith({
    _ipkjk0ay.Facility? facility,
    List<_ilg1kmfo.Capability>? capabilities,
    _ih95nrbj.FacilityStatus? status,
    _i0x8ufab.OnboardingRecord? record,
    _i6d3gdzv.GoLiveChecklist? checklist,
    List<_i3riwkpy.FacilityDocument>? documents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityDetail',
      'facility': facility.toJson(),
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
      if (status != null) 'status': status?.toJson(),
      if (record != null) 'record': record?.toJson(),
      'checklist': checklist.toJson(),
      'documents': documents.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityDetail',
      'facility': facility.toJsonForProtocol(),
      'capabilities': capabilities.toJson(valueToJson: (v) => v.toJson()),
      if (status != null) 'status': status?.toJsonForProtocol(),
      if (record != null) 'record': record?.toJsonForProtocol(),
      'checklist': checklist.toJsonForProtocol(),
      'documents': documents.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityDetailImpl extends FacilityDetail {
  _FacilityDetailImpl({
    required _ipkjk0ay.Facility facility,
    required List<_ilg1kmfo.Capability> capabilities,
    _ih95nrbj.FacilityStatus? status,
    _i0x8ufab.OnboardingRecord? record,
    required _i6d3gdzv.GoLiveChecklist checklist,
    required List<_i3riwkpy.FacilityDocument> documents,
  }) : super._(
         facility: facility,
         capabilities: capabilities,
         status: status,
         record: record,
         checklist: checklist,
         documents: documents,
       );

  /// Returns a shallow copy of this [FacilityDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilityDetail copyWith({
    _ipkjk0ay.Facility? facility,
    List<_ilg1kmfo.Capability>? capabilities,
    Object? status = _Undefined,
    Object? record = _Undefined,
    _i6d3gdzv.GoLiveChecklist? checklist,
    List<_i3riwkpy.FacilityDocument>? documents,
  }) {
    return FacilityDetail(
      facility: facility ?? this.facility.copyWith(),
      capabilities: capabilities ?? this.capabilities.map((e0) => e0).toList(),
      status: status is _ih95nrbj.FacilityStatus?
          ? status
          : this.status?.copyWith(),
      record: record is _i0x8ufab.OnboardingRecord?
          ? record
          : this.record?.copyWith(),
      checklist: checklist ?? this.checklist.copyWith(),
      documents:
          documents ?? this.documents.map((e0) => e0.copyWith()).toList(),
    );
  }
}
