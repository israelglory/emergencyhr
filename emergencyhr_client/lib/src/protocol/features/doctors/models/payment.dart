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
import '../../../features/doctors/models/payment_status.dart' as _ii0rgtl9;

/// V2 only.
abstract class Payment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Payment._({
    this.id,
    required this.consultationId,
    required this.amountNgn,
    required this.providerRef,
    required this.status,
  });

  factory Payment({
    int? id,
    required int consultationId,
    required int amountNgn,
    required String providerRef,
    required _ii0rgtl9.PaymentStatus status,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      consultationId: jsonSerialization['consultationId'] as int,
      amountNgn: jsonSerialization['amountNgn'] as int,
      providerRef: jsonSerialization['providerRef'] as String,
      status: _ii0rgtl9.PaymentStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int consultationId;

  int amountNgn;

  String providerRef;

  _ii0rgtl9.PaymentStatus status;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Payment copyWith({
    int? id,
    int? consultationId,
    int? amountNgn,
    String? providerRef,
    _ii0rgtl9.PaymentStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'consultationId': consultationId,
      'amountNgn': amountNgn,
      'providerRef': providerRef,
      'status': status.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'consultationId': consultationId,
      'amountNgn': amountNgn,
      'providerRef': providerRef,
      'status': status.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int consultationId,
    required int amountNgn,
    required String providerRef,
    required _ii0rgtl9.PaymentStatus status,
  }) : super._(
         id: id,
         consultationId: consultationId,
         amountNgn: amountNgn,
         providerRef: providerRef,
         status: status,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? consultationId,
    int? amountNgn,
    String? providerRef,
    _ii0rgtl9.PaymentStatus? status,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      consultationId: consultationId ?? this.consultationId,
      amountNgn: amountNgn ?? this.amountNgn,
      providerRef: providerRef ?? this.providerRef,
      status: status ?? this.status,
    );
  }
}
