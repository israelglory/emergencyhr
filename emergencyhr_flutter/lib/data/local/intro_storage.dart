import 'base/local_storage_service.dart';
import 'base/storage_keys.dart';

/// Remembers that the first-launch intro was shown, so it shows once.
class IntroStorage {
  IntroStorage({LocalStorageService? storage}) : _storageOverride = storage;

  final LocalStorageService? _storageOverride;
  LocalStorageService get _storage =>
      _storageOverride ?? LocalStorageService.app();

  bool get introSeen => _storage.getString(StorageKeys.introSeen) == 'yes';

  Future<void> markIntroSeen() =>
      _storage.saveString(StorageKeys.introSeen, 'yes');
}
