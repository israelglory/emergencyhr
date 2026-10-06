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
import '../../../features/facilities/models/document_kind.dart' as _i2c0pm7z;

/// A file stored in Serverpod private storage.
abstract class FacilityDocument
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FacilityDocument._({
    this.id,
    this.facilityId,
    this.claimRequestId,
    required this.kind,
    required this.storagePath,
    required this.fileName,
    this.uploadedByUserId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory FacilityDocument({
    int? id,
    int? facilityId,
    int? claimRequestId,
    required _i2c0pm7z.DocumentKind kind,
    required String storagePath,
    required String fileName,
    int? uploadedByUserId,
    DateTime? createdAt,
  }) = _FacilityDocumentImpl;

  factory FacilityDocument.fromJson(Map<String, dynamic> jsonSerialization) {
    return FacilityDocument(
      id: jsonSerialization['id'] as int?,
      facilityId: jsonSerialization['facilityId'] as int?,
      claimRequestId: jsonSerialization['claimRequestId'] as int?,
      kind: _i2c0pm7z.DocumentKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      storagePath: jsonSerialization['storagePath'] as String,
      fileName: jsonSerialization['fileName'] as String,
      uploadedByUserId: jsonSerialization['uploadedByUserId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? facilityId;

  int? claimRequestId;

  _i2c0pm7z.DocumentKind kind;

  String storagePath;

  String fileName;

  int? uploadedByUserId;

  DateTime createdAt;

  /// Returns a shallow copy of this [FacilityDocument]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FacilityDocument copyWith({
    int? id,
    int? facilityId,
    int? claimRequestId,
    _i2c0pm7z.DocumentKind? kind,
    String? storagePath,
    String? fileName,
    int? uploadedByUserId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FacilityDocument',
      if (id != null) 'id': id,
      if (facilityId != null) 'facilityId': facilityId,
      if (claimRequestId != null) 'claimRequestId': claimRequestId,
      'kind': kind.toJson(),
      'storagePath': storagePath,
      'fileName': fileName,
      if (uploadedByUserId != null) 'uploadedByUserId': uploadedByUserId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FacilityDocument',
      if (id != null) 'id': id,
      if (facilityId != null) 'facilityId': facilityId,
      if (claimRequestId != null) 'claimRequestId': claimRequestId,
      'kind': kind.toJson(),
      'storagePath': storagePath,
      'fileName': fileName,
      if (uploadedByUserId != null) 'uploadedByUserId': uploadedByUserId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FacilityDocumentImpl extends FacilityDocument {
  _FacilityDocumentImpl({
    int? id,
    int? facilityId,
    int? claimRequestId,
    required _i2c0pm7z.DocumentKind kind,
    required String storagePath,
    required String fileName,
    int? uploadedByUserId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         facilityId: facilityId,
         claimRequestId: claimRequestId,
         kind: kind,
         storagePath: storagePath,
         fileName: fileName,
         uploadedByUserId: uploadedByUserId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FacilityDocument]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FacilityDocument copyWith({
    Object? id = _Undefined,
    Object? facilityId = _Undefined,
    Object? claimRequestId = _Undefined,
    _i2c0pm7z.DocumentKind? kind,
    String? storagePath,
    String? fileName,
    Object? uploadedByUserId = _Undefined,
    DateTime? createdAt,
  }) {
    return FacilityDocument(
      id: id is int? ? id : this.id,
      facilityId: facilityId is int? ? facilityId : this.facilityId,
      claimRequestId: claimRequestId is int?
          ? claimRequestId
          : this.claimRequestId,
      kind: kind ?? this.kind,
      storagePath: storagePath ?? this.storagePath,
      fileName: fileName ?? this.fileName,
      uploadedByUserId: uploadedByUserId is int?
          ? uploadedByUserId
          : this.uploadedByUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
