import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../core/clock.dart';
import '../../core/field_crypto.dart';
import '../../generated/protocol.dart';
import 'profile_service.dart';

/// NDPA 2023: users can export and delete their data.
class DataRightsService {
  const DataRightsService({this.profile = const ProfileService()});

  final ProfileService profile;

  Future<String> export(Session session, AppUser user) async {
    final roles = await RoleAssignment.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    final contacts = await profile.contacts(session, user);
    final medical = await profile.medical(session, user);
    final sessions = await EmergencySession.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
      orderBy: (t) => t.startedAt,
    );
    final conversations = await AiConversation.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    final crypto = FieldCrypto.fromSession(session);
    final chats = <Map<String, Object?>>[];
    for (final c in conversations) {
      final messages = await AiMessage.db.find(
        session,
        where: (t) => t.conversationId.equals(c.id!),
        orderBy: (t) => t.createdAt,
      );
      chats.add({
        'title': c.title,
        'createdAt': c.createdAt.toIso8601String(),
        'messages': [
          for (final m in messages)
            {
              'role': m.role.name,
              'content': await crypto.decryptOptional(m.contentEnc),
              'at': m.createdAt.toIso8601String(),
            },
        ],
      });
    }
    return const JsonEncoder.withIndent('  ').convert({
      'exportedAt': clock.now().toIso8601String(),
      'account': {
        'email': user.email,
        'phone': user.phone,
        'name': user.name,
        'createdAt': user.createdAt.toIso8601String(),
      },
      'roles': [for (final r in roles) r.role.name],
      'emergencyContacts': [
        for (final c in contacts)
          {'name': c.name, 'phone': c.phone, 'channel': c.channel.name},
      ],
      'medicalProfile': medical.toJson(),
      'emergencySessions': [
        for (final s in sessions)
          {
            'startedAt': s.startedAt.toIso8601String(),
            'type': s.emergencyType.name,
            'action': s.action.name,
          },
      ],
      'healthAssistant': chats,
    });
  }

  /// Deletes the account and everything tied to it. Emergency sessions are
  /// kept for metrics but no longer point at the user.
  Future<void> delete(Session session, AppUser user) async {
    await session.db.transaction((tx) async {
      await AppUser.db.deleteRow(session, user, transaction: tx);
    });
    await AuthServices.instance.authUsers.delete(
      session,
      authUserId: user.authUserId,
    );
  }
}
