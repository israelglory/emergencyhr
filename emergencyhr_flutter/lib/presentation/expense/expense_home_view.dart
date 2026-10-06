import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'components/add_expense_bottom_sheet.dart';
import 'components/expense_tile.dart';
import 'expense_home_viewmodel.dart';

class ExpenseHomeView extends StatelessWidget {
  const ExpenseHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpenseHomeViewModel>.reactive(
      viewModelBuilder: () => ExpenseHomeViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openAddExpenseSheet(context, model),
            backgroundColor: AppColors.primaryColor,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const AppText(
              'Log Expense',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomAppBar(
                    isBack: true,
                    title: 'Operating Expenses',
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => model.loadExpenses(showLoading: false),
                    color: AppColors.primaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Admin Store Branch Filter or Staff Branch Badge
                          _buildBranchHeader(model),
                          const SizedBox(height: 12),

                          // Summary KPI Card
                          _buildSummaryCard(model),
                          const SizedBox(height: 14),

                          // Search Bar
                          _buildSearchBar(model),
                          const SizedBox(height: 10),

                          // Date Range & Category Filter Chips
                          _buildFilterRow(context, model),
                          const SizedBox(height: 14),

                          // List Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                'Logged Expenses (${model.expenses.length})',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              if (model.expenses.isNotEmpty)
                                AppText(
                                  CurrencyFormatter.formatNaira(
                                    model.totalExpensesAmount,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.red.shade700,
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Content
                          if (model.isBusy && model.expenses.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 50),
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          else if (model.expenses.isEmpty)
                            _buildEmptyState(context, model)
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: model.expenses.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final expense = model.expenses[index];
                                return ExpenseTile(
                                  expense: expense,
                                  onDelete: appGlobals.canDelete
                                      ? () => _confirmDelete(
                                          context,
                                          model,
                                          expense,
                                        )
                                      : null,
                                );
                              },
                            ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBranchHeader(ExpenseHomeViewModel model) {
    if (appGlobals.isAdmin && model.branches.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.storefront_outlined,
              size: 18,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String?>(
                  value: model.selectedBranchId,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.grey,
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: AppText(
                        'All Store Branches (Consolidated)',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    ...model.branches.map(
                      (b) => DropdownMenuItem<String?>(
                        value: b.id,
                        child: AppText(
                          '${b.name}${b.isMainBranch ? ' (Main Branch)' : ''}',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  onChanged: model.setBranchFilter,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.storefront,
              size: 16,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 8),
            AppText(
              'Branch: ${model.activeBranchName}',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSummaryCard(ExpenseHomeViewModel model) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade800, Colors.red.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade900.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'Total Operating Expenses',
                fontSize: 13,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: AppText(
                  '${model.totalElements} Recorded',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          AppText(
            CurrencyFormatter.formatNaira(model.totalExpensesAmount),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText(
                'This Month',
                fontSize: 12,
                color: Colors.white70,
              ),
              AppText(
                CurrencyFormatter.formatNaira(model.thisMonthExpensesAmount),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ExpenseHomeViewModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: model.searchController,
        onChanged: model.onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search by title, note, or category...',
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
          suffixIcon: model.searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    model.searchController.clear();
                    model.onSearchChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context, ExpenseHomeViewModel model) {
    final hasDateFilter = model.startDate != null && model.endDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Date Filter Button
            InkWell(
              onTap: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                  initialDateRange: hasDateFilter
                      ? DateTimeRange(
                          start: model.startDate!,
                          end: model.endDate!,
                        )
                      : null,
                );
                if (picked != null) {
                  model.setDateFilter(picked.start, picked.end);
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: hasDateFilter ? AppColors.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: hasDateFilter
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 14,
                      color: hasDateFilter ? Colors.white : Colors.black87,
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      hasDateFilter
                          ? '${DateFormat('MMM dd').format(model.startDate!)} - ${DateFormat('MMM dd').format(model.endDate!)}'
                          : 'Date Range',
                      fontSize: 11,
                      fontWeight: hasDateFilter
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: hasDateFilter ? Colors.white : Colors.black87,
                    ),
                    if (hasDateFilter) ...[
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => model.setDateFilter(null, null),
                        child: const Icon(
                          Icons.close,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Clear All Filters Button (if active)
            if (model.searchQuery.isNotEmpty ||
                model.selectedCategory != 'All' ||
                hasDateFilter ||
                (appGlobals.isAdmin && model.selectedBranchId != null))
              InkWell(
                onTap: model.clearFilters,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: AppText(
                    'Reset',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Horizontal Category Chips
        SizedBox(
          height: 32,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.categories.length,
            itemBuilder: (context, index) {
              final cat = model.categories[index];
              final isSelected = model.selectedCategory == cat;

              return Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: FilterChip(
                  label: AppText(
                    cat,
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primaryColor,
                  backgroundColor: Colors.white,
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                    ),
                  ),
                  onSelected: (_) => model.setCategoryFilter(cat),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, ExpenseHomeViewModel model) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 40,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 14),
            const AppText(
              'No expenses recorded',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 6),
            AppText(
              model.searchQuery.isNotEmpty ||
                      model.selectedCategory != 'All' ||
                      model.startDate != null
                  ? 'No expenses match the selected filters.'
                  : 'Start tracking business spending by logging your first expense.',
              fontSize: 13,
              color: Colors.grey.shade600,
              alignment: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppButton(
              title: 'Log First Expense',
              color: AppColors.primaryColor,
              textColor: Colors.white,
              radius: 10,
              height: 48,
              onPressed: () => _openAddExpenseSheet(context, model),
            ),
          ],
        ),
      ),
    );
  }

  void _openAddExpenseSheet(BuildContext context, ExpenseHomeViewModel model) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddExpenseBottomSheet(
        onSave: (param) => model.createExpense(param),
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    ExpenseHomeViewModel model,
    Expense expense,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const AppText(
          'Delete Expense',
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        content: AppText(
          'Are you sure you want to delete the expense "${expense.title}" for ${CurrencyFormatter.formatNaira(expense.amount)}?',
          fontSize: 14,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const AppText('Cancel', color: Colors.grey),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              model.deleteExpense(expense.id);
            },
            child: AppText(
              'Delete',
              color: Colors.red.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
