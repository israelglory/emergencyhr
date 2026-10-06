import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/data/datasources/local/user_management_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/user_api.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class UserRepo {
  final UserDataProvider _userApi;
  final UserManagementLocalStorage _localStorage;

  UserRepo({
    UserDataProvider? userApi,
    UserManagementLocalStorage? localStorage,
  }) : _userApi = userApi ?? UserDataProvider(),
       _localStorage = localStorage ?? userManagementLocalStorage;

  /// Fetches users from remote API and updates local cache.
  Future<ApiResponse<List<AppUser>>> getUsers({
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _userApi.getUsers(queryParams: queryParams);

    if (response.success && response.data != null) {
      _localStorage.saveUsers(response.data!);
    } else {
      final cached = _localStorage.getUsers();
      if (cached.isNotEmpty) {
        return ApiResponse<List<AppUser>>(
          success: true,
          message: 'Loaded from local cache',
          data: cached,
        );
      }
    }
    return response;
  }

  Future<ApiResponse<AppUser?>> createUser({
    required CreateUserParam param,
  }) async {
    final response = await _userApi.createUser(param: param);
    if (response.success && response.data != null) {
      final cached = _localStorage.getUsers();
      cached.insert(0, response.data!);
      _localStorage.saveUsers(cached);
    }
    return response;
  }

  Future<ApiResponse<AppUser?>> updateUserStatus({
    required String id,
    required bool isActive,
  }) async {
    final response = await _userApi.updateUserStatus(
      id: id,
      isActive: isActive,
    );
    if (response.success && response.data != null) {
      final cached = _localStorage.getUsers();
      final index = cached.indexWhere((u) => u.id == id);
      if (index != -1) {
        cached[index] = response.data!;
        _localStorage.saveUsers(cached);
      }
    }
    return response;
  }

  Future<ApiResponse<UserBankDetails?>> updateBankDetails({
    required UserBankDetails bankDetails,
  }) async {
    final response = await _userApi.updateBankDetails(bankDetails: bankDetails);
    if (response.success && response.data != null) {
      if (appGlobals.user != null) {
        final updatedUser = appGlobals.user!.copyWith(
          bankDetails: response.data,
        );
        appGlobals.updateUser(updatedUser);
      }
    }
    return response;
  }

  List<AppUser> getCachedUsers() {
    return _localStorage.getUsers();
  }
}
