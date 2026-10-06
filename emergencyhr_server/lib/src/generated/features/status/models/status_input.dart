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

/// A full status update from the desk.
abstract class StatusInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StatusInput._({
    required this.accepting,
    required this.erBedsFree,
    required this.icuBedsFree,
    required this.doctorOnDuty,
    required this.depositRequired,
  });

  factory StatusInput({
    required bool accepting,
    required int erBedsFree,
    required int icuBedsFree,
    required bool doctorOnDuty,
    required bool depositRequired,
  }) = _StatusInputImpl;

  factory StatusInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatusInput(
      accepting: _is.BoolJsonExtension.fromJson(jsonSerialization['accepting']),
      erBedsFree: jsonSerialization['erBedsFree'] as int,
      icuBedsFree: jsonSerialization['icuBedsFree'] as int,
      doctorOnDuty: _is.BoolJsonExtension.fromJson(
        jsonSerialization['doctorOnDuty'],
      ),
      depositRequired: _is.BoolJsonExtension.fromJson(
        jsonSerialization['depositRequired'],
      ),
    );
  }

  bool accepting;

  int erBedsFree;

  int icuBedsFree;

  bool doctorOnDuty;

  bool depositRequired;

  /// Returns a shallow copy of this [StatusInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StatusInput copyWith({
    bool? accepting,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StatusInput',
      'accepting': accepting,
      'erBedsFree': erBedsFree,
      'icuBedsFree': icuBedsFree,
      'doctorOnDuty': doctorOnDuty,
      'depositRequired': depositRequired,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StatusInput',
      'accepting': accepting,
      'erBedsFree': erBedsFree,
      'icuBedsFree': icuBedsFree,
      'doctorOnDuty': doctorOnDuty,
      'depositRequired': depositRequired,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _StatusInputImpl extends StatusInput {
  _StatusInputImpl({
    required bool accepting,
    required int erBedsFree,
    required int icuBedsFree,
    required bool doctorOnDuty,
    required bool depositRequired,
  }) : super._(
         accepting: accepting,
         erBedsFree: erBedsFree,
         icuBedsFree: icuBedsFree,
         doctorOnDuty: doctorOnDuty,
         depositRequired: depositRequired,
       );

  /// Returns a shallow copy of this [StatusInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StatusInput copyWith({
    bool? accepting,
    int? erBedsFree,
    int? icuBedsFree,
    bool? doctorOnDuty,
    bool? depositRequired,
  }) {
    return StatusInput(
      accepting: accepting ?? this.accepting,
      erBedsFree: erBedsFree ?? this.erBedsFree,
      icuBedsFree: icuBedsFree ?? this.icuBedsFree,
      doctorOnDuty: doctorOnDuty ?? this.doctorOnDuty,
      depositRequired: depositRequired ?? this.depositRequired,
    );
  }
}
