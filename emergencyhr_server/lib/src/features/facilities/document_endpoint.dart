import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../core/errors.dart';
import '../../generated/protocol.dart';
import 'document_service.dart';

class DocumentEndpoint extends Endpoint {
  static const _documents = DocumentService();

  /// Facility documents: the facility's managers. Claim documents (no
  /// facility yet): any signed-in user, stored under their own folder.
  Future<UploadTicket> createUpload(
    Session session,
    String fileName, {
    int? facilityId,
  }) async {
    final user = facilityId == null
        ? await AuthGuard.requireUser(session)
        : await AuthGuard.requireRole(
            session,
            AuthGuard.managers,
            facilityId: facilityId,
          );
    return _documents.createUpload(
      session,
      facilityId: facilityId,
      user: user,
      fileName: fileName,
    );
  }

  /// Same callers as [createUpload].
  Future<FacilityDocument> confirmUpload(
    Session session,
    String path,
    DocumentKind kind, {
    int? facilityId,
  }) async {
    final user = facilityId == null
        ? await AuthGuard.requireUser(session)
        : await AuthGuard.requireRole(
            session,
            AuthGuard.managers,
            facilityId: facilityId,
          );
    return _documents.confirmUpload(
      session,
      path: path,
      kind: kind,
      facilityId: facilityId,
      user: user,
    );
  }

  /// Who may call: platform admins, or the facility's managers.
  Future<ByteData> download(Session session, int documentId) async {
    final user = await AuthGuard.requireUser(session);
    final document = await FacilityDocument.db.findById(session, documentId);
    if (document == null) throw Errors.notFound('Document');
    final isAdmin = await AuthGuard.hasRole(session, user, {
      UserRole.platformAdmin,
    });
    final isManager =
        document.facilityId != null &&
        await AuthGuard.hasRole(
          session,
          user,
          AuthGuard.managers,
          facilityId: document.facilityId,
        );
    if (!isAdmin && !isManager) throw Errors.notAuthorized();
    return _documents.download(session, document);
  }
}
