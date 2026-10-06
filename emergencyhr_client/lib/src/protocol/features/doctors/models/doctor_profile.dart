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
import '../../../features/facilities/models/verification_status.dart'
    as _ipq8k6fl;

/// V2 only. Schema exists so the doctor launch needs no migration.
abstract class DoctorProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DoctorProfile._({
    this.id,
    required this.userId,
    required this.mdcnNumber,
    required this.licenceExpiry,
    required this.specialty,
    required this.feeNgn,
    required this.sessionMinutes,
    this.facilityId,
    required this.verificationStatus,
  });

  factory DoctorProfile({
    int? id,
    required int userId,
    required String mdcnNumber,
    required DateTime licenceExpiry,
    required String specialty,
    required int feeNgn,
    required int sessionMinutes,
    int? facilityId,
    required _ipq8k6fl.VerificationStatus verificationStatus,
  }) = _DoctorProfileImpl;

  factory DoctorProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoctorProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      mdcnNumber: jsonSerialization['mdcnNumber'] as String,
      licenceExpiry: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['licenceExpiry'],
      ),
      specialty: jsonSerialization['specialty'] as String,
      feeNgn: jsonSerialization['feeNgn'] as int,
      sessionMinutes: jsonSerialization['sessionMinutes'] as int,
      facilityId: jsonSerialization['facilityId'] as int?,
      verificationStatus: _ipq8k6fl.VerificationStatus.fromJson(
        (jsonSerialization['verificationStatus'] as String),
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String mdcnNumber;

  DateTime licenceExpiry;

  String specialty;

  int feeNgn;

  int sessionMinutes;

  int? facilityId;

  _ipq8k6fl.VerificationStatus verificationStatus;

  /// Returns a shallow copy of this [DoctorProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DoctorProfile copyWith({
    int? id,
    int? userId,
    String? mdcnNumber,
    DateTime? licenceExpiry,
    String? specialty,
    int? feeNgn,
    int? sessionMinutes,
    int? facilityId,
    _ipq8k6fl.VerificationStatus? verificationStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoctorProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'mdcnNumber': mdcnNumber,
      'licenceExpiry': licenceExpiry.toJson(),
      'specialty': specialty,
      'feeNgn': feeNgn,
      'sessionMinutes': sessionMinutes,
      if (facilityId != null) 'facilityId': facilityId,
      'verificationStatus': verificationStatus.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoctorProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'mdcnNumber': mdcnNumber,
      'licenceExpiry': licenceExpiry.toJson(),
      'specialty': specialty,
      'feeNgn': feeNgn,
      'sessionMinutes': sessionMinutes,
      if (facilityId != null) 'facilityId': facilityId,
      'verificationStatus': verificationStatus.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoctorProfileImpl extends DoctorProfile {
  _DoctorProfileImpl({
    int? id,
    required int userId,
    required String mdcnNumber,
    required DateTime licenceExpiry,
    required String specialty,
    required int feeNgn,
    required int sessionMinutes,
    int? facilityId,
    required _ipq8k6fl.VerificationStatus verificationStatus,
  }) : super._(
         id: id,
         userId: userId,
         mdcnNumber: mdcnNumber,
         licenceExpiry: licenceExpiry,
         specialty: specialty,
         feeNgn: feeNgn,
         sessionMinutes: sessionMinutes,
         facilityId: facilityId,
         verificationStatus: verificationStatus,
       );

  /// Returns a shallow copy of this [DoctorProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DoctorProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    String? mdcnNumber,
    DateTime? licenceExpiry,
    String? specialty,
    int? feeNgn,
    int? sessionMinutes,
    Object? facilityId = _Undefined,
    _ipq8k6fl.VerificationStatus? verificationStatus,
  }) {
    return DoctorProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      mdcnNumber: mdcnNumber ?? this.mdcnNumber,
      licenceExpiry: licenceExpiry ?? this.licenceExpiry,
      specialty: specialty ?? this.specialty,
      feeNgn: feeNgn ?? this.feeNgn,
      sessionMinutes: sessionMinutes ?? this.sessionMinutes,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }
}
