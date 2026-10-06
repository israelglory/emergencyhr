import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseBottomSheet extends StatefulWidget {
  final Future<bool> Function(CreateExpenseParam param) onSave;

  const AddExpenseBottomSheet({
    super.key,
    required this.onSave,
  });

  @override
  State<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends State<AddExpenseBottomSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedCategory = 'Office Supplies';
  DateTime _selectedDate = DateTime.now();
  String? _selectedBranchId;
  List<Branch> _branches = [];
  String? _errorMessage;
  bool _isSaving = false;

  final List<String> _categories = [
    'Office Supplies',
    'Materials',
    'Equipment',
    'Utilities',
    'Logistics',
    'Rent',
    'General',
  ];

  @override
  void initState() {
    super.initState();
    if (appGlobals.isAdmin) {
      _branches = branchRepo.getCachedBranches();
      if (_branches.isEmpty && appGlobals.user?.branches != null) {
        _branches = appGlobals.user!.branches;
      }
      final main = _branches.where((b) => b.isMainBranch).toList();
      _selectedBranchId = main.isNotEmpty
          ? main.first.id
          : (_branches.isNotEmpty ? _branches.first.id : '');
    } else {
      _selectedBranchId =
          appGlobals.user?.branch?.id ??
          (appGlobals.user?.branches.isNotEmpty == true
              ? appGlobals.user!.branches.first.id
              : '');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  bool _validate() {
    if (_selectedBranchId == null || _selectedBranchId!.isEmpty) {
      setState(() {
        _errorMessage = 'Please select a store branch';
      });
      return false;
    }

    if (_titleController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please describe what was bought';
      });
      return false;
    }

    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (amount <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid expense amount greater than zero';
      });
      return false;
    }

    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  Future<void> _handleSubmit() async {
    if (_isSaving || !_validate()) return;

    setState(() {
      _isSaving = true;
    });

    final param = CreateExpenseParam(
      branchId: _selectedBranchId!,
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      category: _selectedCategory,
      note: _noteController.text.trim().isNotEmpty
          ? _noteController.text.trim()
          : null,
      date: _selectedDate,
    );

    final success = await widget.onSave(param);
    if (mounted) {
      setState(() {
        _isSaving = false;
      });
      if (success) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  'Record Expense',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 4),
            AppText(
              'Log an operating expenditure for the business',
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 18),

            // Branch Selector (Admin) or Assigned Branch Badge (Staff/Sales Boy)
            if (appGlobals.isAdmin && _branches.isNotEmpty) ...[
              const AppText(
                'Store Branch *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBranchId,
                    isExpanded: true,
                    items: _branches.map((b) {
                      return DropdownMenuItem<String>(
                        value: b.id,
                        child: AppText(
                          '${b.name}${b.isMainBranch ? ' (Main Store)' : ''}',
                          fontSize: 14,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedBranchId = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ] else ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
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
                    Expanded(
                      child: AppText(
                        'Branch: ${appGlobals.user?.branch?.name ?? (appGlobals.user?.branches.isNotEmpty == true ? appGlobals.user!.branches.first.name : "Assigned Branch")}',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Title / Item Description
            const AppText(
              'What was bought? *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              hintText: 'e.g. Office Supplies & Printer Ink',
              textEditingController: _titleController,
            ),
            const SizedBox(height: 14),

            // Amount
            const AppText(
              'Amount Spent (₦) *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              hintText: '0.00',
              textEditingController: _amountController,
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 14),

            // Category & Date Row
            Row(
              children: [
                // Category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        'Category',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            isExpanded: true,
                            items: _categories.map((c) {
                              return DropdownMenuItem<String>(
                                value: c,
                                child: AppText(c, fontSize: 13),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedCategory = val;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        'Date',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: _pickDate,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                fontSize: 13,
                              ),
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Note (Optional)
            const AppText(
              'Additional Note (Optional)',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              hintText: 'e.g. Purchased from Staples for branch workstation 3',
              textEditingController: _noteController,
              maxLines: 2,
            ),
            const SizedBox(height: 14),

            // Error Message
            if (_errorMessage != null) ...[
              AppText(
                _errorMessage!,
                color: Colors.red.shade700,
                fontSize: 12,
              ),
              const SizedBox(height: 10),
            ],

            // Submit Button
            AppButton(
              title: 'Record Expense',
              loading: _isSaving,
              color: AppColors.primaryColor,
              textColor: Colors.white,
              radius: 10,
              height: 48,
              onPressed: _isSaving ? null : _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
