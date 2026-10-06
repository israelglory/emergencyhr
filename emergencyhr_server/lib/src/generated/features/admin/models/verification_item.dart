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
import '../../../features/facilities/models/facility_document.dart'
    as _i3riwkpy;
import '../../../features/facilities/models/facility_summary.dart' as _i66m7xcg;
import '../../../features/onboarding/models/go_live_checklist.dart'
    as _i6d3gdzv;

abstract class VerificationItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VerificationItem._({
    required this.facility,
    required this.address,
    this.submittedAt,
    this.submittedByName,
    this.notes,
    required this.documents,
    required this.checklist,
  });

  factory VerificationItem({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    DateTime? submittedAt,
    String? submittedByName,
    String? notes,
    required List<_i3riwkpy.FacilityDocument> documents,
    required _i6d3gdzv.GoLiveChecklist checklist,
  }) = _VerificationItemImpl;

  factory VerificationItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return VerificationItem(
      facility: _ilvcm0hz.Protocol().deserialize<_i66m7xcg.FacilitySummary>(
        jsonSerialization['facility'],
      ),
      address: jsonSerialization['address'] as String,
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      submittedByName: jsonSerialization['submittedByName'] as String?,
      notes: jsonSerialization['notes'] as String?,
      documents: _ilvcm0hz.Protocol()
          .deserialize<List<_i3riwkpy.FacilityDocument>>(
            jsonSerialization['documents'],
          ),
      checklist: _ilvcm0hz.Protocol().deserialize<_i6d3gdzv.GoLiveChecklist>(
        jsonSerialization['checklist'],
      ),
    );
  }

  _i66m7xcg.FacilitySummary facility;

  String address;

  DateTime? submittedAt;

  String? submittedByName;

  String? notes;

  List<_i3riwkpy.FacilityDocument> documents;

  _i6d3gdzv.GoLiveChecklist checklist;

  /// Returns a shallow copy of this [VerificationItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VerificationItem copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    DateTime? submittedAt,
    String? submittedByName,
    String? notes,
    List<_i3riwkpy.FacilityDocument>? documents,
    _i6d3gdzv.GoLiveChecklist? checklist,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VerificationItem',
      'facility': facility.toJson(),
      'address': address,
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (submittedByName != null) 'submittedByName': submittedByName,
      if (notes != null) 'notes': notes,
      'documents': documents.toJson(valueToJson: (v) => v.toJson()),
      'checklist': checklist.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VerificationItem',
      'facility': facility.toJsonForProtocol(),
      'address': address,
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (submittedByName != null) 'submittedByName': submittedByName,
      if (notes != null) 'notes': notes,
      'documents': documents.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'checklist': checklist.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VerificationItemImpl extends VerificationItem {
  _VerificationItemImpl({
    required _i66m7xcg.FacilitySummary facility,
    required String address,
    DateTime? submittedAt,
    String? submittedByName,
    String? notes,
    required List<_i3riwkpy.FacilityDocument> documents,
    required _i6d3gdzv.GoLiveChecklist checklist,
  }) : super._(
         facility: facility,
         address: address,
         submittedAt: submittedAt,
         submittedByName: submittedByName,
         notes: notes,
         documents: documents,
         checklist: checklist,
       );

  /// Returns a shallow copy of this [VerificationItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VerificationItem copyWith({
    _i66m7xcg.FacilitySummary? facility,
    String? address,
    Object? submittedAt = _Undefined,
    Object? submittedByName = _Undefined,
    Object? notes = _Undefined,
    List<_i3riwkpy.FacilityDocument>? documents,
    _i6d3gdzv.GoLiveChecklist? checklist,
  }) {
    return VerificationItem(
      facility: facility ?? this.facility.copyWith(),
      address: address ?? this.address,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      submittedByName: submittedByName is String?
          ? submittedByName
          : this.submittedByName,
      notes: notes is String? ? notes : this.notes,
      documents:
          documents ?? this.documents.map((e0) => e0.copyWith()).toList(),
      checklist: checklist ?? this.checklist.copyWith(),
    );
  }
}
