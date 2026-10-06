import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/storage_keys.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';

class BranchLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveBranches(List<Branch> branches) {
    final branchesJson = branches.map((b) => b.toJson()).toList();
    _localStorageService.saveMapList(StorageKeys.branches, branchesJson);
  }

  List<Branch> getBranches() {
    final branchesData = _localStorageService.getMapList(StorageKeys.branches);
    if (branchesData == null) return [];

    return branchesData
        .map((data) => Branch.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  void clearBranches() {
    _localStorageService.save(StorageKeys.branches, null);
  }
}
