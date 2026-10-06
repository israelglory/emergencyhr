import 'package:emergencyhr_flutter/data/datasources/local/base/local_storage_service.dart';
import 'package:emergencyhr_flutter/data/datasources/local/base/storage_keys.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:hive/hive.dart';

import 'base/hive_boxes.dart';

class InvoiceLocalStorage {
  final _localStorageService = LocalStorageService(Hive.box(HiveBoxes.appBox));

  void saveInvoices(List<Invoice> invoices) {
    final invoicesJson = invoices.map((invoice) => invoice.toJson()).toList();
    _localStorageService.saveMapList(StorageKeys.invoices, invoicesJson);
  }

  List<Invoice> getInvoices() {
    final invoicesData = _localStorageService.getMapList(StorageKeys.invoices);
    if (invoicesData == null) return [];

    return invoicesData
        .map((data) => Invoice.fromJson(Map<String, dynamic>.from(data)))
        .toList();
  }

  void clearInvoices() {
    _localStorageService.save(StorageKeys.invoices, null);
  }
}
