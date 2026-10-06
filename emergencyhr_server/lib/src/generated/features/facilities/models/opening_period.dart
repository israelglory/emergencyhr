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

/// One opening window. weekday is 1 (Monday) to 7 (Sunday), minutes are
/// minutes after midnight in Africa/Lagos time.
abstract class OpeningPeriod
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OpeningPeriod._({
    required this.weekday,
    required this.openMinute,
    required this.closeMinute,
  });

  factory OpeningPeriod({
    required int weekday,
    required int openMinute,
    required int closeMinute,
  }) = _OpeningPeriodImpl;

  factory OpeningPeriod.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpeningPeriod(
      weekday: jsonSerialization['weekday'] as int,
      openMinute: jsonSerialization['openMinute'] as int,
      closeMinute: jsonSerialization['closeMinute'] as int,
    );
  }

  int weekday;

  int openMinute;

  int closeMinute;

  /// Returns a shallow copy of this [OpeningPeriod]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OpeningPeriod copyWith({
    int? weekday,
    int? openMinute,
    int? closeMinute,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpeningPeriod',
      'weekday': weekday,
      'openMinute': openMinute,
      'closeMinute': closeMinute,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpeningPeriod',
      'weekday': weekday,
      'openMinute': openMinute,
      'closeMinute': closeMinute,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OpeningPeriodImpl extends OpeningPeriod {
  _OpeningPeriodImpl({
    required int weekday,
    required int openMinute,
    required int closeMinute,
  }) : super._(
         weekday: weekday,
         openMinute: openMinute,
         closeMinute: closeMinute,
       );

  /// Returns a shallow copy of this [OpeningPeriod]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OpeningPeriod copyWith({
    int? weekday,
    int? openMinute,
    int? closeMinute,
  }) {
    return OpeningPeriod(
      weekday: weekday ?? this.weekday,
      openMinute: openMinute ?? this.openMinute,
      closeMinute: closeMinute ?? this.closeMinute,
    );
  }
}
