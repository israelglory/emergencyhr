import 'package:serverpod/serverpod.dart';

import '../../core/auth_guard.dart';
import '../../generated/protocol.dart';
import 'data_rights_service.dart';
import 'profile_service.dart';

/// The signed-in user's contacts, medical profile and data rights.
/// Who may call: any signed-in user, for their own data only.
class ProfileEndpoint extends Endpoint {
  static const _profile = ProfileService();
  static const _rights = DataRightsService();

  Future<List<EmergencyContact>> contacts(Session session) async =>
      _profile.contacts(session, await AuthGuard.requireUser(session));

  Future<EmergencyContact> saveContact(
    Session session,
    EmergencyContact contact,
  ) async => _profile.saveContact(
    session,
    await AuthGuard.requireUser(session),
    contact,
  );

  Future<void> deleteContact(Session session, int contactId) async =>
      _profile.deleteContact(
        session,
        await AuthGuard.requireUser(session),
        contactId,
      );

  Future<MedicalProfileData> medical(Session session) async =>
      _profile.medical(session, await AuthGuard.requireUser(session));

  Future<MedicalProfileData> saveMedical(
    Session session,
    MedicalProfileData data,
    bool consent,
  ) async => _profile.saveMedical(
    session,
    await AuthGuard.requireUser(session),
    data,
    consent: consent,
  );

  Future<void> deleteMedical(Session session) async =>
      _profile.deleteMedical(session, await AuthGuard.requireUser(session));

  /// All personal data as JSON.
  Future<String> exportMyData(Session session) async =>
      _rights.export(session, await AuthGuard.requireUser(session));

  Future<void> deleteMyAccount(Session session) async =>
      _rights.delete(session, await AuthGuard.requireUser(session));
}
