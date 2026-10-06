import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';

class AddEditBranchBottomSheet extends StatefulWidget {
  final Branch? branch;
  final VoidCallback onSaved;

  const AddEditBranchBottomSheet({
    super.key,
    this.branch,
    required this.onSaved,
  });

  @override
  State<AddEditBranchBottomSheet> createState() =>
      _AddEditBranchBottomSheetState();
}

class _AddEditBranchBottomSheetState extends State<AddEditBranchBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isMainBranch = false;
  bool _isLoading = false;

  bool get isEditing => widget.branch != null;

  @override
  void initState() {
    super.initState();
    if (widget.branch != null) {
      _nameController.text = widget.branch!.name;
      _addressController.text = widget.branch!.address;
      _phoneController.text = widget.branch!.phone;
      _isMainBranch = widget.branch!.isMainBranch;
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final param = CreateBranchParam(
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        phone: _phoneController.text.trim(),
        isMainBranch: _isMainBranch,
      );

      if (isEditing) {
        final res = await branchRepo.updateBranch(
          id: widget.branch!.id,
          param: param,
        );
        if (res.success) {
          snackbarService.success(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Branch updated successfully',
          );
          if (mounted) {
            Navigator.pop(context);
            widget.onSaved();
          }
        } else {
          snackbarService.error(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Failed to update branch',
          );
        }
      } else {
        final res = await branchRepo.createBranch(param: param);
        if (res.success) {
          snackbarService.success(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Branch created successfully',
          );
          if (mounted) {
            Navigator.pop(context);
            widget.onSaved();
          }
        } else {
          snackbarService.error(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Failed to create branch',
          );
        }
      }
    } catch (e) {
      snackbarService.error(message: 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
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

              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    isEditing ? 'Edit Store Branch' : 'Add Store Branch',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 22, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // Branch Name
              const AppText(
                'Branch Name *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _nameController,
                hintText: 'e.g. West Coast Branch / Headquarters',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.storefront_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter branch name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Address
              const AppText(
                'Physical Address *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _addressController,
                hintText: 'e.g. 456 Market St, Suite 200, San Francisco, CA',
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter branch address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Phone
              const AppText(
                'Phone Number *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _phoneController,
                hintText: 'e.g. +1-415-555-0188',
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter branch phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Main Branch Toggle Switch
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            'Main Branch (Headquarters)',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 2),
                          AppText(
                            'Designate this location as the primary store branch.',
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _isMainBranch,
                      activeTrackColor: AppColors.primaryColor,
                      onChanged: (val) {
                        setState(() => _isMainBranch = val);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              AppButton(
                title: isEditing ? 'Update Branch' : 'Create Branch',
                loading: _isLoading,
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 48,
                onPressed: _isLoading ? null : _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
