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
import '../../../features/onboarding/models/claim_status.dart' as _iya0t7il;

abstract class ClaimRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClaimRequest._({
    this.id,
    required this.facilityId,
    required this.userId,
    required this.contactName,
    required this.documents,
    bool? deskPhoneVerified,
    required this.status,
    this.reviewedByUserId,
    this.reason,
    DateTime? createdAt,
    this.reviewedAt,
  }) : deskPhoneVerified = deskPhoneVerified ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory ClaimRequest({
    int? id,
    required int facilityId,
    required int userId,
    required String contactName,
    required List<String> documents,
    bool? deskPhoneVerified,
    required _iya0t7il.ClaimStatus status,
    int? reviewedByUserId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
  }) = _ClaimRequestImpl;

  factory ClaimRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimRequest(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int,
      userId: jsonSerialization['userId'] as int,
      contactName: jsonSerialization['contactName'] as String,
      documents: _ivwsyfsq.Protocol().deserialize<List<String>>(
        jsonSerialization['documents'],
      ),
      deskPhoneVerified: jsonSerialization['deskPhoneVerified'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['deskPhoneVerified'],
            ),
      status: _iya0t7il.ClaimStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as int?,
      reason: jsonSerialization['reason'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['reviewedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int facilityId;

  int userId;

  String contactName;

  /// Storage paths of uploaded documents.
  List<String> documents;

  bool deskPhoneVerified;

  _iya0t7il.ClaimStatus status;

  int? reviewedByUserId;

  String? reason;

  DateTime createdAt;

  DateTime? reviewedAt;

  /// Returns a shallow copy of this [ClaimRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClaimRequest copyWith({
    int? id,
    int? facilityId,
    int? userId,
    String? contactName,
    List<String>? documents,
    bool? deskPhoneVerified,
    _iya0t7il.ClaimStatus? status,
    int? reviewedByUserId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClaimRequest',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'userId': userId,
      'contactName': contactName,
      'documents': documents.toJson(),
      'deskPhoneVerified': deskPhoneVerified,
      'status': status.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClaimRequest',
      if (id != null) 'id': id,
      'facilityId': facilityId,
      'userId': userId,
      'contactName': contactName,
      'documents': documents.toJson(),
      'deskPhoneVerified': deskPhoneVerified,
      'status': status.toJson(),
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reason != null) 'reason': reason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClaimRequestImpl extends ClaimRequest {
  _ClaimRequestImpl({
    int? id,
    required int facilityId,
    required int userId,
    required String contactName,
    required List<String> documents,
    bool? deskPhoneVerified,
    required _iya0t7il.ClaimStatus status,
    int? reviewedByUserId,
    String? reason,
    DateTime? createdAt,
    DateTime? reviewedAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         userId: userId,
         contactName: contactName,
         documents: documents,
         deskPhoneVerified: deskPhoneVerified,
         status: status,
         reviewedByUserId: reviewedByUserId,
         reason: reason,
         createdAt: createdAt,
         reviewedAt: reviewedAt,
       );

  /// Returns a shallow copy of this [ClaimRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClaimRequest copyWith({
    Object? id = _Undefined,
    int? facilityId,
    int? userId,
    String? contactName,
    List<String>? documents,
    bool? deskPhoneVerified,
    _iya0t7il.ClaimStatus? status,
    Object? reviewedByUserId = _Undefined,
    Object? reason = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return ClaimRequest(
      id: id is int? ? id : this.id,
      facilityId: facilityId ?? this.facilityId,
      userId: userId ?? this.userId,
      contactName: contactName ?? this.contactName,
      documents: documents ?? this.documents.map((e0) => e0).toList(),
      deskPhoneVerified: deskPhoneVerified ?? this.deskPhoneVerified,
      status: status ?? this.status,
      reviewedByUserId: reviewedByUserId is int?
          ? reviewedByUserId
          : this.reviewedByUserId,
      reason: reason is String? ? reason : this.reason,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}
