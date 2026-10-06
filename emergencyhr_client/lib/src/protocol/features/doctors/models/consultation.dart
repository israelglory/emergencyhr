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
import '../../../features/doctors/models/consultation_status.dart' as _iuk5krsu;

/// V2 only.
abstract class Consultation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Consultation._({
    this.id,
    required this.userId,
    required this.doctorId,
    required this.status,
    required this.feeNgn,
    this.startedAt,
    this.endedAt,
    this.note,
  });

  factory Consultation({
    int? id,
    required int userId,
    required int doctorId,
    required _iuk5krsu.ConsultationStatus status,
    required int feeNgn,
    DateTime? startedAt,
    DateTime? endedAt,
    String? note,
  }) = _ConsultationImpl;

  factory Consultation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Consultation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      doctorId: jsonSerialization['doctorId'] as int,
      status: _iuk5krsu.ConsultationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      feeNgn: jsonSerialization['feeNgn'] as int,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      note: jsonSerialization['note'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int doctorId;

  _iuk5krsu.ConsultationStatus status;

  int feeNgn;

  DateTime? startedAt;

  DateTime? endedAt;

  String? note;

  /// Returns a shallow copy of this [Consultation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Consultation copyWith({
    int? id,
    int? userId,
    int? doctorId,
    _iuk5krsu.ConsultationStatus? status,
    int? feeNgn,
    DateTime? startedAt,
    DateTime? endedAt,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Consultation',
      if (id != null) 'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'status': status.toJson(),
      'feeNgn': feeNgn,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Consultation',
      if (id != null) 'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'status': status.toJson(),
      'feeNgn': feeNgn,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConsultationImpl extends Consultation {
  _ConsultationImpl({
    int? id,
    required int userId,
    required int doctorId,
    required _iuk5krsu.ConsultationStatus status,
    required int feeNgn,
    DateTime? startedAt,
    DateTime? endedAt,
    String? note,
  }) : super._(
         id: id,
         userId: userId,
         doctorId: doctorId,
         status: status,
         feeNgn: feeNgn,
         startedAt: startedAt,
         endedAt: endedAt,
         note: note,
       );

  /// Returns a shallow copy of this [Consultation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Consultation copyWith({
    Object? id = _Undefined,
    int? userId,
    int? doctorId,
    _iuk5krsu.ConsultationStatus? status,
    int? feeNgn,
    Object? startedAt = _Undefined,
    Object? endedAt = _Undefined,
    Object? note = _Undefined,
  }) {
    return Consultation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      doctorId: doctorId ?? this.doctorId,
      status: status ?? this.status,
      feeNgn: feeNgn ?? this.feeNgn,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      note: note is String? ? note : this.note,
    );
  }
}
