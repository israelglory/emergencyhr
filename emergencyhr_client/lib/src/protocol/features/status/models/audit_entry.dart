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

abstract class AuditEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AuditEntry._({
    required this.at,
    required this.userName,
    required this.summary,
    required this.practice,
  });

  factory AuditEntry({
    required DateTime at,
    required String userName,
    required String summary,
    required bool practice,
  }) = _AuditEntryImpl;

  factory AuditEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditEntry(
      at: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
      userName: jsonSerialization['userName'] as String,
      summary: jsonSerialization['summary'] as String,
      practice: _isc.BoolJsonExtension.fromJson(jsonSerialization['practice']),
    );
  }

  DateTime at;

  String userName;

  String summary;

  bool practice;

  /// Returns a shallow copy of this [AuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AuditEntry copyWith({
    DateTime? at,
    String? userName,
    String? summary,
    bool? practice,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditEntry',
      'at': at.toJson(),
      'userName': userName,
      'summary': summary,
      'practice': practice,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuditEntry',
      'at': at.toJson(),
      'userName': userName,
      'summary': summary,
      'practice': practice,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AuditEntryImpl extends AuditEntry {
  _AuditEntryImpl({
    required DateTime at,
    required String userName,
    required String summary,
    required bool practice,
  }) : super._(
         at: at,
         userName: userName,
         summary: summary,
         practice: practice,
       );

  /// Returns a shallow copy of this [AuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AuditEntry copyWith({
    DateTime? at,
    String? userName,
    String? summary,
    bool? practice,
  }) {
    return AuditEntry(
      at: at ?? this.at,
      userName: userName ?? this.userName,
      summary: summary ?? this.summary,
      practice: practice ?? this.practice,
    );
  }
}
