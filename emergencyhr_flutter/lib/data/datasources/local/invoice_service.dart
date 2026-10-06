import 'package:emergencyhr_flutter/data/datasources/local/invoice_local_storage.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';

class InvoiceService {
  final InvoiceLocalStorage _localStorage = InvoiceLocalStorage();

  Future<void> saveInvoice(Invoice invoice) async {
    try {
      final invoices = await getAllInvoices();
      invoices.add(invoice);
      _localStorage.saveInvoices(invoices);
    } catch (e) {
      throw Exception('Failed to save invoice: $e');
    }
  }

  Future<List<Invoice>> getAllInvoices() async {
    try {
      return _localStorage.getInvoices();
    } catch (e) {
      return [];
    }
  }

  Future<Invoice?> getInvoiceById(String id) async {
    try {
      final invoices = await getAllInvoices();
      return invoices.firstWhere((invoice) => invoice.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteInvoice(String id) async {
    try {
      final invoices = await getAllInvoices();
      invoices.removeWhere((invoice) => invoice.id == id);
      _localStorage.saveInvoices(invoices);
    } catch (e) {
      throw Exception('Failed to delete invoice: $e');
    }
  }

  Future<void> updateInvoice(Invoice updatedInvoice) async {
    try {
      final invoices = await getAllInvoices();
      final index = invoices.indexWhere(
        (invoice) => invoice.id == updatedInvoice.id,
      );

      if (index != -1) {
        invoices[index] = updatedInvoice;
        _localStorage.saveInvoices(invoices);
      } else {
        throw Exception('Invoice not found');
      }
    } catch (e) {
      throw Exception('Failed to update invoice: $e');
    }
  }

  Future<List<Invoice>> searchInvoices(String query) async {
    try {
      final invoices = await getAllInvoices();
      final lowerQuery = query.toLowerCase();

      return invoices.where((invoice) {
        return invoice.customerName.toLowerCase().contains(lowerQuery) ||
            invoice.customerPhone.toLowerCase().contains(lowerQuery) ||
            invoice.id.toLowerCase().contains(lowerQuery);
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
