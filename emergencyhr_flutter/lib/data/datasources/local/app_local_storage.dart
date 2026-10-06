import 'package:emergencyhr_flutter/core/states/app_state.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:hive/hive.dart';

import '../../model/model.dart';
import 'base/hive_boxes.dart';
import 'base/storage_keys.dart';

class AppLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveAppState(String value) {
    _localStorageService.save(StorageKeys.appState, value);
  }

  String getAppState() {
    return _localStorageService.getString(StorageKeys.appState) ??
        AppState.unauthenticated;
  }

  void saveUser(User? user) {
    _localStorageService.saveMap(StorageKeys.appUser, user?.toJson());
  }

  void saveNotificationToken(String? value) {
    _localStorageService.save(StorageKeys.notificationToken, value);
  }

  String? getNotificationToken() {
    return _localStorageService.getString(StorageKeys.notificationToken);
  }

  User? getUser() {
    final res = _localStorageService.getMap(StorageKeys.appUser);
    if (res == null) return null;
    return User.fromJson(res);
  }
}
