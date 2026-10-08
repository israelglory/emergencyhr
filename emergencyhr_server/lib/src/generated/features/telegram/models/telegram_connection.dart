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

/// Whether the signed-in staff member has connected Telegram.
abstract class TelegramConnection
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TelegramConnection._({
    required this.enabled,
    required this.connected,
    this.botUsername,
  });

  factory TelegramConnection({
    required bool enabled,
    required bool connected,
    String? botUsername,
  }) = _TelegramConnectionImpl;

  factory TelegramConnection.fromJson(Map<String, dynamic> jsonSerialization) {
    return TelegramConnection(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      connected: _is.BoolJsonExtension.fromJson(jsonSerialization['connected']),
      botUsername: jsonSerialization['botUsername'] as String?,
    );
  }

  /// False when the bot is switched off on this server.
  bool enabled;

  bool connected;

  /// e.g. EmergencyHrBot.
  String? botUsername;

  /// Returns a shallow copy of this [TelegramConnection]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TelegramConnection copyWith({
    bool? enabled,
    bool? connected,
    String? botUsername,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TelegramConnection',
      'enabled': enabled,
      'connected': connected,
      if (botUsername != null) 'botUsername': botUsername,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TelegramConnection',
      'enabled': enabled,
      'connected': connected,
      if (botUsername != null) 'botUsername': botUsername,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TelegramConnectionImpl extends TelegramConnection {
  _TelegramConnectionImpl({
    required bool enabled,
    required bool connected,
    String? botUsername,
  }) : super._(
         enabled: enabled,
         connected: connected,
         botUsername: botUsername,
       );

  /// Returns a shallow copy of this [TelegramConnection]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TelegramConnection copyWith({
    bool? enabled,
    bool? connected,
    Object? botUsername = _Undefined,
  }) {
    return TelegramConnection(
      enabled: enabled ?? this.enabled,
      connected: connected ?? this.connected,
      botUsername: botUsername is String? ? botUsername : this.botUsername,
    );
  }
}
