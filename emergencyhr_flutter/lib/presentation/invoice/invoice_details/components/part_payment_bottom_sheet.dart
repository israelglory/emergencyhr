import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:flutter/material.dart';

class PartPaymentBottomSheet extends StatefulWidget {
  final Invoice invoice;
  final Future<void> Function({
    required double amount,
    required String paymentMethod,
    String? note,
  })
  onSubmit;

  const PartPaymentBottomSheet({
    super.key,
    required this.invoice,
    required this.onSubmit,
  });

  @override
  State<PartPaymentBottomSheet> createState() => _PartPaymentBottomSheetState();
}

class _PartPaymentBottomSheetState extends State<PartPaymentBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _selectedMethod = 'Bank Transfer';
  String? _errorMessage;
  bool _isSubmitting = false;

  final List<String> _paymentMethods = [
    'Bank Transfer',
    'Cash',
    'POS',
    'Card',
  ];

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    setState(() {
      _errorMessage = null;
    });
  }

  double get _enteredAmount {
    return double.tryParse(_amountController.text.trim()) ?? 0.0;
  }

  double get _newRemainingBalance {
    final remaining = widget.invoice.amountRemaining - _enteredAmount;
    return remaining < 0 ? 0.0 : remaining;
  }

  double get _newTotalPaid {
    return widget.invoice.amountPaid + _enteredAmount;
  }

  void _setPercentage(double fraction) {
    final amount = widget.invoice.amountRemaining * fraction;
    // Format to 2 decimal places if needed or int
    final formatted = amount % 1 == 0
        ? amount.toInt().toString()
        : amount.toStringAsFixed(2);
    _amountController.text = formatted;
    _amountController.selection = TextSelection.fromPosition(
      TextPosition(offset: _amountController.text.length),
    );
  }

  bool _validate() {
    final amount = _enteredAmount;
    if (amount <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid payment amount greater than zero';
      });
      return false;
    }
    if (amount > widget.invoice.amountRemaining) {
      setState(() {
        _errorMessage =
            'Payment amount cannot exceed outstanding balance of ${CurrencyFormatter.formatNaira(widget.invoice.amountRemaining)}';
      });
      return false;
    }
    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting || !_validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await widget.onSubmit(
        amount: _enteredAmount,
        paymentMethod: _selectedMethod,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to record payment: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: mediaQuery.viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title & Invoice No
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  'Record Part Payment',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: AppText(
                    widget.invoice.invoiceNumber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            AppText(
              'Customer: ${widget.invoice.customerName}',
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
            const SizedBox(height: 16),

            // Outstanding Balance Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    'Outstanding Balance:',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  AppText(
                    CurrencyFormatter.formatNaira(
                      widget.invoice.amountRemaining,
                    ),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange.shade900,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Payment Amount Input
            const AppText(
              'Payment Amount (₦)',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            const SizedBox(height: 8),
            AppCustomTextField(
              hintText: '0.00',
              textEditingController: _amountController,
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              errorText: _errorMessage,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: AppText(
                  '₦',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Quick Percentage Chips
            Row(
              children: [
                _buildQuickChip('25%', () => _setPercentage(0.25)),
                const SizedBox(width: 8),
                _buildQuickChip('50%', () => _setPercentage(0.50)),
                const SizedBox(width: 8),
                _buildQuickChip('75%', () => _setPercentage(0.75)),
                const SizedBox(width: 8),
                _buildQuickChip(
                  'Full Amount',
                  () => _setPercentage(1.0),
                  isPrimary: true,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Payment Method Selector
            const AppText(
              'Payment Method',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _paymentMethods.map((method) {
                final isSelected = _selectedMethod == method;
                return ChoiceChip(
                  label: AppText(
                    method,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12,
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primaryColor,
                  backgroundColor: Colors.grey.shade100,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedMethod = method;
                      });
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Optional Note / Reference
            const AppText(
              'Note / Reference (Optional)',
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            const SizedBox(height: 8),
            AppCustomTextField(
              hintText: 'e.g. Bank transfer reference, deposit note',
              textEditingController: _noteController,
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // Live Calculation Preview
            if (_enteredAmount > 0 && _errorMessage == null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          'Total Paid after this:',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        AppText(
                          CurrencyFormatter.formatNaira(_newTotalPaid),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          'New Balance Remaining:',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        AppText(
                          CurrencyFormatter.formatNaira(_newRemainingBalance),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _newRemainingBalance <= 0
                              ? Colors.green
                              : Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Submit Button
            AppButton(
              title: _isSubmitting
                  ? 'Recording Payment...'
                  : 'Generate Receipt',
              onPressed: _isSubmitting ? null : _handleSubmit,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickChip(
    String label,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isPrimary ? Colors.green.shade50 : Colors.grey.shade100,
            border: Border.all(
              color: isPrimary ? Colors.green.shade300 : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: AppText(
            label,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isPrimary ? Colors.green.shade800 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
