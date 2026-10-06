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
import '../../../features/onboarding/models/checklist_key.dart' as _is370f8w;

abstract class ChecklistItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChecklistItem._({
    required this.key,
    required this.label,
    required this.done,
  });

  factory ChecklistItem({
    required _is370f8w.ChecklistKey key,
    required String label,
    required bool done,
  }) = _ChecklistItemImpl;

  factory ChecklistItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChecklistItem(
      key: _is370f8w.ChecklistKey.fromJson(
        (jsonSerialization['key'] as String),
      ),
      label: jsonSerialization['label'] as String,
      done: _isc.BoolJsonExtension.fromJson(jsonSerialization['done']),
    );
  }

  _is370f8w.ChecklistKey key;

  String label;

  bool done;

  /// Returns a shallow copy of this [ChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChecklistItem copyWith({
    _is370f8w.ChecklistKey? key,
    String? label,
    bool? done,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChecklistItem',
      'key': key.toJson(),
      'label': label,
      'done': done,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChecklistItem',
      'key': key.toJson(),
      'label': label,
      'done': done,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ChecklistItemImpl extends ChecklistItem {
  _ChecklistItemImpl({
    required _is370f8w.ChecklistKey key,
    required String label,
    required bool done,
  }) : super._(
         key: key,
         label: label,
         done: done,
       );

  /// Returns a shallow copy of this [ChecklistItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChecklistItem copyWith({
    _is370f8w.ChecklistKey? key,
    String? label,
    bool? done,
  }) {
    return ChecklistItem(
      key: key ?? this.key,
      label: label ?? this.label,
      done: done ?? this.done,
    );
  }
}
