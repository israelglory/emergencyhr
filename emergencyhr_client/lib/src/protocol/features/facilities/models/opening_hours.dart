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
import '../../../features/facilities/models/opening_period.dart' as _iu2xndlk;

abstract class OpeningHours
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OpeningHours._({
    required this.alwaysOpen,
    required this.periods,
  });

  factory OpeningHours({
    required bool alwaysOpen,
    required List<_iu2xndlk.OpeningPeriod> periods,
  }) = _OpeningHoursImpl;

  factory OpeningHours.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpeningHours(
      alwaysOpen: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['alwaysOpen'],
      ),
      periods: _ivwsyfsq.Protocol().deserialize<List<_iu2xndlk.OpeningPeriod>>(
        jsonSerialization['periods'],
      ),
    );
  }

  bool alwaysOpen;

  List<_iu2xndlk.OpeningPeriod> periods;

  /// Returns a shallow copy of this [OpeningHours]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OpeningHours copyWith({
    bool? alwaysOpen,
    List<_iu2xndlk.OpeningPeriod>? periods,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpeningHours',
      'alwaysOpen': alwaysOpen,
      'periods': periods.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpeningHours',
      'alwaysOpen': alwaysOpen,
      'periods': periods.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _OpeningHoursImpl extends OpeningHours {
  _OpeningHoursImpl({
    required bool alwaysOpen,
    required List<_iu2xndlk.OpeningPeriod> periods,
  }) : super._(
         alwaysOpen: alwaysOpen,
         periods: periods,
       );

  /// Returns a shallow copy of this [OpeningHours]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OpeningHours copyWith({
    bool? alwaysOpen,
    List<_iu2xndlk.OpeningPeriod>? periods,
  }) {
    return OpeningHours(
      alwaysOpen: alwaysOpen ?? this.alwaysOpen,
      periods: periods ?? this.periods.map((e0) => e0.copyWith()).toList(),
    );
  }
}
