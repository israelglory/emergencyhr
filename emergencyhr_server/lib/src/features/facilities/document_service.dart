import 'dart:math';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';

/// Registration and contact documents in Serverpod private storage.
class DocumentService {
  const DocumentService();

  static const storageId = 'private';
  static const maxBytes = 10 * 1024 * 1024;
  static const allowedExtensions = {
    'pdf',
    'jpg',
    'jpeg',
    'png',
    'webp',
    'heic',
  };
  static final _random = Random.secure();

  static String safeFileName(String name) {
    final cleaned = name
        .trim()
        .replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_')
        .replaceAll(RegExp(r'_+'), '_');
    final ext = cleaned.contains('.')
        ? cleaned.split('.').last.toLowerCase()
        : '';
    if (!allowedExtensions.contains(ext)) {
      throw Errors.validation(
        'Upload a PDF or a photo (JPG, PNG, WEBP, HEIC).',
        field: 'fileName',
      );
    }
    return cleaned.length > 80
        ? cleaned.substring(cleaned.length - 80)
        : cleaned;
  }

  /// Paths are derived on the server: facility documents live under the
  /// facility, claim documents under the uploading user.
  static String pathFor({
    int? facilityId,
    required int userId,
    required String fileName,
  }) {
    final id = List.generate(
      12,
      (_) => _random.nextInt(36).toRadixString(36),
    ).join();
    final safe = safeFileName(fileName);
    return facilityId != null
        ? 'facilities/$facilityId/$id-$safe'
        : 'claims/u$userId/$id-$safe';
  }

  Future<UploadTicket> createUpload(
    Session session, {
    int? facilityId,
    required AppUser user,
    required String fileName,
  }) async {
    final path = pathFor(
      facilityId: facilityId,
      userId: user.id!,
      fileName: fileName,
    );
    final description = await session.storage.createUploadDescription(
      storageId: storageId,
      path: path,
      options: const UploadOptions(
        maxFileSize: maxBytes,
        preventOverwrite: true,
      ),
    );
    return UploadTicket(uploadDescription: description, path: path);
  }

  Future<FacilityDocument> confirmUpload(
    Session session, {
    required String path,
    required DocumentKind kind,
    int? facilityId,
    required AppUser user,
  }) async {
    final expectedPrefix = facilityId != null
        ? 'facilities/$facilityId/'
        : 'claims/u${user.id}/';
    if (!path.startsWith(expectedPrefix) || path.contains('..')) {
      throw Errors.notAuthorized();
    }
    final ok = await session.storage.verifyUpload(
      storageId: storageId,
      path: path,
    );
    if (!ok) throw Errors.invalidState('The upload did not complete.');
    return FacilityDocument.db.insertRow(
      session,
      FacilityDocument(
        facilityId: facilityId,
        kind: kind,
        storagePath: path,
        fileName: path.split('/').last.replaceFirst(RegExp(r'^[a-z0-9]+-'), ''),
        uploadedByUserId: user.id,
        createdAt: clock.now(),
      ),
    );
  }

  Future<ByteData> download(Session session, FacilityDocument document) async {
    return session.storage.retrieveFile(
      storageId: storageId,
      path: document.storagePath,
    );
  }
}
