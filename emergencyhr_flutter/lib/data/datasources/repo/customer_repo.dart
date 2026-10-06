import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/data/datasources/local/customer_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/customer_api.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class CustomerRepo {
  final CustomerDataProvider _customerApi;
  final CustomerLocalStorage _localStorage;

  CustomerRepo({
    CustomerDataProvider? customerApi,
    CustomerLocalStorage? localStorage,
  }) : _customerApi = customerApi ?? CustomerDataProvider(),
       _localStorage = localStorage ?? customerLocalStorage;

  /// Fetches customers from remote API and updates local cache.
  /// Falls back to local cached list if offline/error.
  Future<ApiResponse<List<Customer>>> getCustomers({
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _customerApi.getCustomers(queryParams: queryParams);

    if (response.success && response.data != null) {
      _localStorage.saveCustomers(response.data!);
    } else {
      final cached = _localStorage.getCustomers();
      if (cached.isNotEmpty) {
        return ApiResponse<List<Customer>>(
          success: true,
          message: 'Loaded from local cache',
          data: cached,
        );
      }
    }
    return response;
  }

  Future<ApiResponse<Customer?>> getCustomerById(String id) async {
    return await _customerApi.getCustomerById(id);
  }

  Future<ApiResponse<Customer?>> createCustomer({
    required CreateCustomerParam param,
  }) async {
    final response = await _customerApi.createCustomer(param: param);
    if (response.success && response.data != null) {
      final cached = _localStorage.getCustomers();
      cached.insert(0, response.data!);
      _localStorage.saveCustomers(cached);
    }
    return response;
  }

  Future<ApiResponse<Customer?>> updateCustomer({
    required String id,
    required CreateCustomerParam param,
  }) async {
    final response = await _customerApi.updateCustomer(id: id, param: param);
    if (response.success && response.data != null) {
      final cached = _localStorage.getCustomers();
      final index = cached.indexWhere((c) => c.id == id);
      if (index != -1) {
        cached[index] = response.data!;
        _localStorage.saveCustomers(cached);
      }
    }
    return response;
  }

  Future<ApiResponse<bool>> deleteCustomer(String id) async {
    final response = await _customerApi.deleteCustomer(id);
    if (response.success) {
      final cached = _localStorage.getCustomers();
      cached.removeWhere((c) => c.id == id);
      _localStorage.saveCustomers(cached);
    }
    return response;
  }

  Future<ApiResponse<CustomerStatement?>> getCustomerInvoices(
    String customerId,
  ) async {
    return await _customerApi.getCustomerInvoices(customerId);
  }

  List<Customer> getCachedCustomers() {
    return _localStorage.getCustomers();
  }
}
