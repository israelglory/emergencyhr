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
import '../../../features/assistant/models/chat_event_kind.dart' as _ie7bwf3q;
import '../../../features/emergency/models/emergency_type.dart' as _iurmpi7d;

/// One event in a streamed Health Assistant reply.
abstract class ChatEvent
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChatEvent._({
    required this.kind,
    this.conversationId,
    this.text,
    this.emergencyType,
    this.crisis,
  });

  factory ChatEvent({
    required _ie7bwf3q.ChatEventKind kind,
    int? conversationId,
    String? text,
    _iurmpi7d.EmergencyType? emergencyType,
    bool? crisis,
  }) = _ChatEventImpl;

  factory ChatEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatEvent(
      kind: _ie7bwf3q.ChatEventKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      conversationId: jsonSerialization['conversationId'] as int?,
      text: jsonSerialization['text'] as String?,
      emergencyType: jsonSerialization['emergencyType'] == null
          ? null
          : _iurmpi7d.EmergencyType.fromJson(
              (jsonSerialization['emergencyType'] as String),
            ),
      crisis: jsonSerialization['crisis'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['crisis']),
    );
  }

  _ie7bwf3q.ChatEventKind kind;

  int? conversationId;

  String? text;

  /// Set on redFlag: the emergency type to pre-fill in the Emergency flow.
  _iurmpi7d.EmergencyType? emergencyType;

  /// Set on redFlag for self-harm statements.
  bool? crisis;

  /// Returns a shallow copy of this [ChatEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChatEvent copyWith({
    _ie7bwf3q.ChatEventKind? kind,
    int? conversationId,
    String? text,
    _iurmpi7d.EmergencyType? emergencyType,
    bool? crisis,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatEvent',
      'kind': kind.toJson(),
      if (conversationId != null) 'conversationId': conversationId,
      if (text != null) 'text': text,
      if (emergencyType != null) 'emergencyType': emergencyType?.toJson(),
      if (crisis != null) 'crisis': crisis,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatEvent',
      'kind': kind.toJson(),
      if (conversationId != null) 'conversationId': conversationId,
      if (text != null) 'text': text,
      if (emergencyType != null) 'emergencyType': emergencyType?.toJson(),
      if (crisis != null) 'crisis': crisis,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatEventImpl extends ChatEvent {
  _ChatEventImpl({
    required _ie7bwf3q.ChatEventKind kind,
    int? conversationId,
    String? text,
    _iurmpi7d.EmergencyType? emergencyType,
    bool? crisis,
  }) : super._(
         kind: kind,
         conversationId: conversationId,
         text: text,
         emergencyType: emergencyType,
         crisis: crisis,
       );

  /// Returns a shallow copy of this [ChatEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChatEvent copyWith({
    _ie7bwf3q.ChatEventKind? kind,
    Object? conversationId = _Undefined,
    Object? text = _Undefined,
    Object? emergencyType = _Undefined,
    Object? crisis = _Undefined,
  }) {
    return ChatEvent(
      kind: kind ?? this.kind,
      conversationId: conversationId is int?
          ? conversationId
          : this.conversationId,
      text: text is String? ? text : this.text,
      emergencyType: emergencyType is _iurmpi7d.EmergencyType?
          ? emergencyType
          : this.emergencyType,
      crisis: crisis is bool? ? crisis : this.crisis,
    );
  }
}
