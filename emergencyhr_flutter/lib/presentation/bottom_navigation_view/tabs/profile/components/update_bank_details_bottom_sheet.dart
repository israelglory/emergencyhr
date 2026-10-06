import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';

class UpdateBankDetailsBottomSheet extends StatefulWidget {
  final VoidCallback? onSaved;

  const UpdateBankDetailsBottomSheet({super.key, this.onSaved});

  @override
  State<UpdateBankDetailsBottomSheet> createState() =>
      _UpdateBankDetailsBottomSheetState();
}

class _UpdateBankDetailsBottomSheetState
    extends State<UpdateBankDetailsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _bankNameController;
  late final TextEditingController _accountNumberController;
  late final TextEditingController _accountNameController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final currentBank = appGlobals.user?.bankDetails;
    _bankNameController = TextEditingController(
      text: currentBank?.bankName.isNotEmpty == true
          ? currentBank!.bankName
          : 'Moniepoint MFB',
    );
    _accountNumberController = TextEditingController(
      text: currentBank?.accountNumber.isNotEmpty == true
          ? currentBank!.accountNumber
          : '7067376069',
    );
    _accountNameController = TextEditingController(
      text: currentBank?.accountName.isNotEmpty == true
          ? currentBank!.accountName
          : 'Bglow creations ent.',
    );
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final param = UserBankDetails(
        bankName: _bankNameController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
        accountName: _accountNameController.text.trim(),
      );

      final response = await userRepo.updateBankDetails(bankDetails: param);

      if (response.success && response.data != null) {
        snackbarService.success(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Bank details updated successfully',
        );
        if (mounted) {
          widget.onSaved?.call();
          Navigator.pop(context);
        }
      } else {
        snackbarService.error(
          message: response.message?.isNotEmpty == true
              ? response.message!
              : 'Failed to update bank details',
        );
      }
    } catch (e) {
      snackbarService.error(message: 'Error updating bank details');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
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

              // Title Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.account_balance_outlined,
                        color: AppColors.primaryColor,
                        size: 22,
                      ),
                      SizedBox(width: 8),
                      AppText(
                        'Settlement Bank Details',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 22, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              AppText(
                'These account details will appear on all customer invoices, receipts, and statement PDFs.',
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // Bank Name
              const AppText(
                'Bank / Institution Name *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                hintText: 'e.g. Moniepoint MFB, GTBank, Zenith',
                textEditingController: _bankNameController,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Bank name is required'
                    : null,
              ),
              const SizedBox(height: 14),

              // Account Number
              const AppText(
                'Account Number *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                hintText: 'e.g. 7067376069',
                textEditingController: _accountNumberController,
                textInputType: TextInputType.number,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Account number is required'
                    : null,
              ),
              const SizedBox(height: 14),

              // Account Name
              const AppText(
                'Account Name (Beneficiary) *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                hintText: 'e.g. Bglow creations ent.',
                textEditingController: _accountNameController,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Account name is required'
                    : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              AppButton(
                title: 'Save Bank Details',
                loading: _isLoading,
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 48,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
