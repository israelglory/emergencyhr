import 'dart:async';

import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_service.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class InvoiceDataProvider {
  final _apiService = ApiService(path: '/invoices');

  Future<ApiResponse<List<Invoice>>> getInvoices({
    String? branchId,
    String? status,
    String? search,
    int? page,
    int? size,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (branchId != null && branchId.isNotEmpty) {
        queryParams['branchId'] = branchId;
      }
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (page != null) queryParams['page'] = page;
      if (size != null) queryParams['size'] = size;

      final res = await _apiService.get(
        '',
        queryParams: queryParams.isNotEmpty ? queryParams : null,
      );

      List<dynamic> list = [];
      if (res["data"] is List) {
        list = res["data"] as List<dynamic>;
      } else if (res["data"] is Map && res["data"]["content"] is List) {
        list = res["data"]["content"] as List<dynamic>;
      }

      final invoices = list
          .map((item) => Invoice.fromJson(item as Map<String, dynamic>))
          .toList();

      return ApiResponse<List<Invoice>>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Invoices retrieved successfully"
        ..data = invoices;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Invoice?>> getInvoiceById(String id) async {
    try {
      final res = await _apiService.get('/$id');
      return ApiResponse<Invoice?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Invoice retrieved successfully"
        ..data = res["data"] != null
            ? Invoice.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Invoice?>> createInvoice({
    required CreateInvoiceParam param,
  }) async {
    try {
      final res = await _apiService.post('', data: param.toJson());
      return ApiResponse<Invoice?>.fromJson(res)
        ..success = true
        ..message = res["message"]?.toString() ?? "Invoice created successfully"
        ..data = res["data"] != null
            ? Invoice.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<PaymentReceipt?>> recordPayment({
    required String invoiceId,
    required RecordPaymentParam param,
  }) async {
    try {
      final res = await _apiService.post(
        '/$invoiceId/payments',
        data: param.toJson(),
      );
      return ApiResponse<PaymentReceipt?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Payment recorded successfully"
        ..data = res["data"] != null
            ? PaymentReceipt.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<dynamic>> deleteInvoice(String id) async {
    try {
      final res = await _apiService.delete('/$id');
      return ApiResponse.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Invoice deleted successfully";
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
