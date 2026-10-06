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
import '../../../features/onboarding/models/join_request_status.dart'
    as _iwnr7ntj;

abstract class JoinRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JoinRequest._({
    this.id,
    required this.hospitalName,
    required this.contactName,
    required this.phone,
    required this.area,
    this.message,
    required this.status,
    this.facilityId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory JoinRequest({
    int? id,
    required String hospitalName,
    required String contactName,
    required String phone,
    required String area,
    String? message,
    required _iwnr7ntj.JoinRequestStatus status,
    int? facilityId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _JoinRequestImpl;

  factory JoinRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return JoinRequest(
      id: jsonSerialization['id'] as int?,
      hospitalName: jsonSerialization['hospitalName'] as String,
      contactName: jsonSerialization['contactName'] as String,
      phone: jsonSerialization['phone'] as String,
      area: jsonSerialization['area'] as String,
      message: jsonSerialization['message'] as String?,
      status: _iwnr7ntj.JoinRequestStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      facilityId: jsonSerialization['facilityId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String hospitalName;

  String contactName;

  String phone;

  String area;

  String? message;

  _iwnr7ntj.JoinRequestStatus status;

  int? facilityId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [JoinRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JoinRequest copyWith({
    int? id,
    String? hospitalName,
    String? contactName,
    String? phone,
    String? area,
    String? message,
    _iwnr7ntj.JoinRequestStatus? status,
    int? facilityId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JoinRequest',
      if (id != null) 'id': id,
      'hospitalName': hospitalName,
      'contactName': contactName,
      'phone': phone,
      'area': area,
      if (message != null) 'message': message,
      'status': status.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JoinRequest',
      if (id != null) 'id': id,
      'hospitalName': hospitalName,
      'contactName': contactName,
      'phone': phone,
      'area': area,
      if (message != null) 'message': message,
      'status': status.toJson(),
      if (facilityId != null) 'facilityId': facilityId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JoinRequestImpl extends JoinRequest {
  _JoinRequestImpl({
    int? id,
    required String hospitalName,
    required String contactName,
    required String phone,
    required String area,
    String? message,
    required _iwnr7ntj.JoinRequestStatus status,
    int? facilityId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         hospitalName: hospitalName,
         contactName: contactName,
         phone: phone,
         area: area,
         message: message,
         status: status,
         facilityId: facilityId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [JoinRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JoinRequest copyWith({
    Object? id = _Undefined,
    String? hospitalName,
    String? contactName,
    String? phone,
    String? area,
    Object? message = _Undefined,
    _iwnr7ntj.JoinRequestStatus? status,
    Object? facilityId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JoinRequest(
      id: id is int? ? id : this.id,
      hospitalName: hospitalName ?? this.hospitalName,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      area: area ?? this.area,
      message: message is String? ? message : this.message,
      status: status ?? this.status,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
