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

/// What an import did, or would do on a dry run.
abstract class FacilityImportSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilityImportSummary._({
    required this.dryRun,
    required this.created,
    required this.alreadyImported,
    required this.possibleDuplicates,
    required this.invalid,
  });

  factory FacilityImportSummary({
    required bool dryRun,
    required int created,
    required int alreadyImported,
    required List<String> possibleDuplicates,
    required List<String> invalid,
  }) = _FacilityImportSummaryImpl;

  factory FacilityImportSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FacilityImportSummary(
      dryRun: _isc.BoolJsonExtension.fromJson(jsonSerialization['dryRun']),
      created: jsonSerialization['created'] as int,
      alreadyImported: jsonSerialization['alreadyImported'] as int,
      possibleDuplicates: _ivwsyfsq.Protocol().deserialize<List<String>>(
        jsonSerialization['possibleDuplicates'],
      ),
      invalid: _ivwsyfsq.Protocol().deserialize<List<String>>(
        jsonSerialization['invalid'],
      ),
    );
  }

  bool dryRun;

  /// Added (or, on a dry run, would be added).
  int created;

  /// Already imported earlier from the same source id.
  int alreadyImported;

  /// Skipped because a listing with a similar name is already close by.
  List<String> possibleDuplicates;

  /// Rows that could not be used, with the reason.
  List<String> invalid;

  /// Returns a shallow copy of this [FacilityImportSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilityImportSummary copyWith({
    bool? dryRun,
    int? created,
    int? alreadyImported,
    List<String>? possibleDuplicates,
    List<String>? invalid,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityImportSummary',
      'dryRun': dryRun,
      'created': created,
      'alreadyImported': alreadyImported,
      'possibleDuplicates': possibleDuplicates.toJson(),
      'invalid': invalid.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityImportSummary',
      'dryRun': dryRun,
      'created': created,
      'alreadyImported': alreadyImported,
      'possibleDuplicates': possibleDuplicates.toJson(),
      'invalid': invalid.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _FacilityImportSummaryImpl extends FacilityImportSummary {
  _FacilityImportSummaryImpl({
    required bool dryRun,
    required int created,
    required int alreadyImported,
    required List<String> possibleDuplicates,
    required List<String> invalid,
  }) : super._(
         dryRun: dryRun,
         created: created,
         alreadyImported: alreadyImported,
         possibleDuplicates: possibleDuplicates,
         invalid: invalid,
       );

  /// Returns a shallow copy of this [FacilityImportSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilityImportSummary copyWith({
    bool? dryRun,
    int? created,
    int? alreadyImported,
    List<String>? possibleDuplicates,
    List<String>? invalid,
  }) {
    return FacilityImportSummary(
      dryRun: dryRun ?? this.dryRun,
      created: created ?? this.created,
      alreadyImported: alreadyImported ?? this.alreadyImported,
      possibleDuplicates:
          possibleDuplicates ??
          this.possibleDuplicates.map((e0) => e0).toList(),
      invalid: invalid ?? this.invalid.map((e0) => e0).toList(),
    );
  }
}
