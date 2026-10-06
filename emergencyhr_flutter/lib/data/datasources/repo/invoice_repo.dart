import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/data/datasources/local/invoice_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/invoice_api.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';

class InvoiceRepo {
  final InvoiceDataProvider _invoiceApi;
  final InvoiceLocalStorage _localStorage;

  InvoiceRepo({
    InvoiceDataProvider? invoiceApi,
    InvoiceLocalStorage? localStorage,
  }) : _invoiceApi = invoiceApi ?? InvoiceDataProvider(),
       _localStorage = localStorage ?? invoiceLocalStorage;

  /// Retrieves invoices. If the current user is not an Admin,
  /// their branchId is automatically applied.
  Future<ApiResponse<List<Invoice>>> getInvoices({
    String? branchId,
    String? status,
    String? search,
    int? page,
    int? size,
  }) async {
    // Non-admin users only see their assigned branch invoices
    String? effectiveBranchId = branchId;
    if (!appGlobals.isAdmin) {
      effectiveBranchId =
          appGlobals.user?.branch?.id ??
          (appGlobals.user?.branches.isNotEmpty == true
              ? appGlobals.user!.branches.first.id
              : null);
    }

    final response = await _invoiceApi.getInvoices(
      branchId: effectiveBranchId,
      status: status,
      search: search,
      page: page,
      size: size,
    );

    if (response.success && response.data != null) {
      _localStorage.saveInvoices(response.data!);
    } else {
      final cached = _localStorage.getInvoices();
      if (cached.isNotEmpty) {
        var filtered = cached;
        if (effectiveBranchId != null && effectiveBranchId.isNotEmpty) {
          filtered = filtered
              .where((i) => i.branchId == effectiveBranchId)
              .toList();
        }
        if (status != null && status.isNotEmpty) {
          filtered = filtered
              .where(
                (i) =>
                    i.status.label.toUpperCase() == status.toUpperCase() ||
                    i.statusString?.toUpperCase() == status.toUpperCase(),
              )
              .toList();
        }
        if (search != null && search.isNotEmpty) {
          final q = search.toLowerCase();
          filtered = filtered
              .where(
                (i) =>
                    i.customerName.toLowerCase().contains(q) ||
                    i.invoiceNumber.toLowerCase().contains(q) ||
                    i.customerPhone.toLowerCase().contains(q),
              )
              .toList();
        }
        return ApiResponse<List<Invoice>>(
          success: true,
          message: 'Loaded from local cache',
          data: filtered,
        );
      }
    }
    return response;
  }

  Future<ApiResponse<Invoice?>> getInvoiceById(String id) async {
    final response = await _invoiceApi.getInvoiceById(id);
    if (response.success && response.data != null) {
      final cached = _localStorage.getInvoices();
      final index = cached.indexWhere((i) => i.id == id);
      if (index != -1) {
        cached[index] = response.data!;
      } else {
        cached.insert(0, response.data!);
      }
      _localStorage.saveInvoices(cached);
    }
    return response;
  }

  Future<ApiResponse<Invoice?>> createInvoice({
    required CreateInvoiceParam param,
  }) async {
    final response = await _invoiceApi.createInvoice(param: param);
    if (response.success && response.data != null) {
      final cached = _localStorage.getInvoices();
      cached.insert(0, response.data!);
      _localStorage.saveInvoices(cached);
    }
    return response;
  }

  Future<ApiResponse<PaymentReceipt?>> recordPayment({
    required String invoiceId,
    required RecordPaymentParam param,
  }) async {
    final response = await _invoiceApi.recordPayment(
      invoiceId: invoiceId,
      param: param,
    );

    if (response.success && response.data != null) {
      final receipt = response.data!;
      final cached = _localStorage.getInvoices();
      final index = cached.indexWhere((i) => i.id == invoiceId);
      if (index != -1) {
        final existing = cached[index];
        final updatedPayments = List<PaymentReceipt>.from(existing.payments)
          ..add(receipt);
        final newAmountPaid = receipt.totalAmountPaid;
        final newAmountRemaining = receipt.remainingBalance;
        final newStatus = newAmountRemaining <= 0.0001
            ? 'PAID'
            : (newAmountPaid > 0 ? 'PARTIALLY_PAID' : 'UNPAID');

        final updatedInvoice = existing.copyWith(
          payments: updatedPayments,
          amountPaidExplicit: newAmountPaid,
          amountRemainingExplicit: newAmountRemaining,
          statusString: newStatus,
        );
        cached[index] = updatedInvoice;
        _localStorage.saveInvoices(cached);
      }
    }
    return response;
  }

  Future<ApiResponse<dynamic>> deleteInvoice(String id) async {
    final response = await _invoiceApi.deleteInvoice(id);
    if (response.success) {
      final cached = _localStorage.getInvoices();
      cached.removeWhere((i) => i.id == id);
      _localStorage.saveInvoices(cached);
    }
    return response;
  }

  List<Invoice> getCachedInvoices() {
    return _localStorage.getInvoices();
  }
}
