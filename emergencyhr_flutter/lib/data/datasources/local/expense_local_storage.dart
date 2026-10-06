import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/storage_keys.dart';
import 'package:emergencyhr_flutter/data/model/params/expense.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';

class ExpenseLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveExpenses(List<Expense> expenses) {
    final expensesJson = expenses.map((e) => e.toJson()).toList();
    _localStorageService.saveMapList(StorageKeys.expenses, expensesJson);
  }

  List<Expense> getExpenses() {
    final expensesData = _localStorageService.getMapList(StorageKeys.expenses);
    if (expensesData == null) return [];

    return expensesData
        .map((data) => Expense.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  void clearExpenses() {
    _localStorageService.save(StorageKeys.expenses, null);
  }
}
