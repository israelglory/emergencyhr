import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/storage_keys.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';

class ReportLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveFinancialReport(FinancialReport report) {
    _localStorageService.saveMap(StorageKeys.financialReport, report.toJson());
  }

  FinancialReport? getFinancialReport() {
    final reportData = _localStorageService.getMap(StorageKeys.financialReport);
    if (reportData == null) return null;

    return FinancialReport.fromJson(Map<String, dynamic>.from(reportData));
  }

  void clearFinancialReport() {
    _localStorageService.save(StorageKeys.financialReport, null);
  }
}
