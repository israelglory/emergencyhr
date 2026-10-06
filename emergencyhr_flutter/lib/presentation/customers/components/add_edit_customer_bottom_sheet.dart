import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

class AddEditCustomerBottomSheet extends StatefulWidget {
  final Customer? customer;
  final VoidCallback onSaved;

  const AddEditCustomerBottomSheet({
    super.key,
    this.customer,
    required this.onSaved,
  });

  @override
  State<AddEditCustomerBottomSheet> createState() =>
      _AddEditCustomerBottomSheetState();
}

class _AddEditCustomerBottomSheetState
    extends State<AddEditCustomerBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  String? _selectedBranchId;
  bool _isLoading = false;

  bool get isEditing => widget.customer != null;

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _nameController.text = widget.customer!.name;
      _phoneController.text = widget.customer!.phone;
      _addressController.text = widget.customer!.address;
      _selectedBranchId = widget.customer!.branchId;
    } else {
      // Default to main branch if available
      final mainBranch =
          appGlobals.user?.branch ??
          (appGlobals.user?.branches.isNotEmpty == true
              ? appGlobals.user!.branches.firstWhere(
                  (b) => b.isMainBranch,
                  orElse: () => appGlobals.user!.branches.first,
                )
              : null);
      _selectedBranchId = mainBranch?.id;
    }
  }

  Future<void> _pickContact() async {
    try {
      final Contact? contact = await _contactPicker.selectPhoneNumber();
      if (contact != null) {
        String? phone = contact.selectedPhoneNumber;
        if (phone == null || phone.isEmpty) {
          if (contact.phoneNumbers != null &&
              contact.phoneNumbers!.isNotEmpty) {
            phone = contact.phoneNumbers!.first;
          }
        }
        if (phone != null && phone.isNotEmpty) {
          _phoneController.text = phone;
        }

        if (_nameController.text.trim().isEmpty &&
            contact.fullName != null &&
            contact.fullName!.isNotEmpty) {
          _nameController.text = contact.fullName!;
        }
        setState(() {});
      }
    } catch (e) {
      // Ignored
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final param = CreateCustomerParam(
        branchId: _selectedBranchId,
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      if (isEditing) {
        final res = await customerRepo.updateCustomer(
          id: widget.customer!.id,
          param: param,
        );
        if (res.success) {
          snackbarService.success(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Customer updated successfully',
          );
          if (mounted) {
            Navigator.pop(context);
            widget.onSaved();
          }
        } else {
          snackbarService.error(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Failed to update customer',
          );
        }
      } else {
        final res = await customerRepo.createCustomer(param: param);
        if (res.success) {
          snackbarService.success(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Customer created successfully',
          );
          if (mounted) {
            Navigator.pop(context);
            widget.onSaved();
          }
        } else {
          snackbarService.error(
            message: res.message?.isNotEmpty == true
                ? res.message!
                : 'Failed to create customer',
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
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final branches = appGlobals.user?.branches ?? [];

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
              // Top Drag Handle
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
                    isEditing ? 'Edit Customer' : 'Add New Customer',
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

              // Customer Name
              const AppText(
                'Customer / Business Name *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _nameController,
                hintText: 'e.g. Jane Smith Enterprises',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter a customer or business name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Phone Number + Contact Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    'Phone Number *',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: _pickContact,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.contacts_outlined,
                          size: 16,
                          color: AppColors.buttonColor,
                        ),
                        const SizedBox(width: 4),
                        const AppText(
                          'Pick Contact',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _phoneController,
                hintText: 'e.g. +1-555-0177',
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter customer phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Physical Address
              const AppText(
                'Physical Address *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _addressController,
                hintText: 'e.g. 789 Pine Ave, Brooklyn, NY 11201',
                textInputAction: TextInputAction.done,
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter customer address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Branch Selection (If branches exist)
              if (branches.isNotEmpty) ...[
                const AppText(
                  'Store Branch',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: _selectedBranchId,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      hint: const AppText(
                        'Select branch (Optional)',
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      items: [
                        ...branches.map(
                          (b) => DropdownMenuItem<String?>(
                            value: b.id,
                            child: AppText(
                              '${b.name}${b.isMainBranch ? ' (Main)' : ''}',
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() => _selectedBranchId = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ] else
                const SizedBox(height: 8),

              // Save Button
              AppButton(
                title: isEditing ? 'Update Customer' : 'Save Customer',
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
