import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/datasources/repo/branch_repo.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/add_edit_branch_bottom_sheet.dart';

class BranchListViewModel extends BaseViewModel {
  final BranchRepo _branchRepo;

  BranchListViewModel({BranchRepo? branchRepo})
    : _branchRepo = branchRepo ?? branchRepoLocator;

  static BranchRepo get branchRepoLocator => branchRepo;

  final TextEditingController searchController = TextEditingController();

  List<Branch> _allBranches = [];
  List<Branch> _filteredBranches = [];
  List<Branch> get branches => _filteredBranches;

  int get totalCount => _filteredBranches.length;

  Future<void> init() async {
    final cached = _branchRepo.getCachedBranches();
    if (cached.isNotEmpty) {
      _allBranches = cached;
      _filteredBranches = cached;
      notifyListeners();
    } else if (appGlobals.user?.branches.isNotEmpty == true) {
      _allBranches = appGlobals.user!.branches;
      _filteredBranches = appGlobals.user!.branches;
      notifyListeners();
    }
    await fetchBranches(showLoading: _allBranches.isEmpty);
  }

  Future<void> fetchBranches({bool showLoading = true}) async {
    if (showLoading) setBusy(true);

    try {
      final response = await _branchRepo.getBranches();
      if (response.success && response.data != null) {
        _allBranches = response.data!;
        _applySearch(searchController.text);
      } else if (_allBranches.isEmpty) {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to load branches',
        );
      }
    } catch (e) {
      if (_allBranches.isEmpty) {
        snackbarService.error(message: 'Error loading branches');
      }
    } finally {
      if (showLoading) setBusy(false);
    }
  }

  void onSearchChanged(String query) {
    _applySearch(query);
  }

  void _applySearch(String query) {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      _filteredBranches = List.from(_allBranches);
    } else {
      _filteredBranches = _allBranches.where((b) {
        final nameMatch = b.name.toLowerCase().contains(cleanQuery);
        final phoneMatch = b.phone.toLowerCase().contains(cleanQuery);
        final addressMatch = b.address.toLowerCase().contains(cleanQuery);
        return nameMatch || phoneMatch || addressMatch;
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    _filteredBranches = List.from(_allBranches);
    notifyListeners();
  }

  Future<void> deleteBranch(String id) async {
    if (!appGlobals.canDelete) {
      snackbarService.error(
        message: 'Permission denied: Only administrators can delete branches.',
      );
      return;
    }

    setBusy(true);
    try {
      final response = await _branchRepo.deleteBranch(id);
      if (response.success) {
        _allBranches.removeWhere((b) => b.id == id);
        _applySearch(searchController.text);
        snackbarService.success(message: 'Branch deleted successfully');
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to delete branch',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Error deleting branch');
    } finally {
      setBusy(false);
    }
  }

  Future<void> callPhone(String phone) async {
    if (phone.isEmpty) return;
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        copyToClipboard(phone, 'Phone number');
      }
    } catch (e) {
      copyToClipboard(phone, 'Phone number');
    }
  }

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    snackbarService.success(message: '$label copied to clipboard!');
  }

  void openAddBranchSheet(BuildContext context) {
    if (!appGlobals.canEdit) {
      snackbarService.error(
        message: 'Permission denied: Only administrators can add new branches.',
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditBranchBottomSheet(
        onSaved: () => fetchBranches(showLoading: false),
      ),
    );
  }

  void openEditBranchSheet(BuildContext context, Branch branch) {
    if (!appGlobals.canEdit) {
      snackbarService.error(
        message: 'Permission denied: Only administrators can edit branches.',
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditBranchBottomSheet(
        branch: branch,
        onSaved: () => fetchBranches(showLoading: false),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
