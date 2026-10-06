import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/storage_keys.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';

class UserManagementLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveUsers(List<AppUser> users) {
    final usersJson = users.map((u) => u.toJson()).toList();
    _localStorageService.saveMapList(StorageKeys.users, usersJson);
  }

  List<AppUser> getUsers() {
    final usersData = _localStorageService.getMapList(StorageKeys.users);
    if (usersData == null) return [];

    return usersData
        .map((data) => AppUser.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  void clearUsers() {
    _localStorageService.save(StorageKeys.users, null);
  }
}
