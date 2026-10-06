import 'package:emergencyhr_client/emergencyhr_client.dart';

import 'base/local_storage_service.dart';
import 'base/storage_keys.dart';

/// The last results, for poor connectivity.
class CachedSearch {
  const CachedSearch(this.search, this.savedAt);
  final EmergencySearch search;
  final DateTime savedAt;
}

class EmergencyCache {
  EmergencyCache({LocalStorageService? storage}) : _override = storage;

  final LocalStorageService? _override;
  LocalStorageService get _storage => _override ?? LocalStorageService.app();

  Future<void> save(EmergencySearch search) => _storage.saveJson(
    StorageKeys.lastEmergencyResults,
    {
      'savedAt': DateTime.now().toUtc().toIso8601String(),
      'search': search.toJson(),
    },
  );

  CachedSearch? read() {
    final json = _storage.readJson(StorageKeys.lastEmergencyResults);
    if (json is! Map<String, dynamic>) return null;
    try {
      return CachedSearch(
        EmergencySearch.fromJson(json['search'] as Map<String, dynamic>),
        DateTime.parse(json['savedAt'] as String),
      );
    } catch (_) {
      return null;
    }
  }
}
