import 'dart:async';

import 'package:emergencyhr_flutter/data/datasources/remote/base/api_failure.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_service.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class CustomerDataProvider {
  final _apiService = ApiService(path: '/customers');

  Future<ApiResponse<List<Customer>>> getCustomers({
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _apiService.get('', queryParams: queryParams);
      final List<dynamic> list = res["data"] as List<dynamic>? ?? [];
      final customers = list
          .map((item) => Customer.fromJson(item as Map<String, dynamic>))
          .toList();

      return ApiResponse<List<Customer>>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Customers retrieved successfully"
        ..data = customers;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Customer?>> getCustomerById(String id) async {
    try {
      final res = await _apiService.get('/$id');
      return ApiResponse<Customer?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Customer retrieved successfully"
        ..data = res["data"] != null
            ? Customer.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Customer?>> createCustomer({
    required CreateCustomerParam param,
  }) async {
    try {
      final res = await _apiService.post('', data: param.toJson());
      return ApiResponse<Customer?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Customer created successfully"
        ..data = res["data"] != null
            ? Customer.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<Customer?>> updateCustomer({
    required String id,
    required CreateCustomerParam param,
  }) async {
    try {
      final res = await _apiService.put('/$id', data: param.toJson());
      return ApiResponse<Customer?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Customer updated successfully"
        ..data = res["data"] != null
            ? Customer.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<bool>> deleteCustomer(String id) async {
    try {
      final res = await _apiService.delete('/$id');
      return ApiResponse<bool>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ?? "Customer deleted successfully"
        ..data = true;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }

  Future<ApiResponse<CustomerStatement?>> getCustomerInvoices(
    String customerId,
  ) async {
    try {
      final res = await _apiService.get('/$customerId/invoices');
      return ApiResponse<CustomerStatement?>.fromJson(res)
        ..success = true
        ..message =
            res["message"]?.toString() ??
            "Customer invoices retrieved successfully"
        ..data = res["data"] != null
            ? CustomerStatement.fromJson(res["data"] as Map<String, dynamic>)
            : null;
    } on ApiFailure catch (e) {
      return ApiResponse(success: false, message: e.message);
    } catch (e) {
      return ApiResponse(success: false, message: e.toString());
    }
  }
}
