import 'package:emergencyhr_flutter/core/di/locator.dart';
import 'package:emergencyhr_flutter/data/datasources/local/branch_local_storage.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/base/api_response.dart';
import 'package:emergencyhr_flutter/data/datasources/remote/branch_api.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';

class BranchRepo {
  final BranchDataProvider _branchApi;
  final BranchLocalStorage _localStorage;

  BranchRepo({
    BranchDataProvider? branchApi,
    BranchLocalStorage? localStorage,
  }) : _branchApi = branchApi ?? BranchDataProvider(),
       _localStorage = localStorage ?? branchLocalStorage;

  /// Fetches branches from remote API and updates local cache.
  Future<ApiResponse<List<Branch>>> getBranches({
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _branchApi.getBranches(queryParams: queryParams);

    if (response.success && response.data != null) {
      _localStorage.saveBranches(response.data!);
      _syncUserBranches(response.data!);
    } else {
      final cached = _localStorage.getBranches();
      if (cached.isNotEmpty) {
        return ApiResponse<List<Branch>>(
          success: true,
          message: 'Loaded from local cache',
          data: cached,
        );
      }
    }
    return response;
  }

  Future<ApiResponse<Branch?>> getBranchById(String id) async {
    return await _branchApi.getBranchById(id);
  }

  Future<ApiResponse<Branch?>> createBranch({
    required CreateBranchParam param,
  }) async {
    final response = await _branchApi.createBranch(param: param);
    if (response.success && response.data != null) {
      final cached = _localStorage.getBranches();
      // If new branch is marked as main branch, demote previous main branches
      if (response.data!.isMainBranch) {
        for (var i = 0; i < cached.length; i++) {
          if (cached[i].isMainBranch) {
            cached[i] = cached[i].copyWith(isMainBranch: false);
          }
        }
      }
      cached.insert(0, response.data!);
      _localStorage.saveBranches(cached);
      _syncUserBranches(cached);
    }
    return response;
  }

  Future<ApiResponse<Branch?>> updateBranch({
    required String id,
    required CreateBranchParam param,
  }) async {
    final response = await _branchApi.updateBranch(id: id, param: param);
    if (response.success && response.data != null) {
      final cached = _localStorage.getBranches();
      final index = cached.indexWhere((b) => b.id == id);
      if (index != -1) {
        if (response.data!.isMainBranch) {
          for (var i = 0; i < cached.length; i++) {
            if (i != index && cached[i].isMainBranch) {
              cached[i] = cached[i].copyWith(isMainBranch: false);
            }
          }
        }
        cached[index] = response.data!;
        _localStorage.saveBranches(cached);
        _syncUserBranches(cached);
      }
    }
    return response;
  }

  Future<ApiResponse<bool>> deleteBranch(String id) async {
    final response = await _branchApi.deleteBranch(id);
    if (response.success) {
      final cached = _localStorage.getBranches();
      cached.removeWhere((b) => b.id == id);
      _localStorage.saveBranches(cached);
      _syncUserBranches(cached);
    }
    return response;
  }

  List<Branch> getCachedBranches() {
    return _localStorage.getBranches();
  }

  void _syncUserBranches(List<Branch> branches) {
    if (appGlobals.user != null) {
      final mainBranch = branches.firstWhere(
        (b) => b.isMainBranch,
        orElse: () =>
            branches.isNotEmpty ? branches.first : appGlobals.user!.branch!,
      );
      final updatedUser = appGlobals.user!.copyWith(
        branches: branches,
        branch: branches.isNotEmpty ? mainBranch : appGlobals.user!.branch,
      );
      appLocalStorage.saveUser(updatedUser);
      appGlobals.setUser = updatedUser;
    }
  }
}
