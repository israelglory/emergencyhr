import 'package:emergencyhr_client/emergencyhr_client.dart';

import 'base/local_storage_service.dart';
import 'base/storage_keys.dart';

/// Unsent facility drafts, so a dropped connection mid-visit loses nothing.
class DraftStorage {
  DraftStorage({LocalStorageService? storage}) : _storageOverride = storage;

  final LocalStorageService? _storageOverride;
  LocalStorageService get _storage =>
      _storageOverride ?? LocalStorageService.app();

  FacilityProfileInput? readFacilityDraft() {
    final json = _storage.readJson(StorageKeys.agentDrafts);
    if (json is! Map<String, dynamic>) return null;
    try {
      return FacilityProfileInput.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveFacilityDraft(FacilityProfileInput input) =>
      _storage.saveJson(StorageKeys.agentDrafts, input.toJson());

  Future<void> clearFacilityDraft() => _storage.remove(StorageKeys.agentDrafts);
}
