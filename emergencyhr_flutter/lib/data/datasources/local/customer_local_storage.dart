import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/storage_keys.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';

class CustomerLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveCustomers(List<Customer> customers) {
    final customersJson = customers.map((c) => c.toJson()).toList();
    _localStorageService.saveMapList(StorageKeys.customers, customersJson);
  }

  List<Customer> getCustomers() {
    final customersData = _localStorageService.getMapList(
      StorageKeys.customers,
    );
    if (customersData == null) return [];

    return customersData
        .map((data) => Customer.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  void clearCustomers() {
    _localStorageService.save(StorageKeys.customers, null);
  }
}
