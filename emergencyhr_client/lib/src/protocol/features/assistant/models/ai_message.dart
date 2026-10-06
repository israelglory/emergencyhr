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

/// Message content is encrypted at rest.
abstract class AiMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AiMessage._({
    this.id,
    required this.conversationId,
    required this.role,
    bool? redFlagDetected,
    this.suggestedEmergencyType,
    DateTime? createdAt,
  }) : redFlagDetected = redFlagDetected ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory AiMessage({
    int? id,
    required int conversationId,
    required _i32cnwfw.ChatRole role,
    bool? redFlagDetected,
    _iurmpi7d.EmergencyType? suggestedEmergencyType,
    DateTime? createdAt,
  }) = _AiMessageImpl;

  factory AiMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiMessage(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      role: _i32cnwfw.ChatRole.fromJson((jsonSerialization['role'] as String)),
      redFlagDetected: jsonSerialization['redFlagDetected'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['redFlagDetected'],
            ),
      suggestedEmergencyType:
          jsonSerialization['suggestedEmergencyType'] == null
          ? null
          : _iurmpi7d.EmergencyType.fromJson(
              (jsonSerialization['suggestedEmergencyType'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int conversationId;

  _i32cnwfw.ChatRole role;

  bool redFlagDetected;

  _iurmpi7d.EmergencyType? suggestedEmergencyType;

  DateTime createdAt;

  /// Returns a shallow copy of this [AiMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AiMessage copyWith({
    int? id,
    int? conversationId,
    _i32cnwfw.ChatRole? role,
    bool? redFlagDetected,
    _iurmpi7d.EmergencyType? suggestedEmergencyType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'role': role.toJson(),
      'redFlagDetected': redFlagDetected,
      if (suggestedEmergencyType != null)
        'suggestedEmergencyType': suggestedEmergencyType?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'role': role.toJson(),
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

class _AiMessageImpl extends AiMessage {
  _AiMessageImpl({
    int? id,
    required int conversationId,
    required _i32cnwfw.ChatRole role,
    bool? redFlagDetected,
    _iurmpi7d.EmergencyType? suggestedEmergencyType,
    DateTime? createdAt,
  }) : super._(
         id: id,
         conversationId: conversationId,
         role: role,
         redFlagDetected: redFlagDetected,
         suggestedEmergencyType: suggestedEmergencyType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AiMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AiMessage copyWith({
    Object? id = _Undefined,
    int? conversationId,
    _i32cnwfw.ChatRole? role,
    bool? redFlagDetected,
    Object? suggestedEmergencyType = _Undefined,
    DateTime? createdAt,
  }) {
    return AiMessage(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      redFlagDetected: redFlagDetected ?? this.redFlagDetected,
      suggestedEmergencyType: suggestedEmergencyType is _iurmpi7d.EmergencyType?
          ? suggestedEmergencyType
          : this.suggestedEmergencyType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
