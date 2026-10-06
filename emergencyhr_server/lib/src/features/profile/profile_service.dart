import 'package:serverpod/serverpod.dart';

import '../../core/clock.dart';
import '../../core/errors.dart';
import '../../core/field_crypto.dart';
import '../../core/validation.dart';
import '../../generated/protocol.dart';

/// Emergency contacts and the encrypted medical profile.
class ProfileService {
  const ProfileService();

  static const maxContacts = 3;

  Future<List<EmergencyContact>> contacts(Session session, AppUser user) {
    return EmergencyContact.db.find(
      session,
      where: (t) => t.userId.equals(user.id!),
      orderBy: (t) => t.id,
    );
  }

  Future<EmergencyContact> saveContact(
    Session session,
    AppUser user,
    EmergencyContact input,
  ) async {
    final data = input.copyWith(
      userId: user.id,
      name: Validate.text(input.name, field: 'name', max: 80),
      phone: Validate.phone(input.phone),
    );
    if (input.id == null) {
      final count = await EmergencyContact.db.count(
        session,
        where: (t) => t.userId.equals(user.id!),
      );
      if (count >= maxContacts) {
        throw Errors.validation('You can add up to $maxContacts contacts.');
      }
      return EmergencyContact.db.insertRow(
        session,
        data.copyWith(createdAt: clock.now()),
      );
    }
    final existing = await EmergencyContact.db.findById(session, input.id!);
    if (existing == null || existing.userId != user.id) {
      throw Errors.notFound('Contact');
    }
    return EmergencyContact.db.updateRow(session, data);
  }

  Future<void> deleteContact(Session session, AppUser user, int id) async {
    await EmergencyContact.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id) & t.userId.equals(user.id!),
    );
  }

  Future<MedicalProfileData> medical(Session session, AppUser user) async {
    final row = await MedicalProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    if (row == null) return MedicalProfileData();
    final crypto = FieldCrypto.fromSession(session);
    return MedicalProfileData(
      bloodGroup: await crypto.decryptOptional(row.bloodGroupEnc),
      allergies: await crypto.decryptOptional(row.allergiesEnc),
      conditions: await crypto.decryptOptional(row.conditionsEnc),
      medications: await crypto.decryptOptional(row.medicationsEnc),
      consentAt: row.consentAt,
    );
  }

  /// Saved only with explicit consent, which is recorded with a timestamp.
  Future<MedicalProfileData> saveMedical(
    Session session,
    AppUser user,
    MedicalProfileData input, {
    required bool consent,
  }) async {
    if (!consent) {
      throw Errors.validation(
        'Confirm that you agree before saving health details.',
        field: 'consent',
      );
    }
    String? field(String? value, String name) =>
        Validate.optionalText(value, field: name, max: 500);
    final crypto = FieldCrypto.fromSession(session);
    final existing = await MedicalProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
    final now = clock.now();
    final row = MedicalProfile(
      id: existing?.id,
      userId: user.id!,
      bloodGroupEnc: await crypto.encryptOptional(
        field(input.bloodGroup, 'bloodGroup'),
      ),
      allergiesEnc: await crypto.encryptOptional(
        field(input.allergies, 'allergies'),
      ),
      conditionsEnc: await crypto.encryptOptional(
        field(input.conditions, 'conditions'),
      ),
      medicationsEnc: await crypto.encryptOptional(
        field(input.medications, 'medications'),
      ),
      consentAt: now,
      updatedAt: now,
    );
    if (existing == null) {
      await MedicalProfile.db.insertRow(session, row);
    } else {
      await MedicalProfile.db.updateRow(session, row);
    }
    return medical(session, user);
  }

  Future<void> deleteMedical(Session session, AppUser user) async {
    await MedicalProfile.db.deleteWhere(
      session,
      where: (t) => t.userId.equals(user.id!),
    );
  }
}
