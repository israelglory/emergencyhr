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
import '../../../features/onboarding/models/checklist_item.dart' as _i3rd1u4b;

/// Computed server-side. When every item is done the facility goes live.
abstract class GoLiveChecklist
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GoLiveChecklist._({
    required this.facilityId,
    required this.items,
    required this.complete,
  });

  factory GoLiveChecklist({
    required int facilityId,
    required List<_i3rd1u4b.ChecklistItem> items,
    required bool complete,
  }) = _GoLiveChecklistImpl;

  factory GoLiveChecklist.fromJson(Map<String, dynamic> jsonSerialization) {
    return GoLiveChecklist(
      facilityId: jsonSerialization['facilityId'] as int,
      items: _ivwsyfsq.Protocol().deserialize<List<_i3rd1u4b.ChecklistItem>>(
        jsonSerialization['items'],
      ),
      complete: _isc.BoolJsonExtension.fromJson(jsonSerialization['complete']),
    );
  }

  int facilityId;

  List<_i3rd1u4b.ChecklistItem> items;

  bool complete;

  /// Returns a shallow copy of this [GoLiveChecklist]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GoLiveChecklist copyWith({
    int? facilityId,
    List<_i3rd1u4b.ChecklistItem>? items,
    bool? complete,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GoLiveChecklist',
      'facilityId': facilityId,
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'complete': complete,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GoLiveChecklist',
      'facilityId': facilityId,
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'complete': complete,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _GoLiveChecklistImpl extends GoLiveChecklist {
  _GoLiveChecklistImpl({
    required int facilityId,
    required List<_i3rd1u4b.ChecklistItem> items,
    required bool complete,
  }) : super._(
         facilityId: facilityId,
         items: items,
         complete: complete,
       );

  /// Returns a shallow copy of this [GoLiveChecklist]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GoLiveChecklist copyWith({
    int? facilityId,
    List<_i3rd1u4b.ChecklistItem>? items,
    bool? complete,
  }) {
    return GoLiveChecklist(
      facilityId: facilityId ?? this.facilityId,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      complete: complete ?? this.complete,
    );
  }
}
