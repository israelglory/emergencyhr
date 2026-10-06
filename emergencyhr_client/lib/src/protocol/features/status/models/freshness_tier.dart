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

/// Fresh: confirmed within 30 min. Stale: 31 to 120 min. Unverified: older,
/// never confirmed, not live, or flagged. Paused: not accepting.
enum FreshnessTier implements _isc.SerializableModel {
  fresh,
  stale,
  unverified,
  paused;

  static FreshnessTier fromJson(String name) {
    switch (name) {
      case 'fresh':
        return FreshnessTier.fresh;
      case 'stale':
        return FreshnessTier.stale;
      case 'unverified':
        return FreshnessTier.unverified;
      case 'paused':
        return FreshnessTier.paused;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "FreshnessTier"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
