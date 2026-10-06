import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/branch_repo.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/user_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'components/add_user_bottom_sheet.dart';

class UserListViewModel extends BaseViewModel {
  final UserRepo _userRepo;
  final BranchRepo _branchRepo;

  UserListViewModel({UserRepo? userRepo, BranchRepo? branchRepo})
    : _userRepo = userRepo ?? userRepoLocator,
      _branchRepo = branchRepo ?? branchRepoLocator;

  static UserRepo get userRepoLocator => userRepo;
  static BranchRepo get branchRepoLocator => branchRepo;

  final TextEditingController searchController = TextEditingController();

  List<AppUser> _allUsers = [];
  List<AppUser> _filteredUsers = [];
  List<AppUser> get users => _filteredUsers;

  String _selectedRoleFilter = 'ALL';
  String get selectedRoleFilter => _selectedRoleFilter;

  int get totalCount => _filteredUsers.length;

  Future<void> init() async {
    final cached = _userRepo.getCachedUsers();
    if (cached.isNotEmpty) {
      _allUsers = cached;
      _applyFilters();
      notifyListeners();
    }
    await fetchUsers(showLoading: cached.isEmpty);
  }

  Future<void> fetchUsers({bool showLoading = true}) async {
    if (showLoading) setBusy(true);

    try {
      final response = await _userRepo.getUsers();
      if (response.success && response.data != null) {
        _allUsers = response.data!;
        _applyFilters();
      } else if (_allUsers.isEmpty) {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to load team users',
        );
      }
    } catch (e) {
      if (_allUsers.isEmpty) {
        snackbarService.error(message: 'Error loading team users');
      }
    } finally {
      if (showLoading) setBusy(false);
    }
  }

  void onSearchChanged(String query) {
    _applyFilters();
  }

  void setRoleFilter(String role) {
    _selectedRoleFilter = role;
    _applyFilters();
  }

  void _applyFilters() {
    final query = searchController.text.trim().toLowerCase();

    _filteredUsers = _allUsers.where((u) {
      // Role match
      final roleMatch =
          _selectedRoleFilter == 'ALL' ||
          u.role.toUpperCase() == _selectedRoleFilter.toUpperCase() ||
          (_selectedRoleFilter == 'ROLE_SALES_BOY' &&
              (u.role.toUpperCase() == 'ROLE_SALES_BOY' ||
                  u.role.toUpperCase() == 'ROLE_SALE_BOY'));

      // Search match
      final nameMatch = u.fullName.toLowerCase().contains(query);
      final emailMatch = u.email.toLowerCase().contains(query);
      final searchMatch = query.isEmpty || nameMatch || emailMatch;

      return roleMatch && searchMatch;
    }).toList();

    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    _applyFilters();
  }

  Future<void> toggleUserStatus(AppUser user) async {
    final targetStatus = !user.isActive;
    setBusy(true);

    try {
      final response = await _userRepo.updateUserStatus(
        id: user.id,
        isActive: targetStatus,
      );

      if (response.success && response.data != null) {
        final index = _allUsers.indexWhere((u) => u.id == user.id);
        if (index != -1) {
          _allUsers[index] = response.data!;
          _applyFilters();
        }
        snackbarService.success(
          message: targetStatus
              ? '${user.fullName} is now active'
              : '${user.fullName} has been deactivated',
        );
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to update user status',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Error updating user status');
    } finally {
      setBusy(false);
    }
  }

  String getBranchName(String? branchId) {
    if (branchId == null || branchId.isEmpty) return 'All Branches';
    final branches = _branchRepo.getCachedBranches();
    if (branches.isEmpty && appGlobals.user?.branches != null) {
      final match = appGlobals.user!.branches.where((b) => b.id == branchId);
      if (match.isNotEmpty) return match.first.name;
    }
    final match = branches.where((b) => b.id == branchId);
    return match.isNotEmpty ? match.first.name : 'Store Branch';
  }

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    snackbarService.success(message: '$label copied to clipboard!');
  }

  void openAddUserSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddUserBottomSheet(
        onSaved: () => fetchUsers(showLoading: false),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
