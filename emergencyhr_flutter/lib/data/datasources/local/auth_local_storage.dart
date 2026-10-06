import 'package:emergencyhr_flutter/data/datasources/local/base/storage_keys.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';
import 'base/local_storage_service.dart';

class AuthLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.authBox));

  void saveToken(String? value) {
    _localStorageService.save(StorageKeys.token, value);
  }

  void saveBiometric(bool? value) {
    _localStorageService.save(StorageKeys.biometrics, value);
  }

  String? getToken() {
    return _localStorageService.getString(StorageKeys.token);
  }

  void saveRefreshToken(String? value) {
    _localStorageService.save(StorageKeys.refreshToken, value);
  }

  String? getRefreshToken() {
    return _localStorageService.getString(StorageKeys.refreshToken);
  }

  void saveLoginPin(String? value) {
    _localStorageService.save(StorageKeys.loginPin, value);
  }

  String? getLoginPin() {
    return _localStorageService.getString(StorageKeys.loginPin);
  }

  bool? getBiometrics() {
    return _localStorageService.getBool(StorageKeys.biometrics);
  }

  void clearTokens() {
    saveToken(null);
    saveRefreshToken(null);
  }
}
