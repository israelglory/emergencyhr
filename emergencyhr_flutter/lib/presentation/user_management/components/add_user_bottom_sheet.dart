import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';

class AddUserBottomSheet extends StatefulWidget {
  final VoidCallback onSaved;

  const AddUserBottomSheet({super.key, required this.onSaved});

  @override
  State<AddUserBottomSheet> createState() => _AddUserBottomSheetState();
}

class _AddUserBottomSheetState extends State<AddUserBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = 'ROLE_STAFF';
  String? _selectedBranchId;
  bool _obscurePassword = true;
  bool _isLoading = false;

  final List<Map<String, String>> _roleOptions = [
    {
      'role': 'ROLE_ADMIN',
      'label': 'Administrator',
      'desc':
          'Full access to all features, reports, branches, and user management.',
    },
    {
      'role': 'ROLE_STAFF',
      'label': 'Staff Member',
      'desc':
          'Can create invoices & expenses, and view branch financial reports.',
    },
    {
      'role': 'ROLE_SALE_BOY',
      'label': 'Sales Representative',
      'desc':
          'Can create invoices & customers; no access to financial analytics.',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Preselect primary branch if available
    final branches = appGlobals.user?.branches ?? [];
    if (branches.isNotEmpty) {
      final mainBranch = branches.firstWhere(
        (b) => b.isMainBranch,
        orElse: () => branches.first,
      );
      _selectedBranchId = mainBranch.id;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final param = CreateUserParam(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: _selectedRole,
        branchId: _selectedBranchId,
      );

      final res = await userRepo.createUser(param: param);

      if (res.success) {
        snackbarService.success(
          message: res.message?.isNotEmpty == true
              ? res.message!
              : 'User account created successfully!',
        );
        if (mounted) {
          Navigator.pop(context);
          widget.onSaved();
        }
      } else {
        snackbarService.error(
          message: res.message?.isNotEmpty == true
              ? res.message!
              : 'Failed to create user account',
        );
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
    _emailController.dispose();
    _passwordController.dispose();
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

              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    'Create Team Member',
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

              // Full Name
              const AppText(
                'Full Name *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _nameController,
                hintText: 'e.g. Alice Johnson',
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter user full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Email Address
              const AppText(
                'Email Address *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _emailController,
                hintText: 'e.g. alice.johnson@example.com',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter an email address';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(val.trim())) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Temporary Password
              const AppText(
                'Temporary Password *',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              AppCustomTextField(
                textEditingController: _passwordController,
                hintText: 'e.g. TemporaryPass123!',
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: Colors.grey,
                ),
                maxLines: 1,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please provide a temporary password';
                  }
                  if (val.trim().length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Account Role Selection
              const AppText(
                'Account Role *',
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
                  child: DropdownButton<String>(
                    value: _selectedRole,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    items: _roleOptions.map((opt) {
                      return DropdownMenuItem<String>(
                        value: opt['role'],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              opt['label']!,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedRole = val);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Store Branch Selection
              if (branches.isNotEmpty) ...[
                const AppText(
                  'Assigned Store Branch',
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
                const SizedBox(height: 24),
              ] else
                const SizedBox(height: 14),

              // Submit Button
              AppButton(
                title: 'Create Account',
                loading: _isLoading,
                color: AppColors.primaryColor,
                textColor: Colors.white,
                radius: 10,
                height: 48,
                onPressed: _isLoading ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
