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
import '../../../features/assistant/models/chat_role.dart' as _i32cnwfw;
import '../../../features/emergency/models/emergency_type.dart' as _iurmpi7d;

/// A decrypted message as shown to its owner.
abstract class ChatMessageView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChatMessageView._({
    required this.id,
    required this.role,
    required this.content,
    required this.redFlagDetected,
    this.suggestedEmergencyType,
    required this.createdAt,
  });

  factory ChatMessageView({
    required int id,
    required _i32cnwfw.ChatRole role,
    required String content,
    required bool redFlagDetected,
    _iurmpi7d.EmergencyType? suggestedEmergencyType,
    required DateTime createdAt,
  }) = _ChatMessageViewImpl;

  factory ChatMessageView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMessageView(
      id: jsonSerialization['id'] as int,
      role: _i32cnwfw.ChatRole.fromJson((jsonSerialization['role'] as String)),
      content: jsonSerialization['content'] as String,
      redFlagDetected: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['redFlagDetected'],
      ),
      suggestedEmergencyType:
          jsonSerialization['suggestedEmergencyType'] == null
          ? null
          : _iurmpi7d.EmergencyType.fromJson(
              (jsonSerialization['suggestedEmergencyType'] as String),
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int id;

  _i32cnwfw.ChatRole role;

  String content;

  bool redFlagDetected;

  _iurmpi7d.EmergencyType? suggestedEmergencyType;

  DateTime createdAt;

  /// Returns a shallow copy of this [ChatMessageView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChatMessageView copyWith({
    int? id,
    _i32cnwfw.ChatRole? role,
    String? content,
    bool? redFlagDetected,
    _iurmpi7d.EmergencyType? suggestedEmergencyType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatMessageView',
      'id': id,
      'role': role.toJson(),
      'content': content,
      'redFlagDetected': redFlagDetected,
      if (suggestedEmergencyType != null)
        'suggestedEmergencyType': suggestedEmergencyType?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatMessageView',
      'id': id,
      'role': role.toJson(),
      'content': content,
      'redFlagDetected': redFlagDetected,
      if (suggestedEmergencyType != null)
        'suggestedEmergencyType': suggestedEmergencyType?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMessageViewImpl extends ChatMessageView {
  _ChatMessageViewImpl({
    required int id,
    required _i32cnwfw.ChatRole role,
    required String content,
    required bool redFlagDetected,
    _iurmpi7d.EmergencyType? suggestedEmergencyType,
    required DateTime createdAt,
  }) : super._(
         id: id,
         role: role,
         content: content,
         redFlagDetected: redFlagDetected,
         suggestedEmergencyType: suggestedEmergencyType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ChatMessageView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChatMessageView copyWith({
    int? id,
    _i32cnwfw.ChatRole? role,
    String? content,
    bool? redFlagDetected,
    Object? suggestedEmergencyType = _Undefined,
    DateTime? createdAt,
  }) {
    return ChatMessageView(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      redFlagDetected: redFlagDetected ?? this.redFlagDetected,
      suggestedEmergencyType: suggestedEmergencyType is _iurmpi7d.EmergencyType?
          ? suggestedEmergencyType
          : this.suggestedEmergencyType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
