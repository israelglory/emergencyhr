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

/// What a bulk Verify did.
abstract class BulkVerifySummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BulkVerifySummary._({
    required this.verified,
    required this.alreadyVerified,
    required this.skipped,
  });

  factory BulkVerifySummary({
    required int verified,
    required int alreadyVerified,
    required List<String> skipped,
  }) = _BulkVerifySummaryImpl;

  factory BulkVerifySummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return BulkVerifySummary(
      verified: jsonSerialization['verified'] as int,
      alreadyVerified: jsonSerialization['alreadyVerified'] as int,
      skipped: _ivwsyfsq.Protocol().deserialize<List<String>>(
        jsonSerialization['skipped'],
      ),
    );
  }

  int verified;

  /// Already verified before; nothing changed.
  int alreadyVerified;

  /// Skipped, with the reason, e.g. "Alpha Hospital: suspended".
  List<String> skipped;

  /// Returns a shallow copy of this [BulkVerifySummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BulkVerifySummary copyWith({
    int? verified,
    int? alreadyVerified,
    List<String>? skipped,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BulkVerifySummary',
      'verified': verified,
      'alreadyVerified': alreadyVerified,
      'skipped': skipped.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BulkVerifySummary',
      'verified': verified,
      'alreadyVerified': alreadyVerified,
      'skipped': skipped.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BulkVerifySummaryImpl extends BulkVerifySummary {
  _BulkVerifySummaryImpl({
    required int verified,
    required int alreadyVerified,
    required List<String> skipped,
  }) : super._(
         verified: verified,
         alreadyVerified: alreadyVerified,
         skipped: skipped,
       );

  /// Returns a shallow copy of this [BulkVerifySummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BulkVerifySummary copyWith({
    int? verified,
    int? alreadyVerified,
    List<String>? skipped,
  }) {
    return BulkVerifySummary(
      verified: verified ?? this.verified,
      alreadyVerified: alreadyVerified ?? this.alreadyVerified,
      skipped: skipped ?? this.skipped.map((e0) => e0).toList(),
    );
  }
}
