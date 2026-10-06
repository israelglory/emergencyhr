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
import '../../../features/doctors/models/payout_status.dart' as _i7nd3nn3;

/// V2 only.
abstract class Payout
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Payout._({
    this.id,
    required this.doctorId,
    required this.amountNgn,
    required this.commissionNgn,
    required this.status,
    this.providerRef,
  });

  factory Payout({
    int? id,
    required int doctorId,
    required int amountNgn,
    required int commissionNgn,
    required _i7nd3nn3.PayoutStatus status,
    String? providerRef,
  }) = _PayoutImpl;

  factory Payout.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payout(
      id: jsonSerialization['id'] as int?,
      doctorId: jsonSerialization['doctorId'] as int,
      amountNgn: jsonSerialization['amountNgn'] as int,
      commissionNgn: jsonSerialization['commissionNgn'] as int,
      status: _i7nd3nn3.PayoutStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      providerRef: jsonSerialization['providerRef'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int doctorId;

  int amountNgn;

  int commissionNgn;

  _i7nd3nn3.PayoutStatus status;

  String? providerRef;

  /// Returns a shallow copy of this [Payout]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Payout copyWith({
    int? id,
    int? doctorId,
    int? amountNgn,
    int? commissionNgn,
    _i7nd3nn3.PayoutStatus? status,
    String? providerRef,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payout',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'amountNgn': amountNgn,
      'commissionNgn': commissionNgn,
      'status': status.toJson(),
      if (providerRef != null) 'providerRef': providerRef,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payout',
      if (id != null) 'id': id,
      'doctorId': doctorId,
      'amountNgn': amountNgn,
      'commissionNgn': commissionNgn,
      'status': status.toJson(),
      if (providerRef != null) 'providerRef': providerRef,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PayoutImpl extends Payout {
  _PayoutImpl({
    int? id,
    required int doctorId,
    required int amountNgn,
    required int commissionNgn,
    required _i7nd3nn3.PayoutStatus status,
    String? providerRef,
  }) : super._(
         id: id,
         doctorId: doctorId,
         amountNgn: amountNgn,
         commissionNgn: commissionNgn,
         status: status,
         providerRef: providerRef,
       );

  /// Returns a shallow copy of this [Payout]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Payout copyWith({
    Object? id = _Undefined,
    int? doctorId,
    int? amountNgn,
    int? commissionNgn,
    _i7nd3nn3.PayoutStatus? status,
    Object? providerRef = _Undefined,
  }) {
    return Payout(
      id: id is int? ? id : this.id,
      doctorId: doctorId ?? this.doctorId,
      amountNgn: amountNgn ?? this.amountNgn,
      commissionNgn: commissionNgn ?? this.commissionNgn,
      status: status ?? this.status,
      providerRef: providerRef is String? ? providerRef : this.providerRef,
    );
  }
}
