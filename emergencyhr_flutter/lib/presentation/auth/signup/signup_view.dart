import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'signup_viewmodel.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.primaryColor,
              ),
              onPressed: model.previousStep,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Create Business Account',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                AppText(
                  'Step ${model.currentStep + 1} of 3: ${_stepTitle(model.currentStep)}',
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Step Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: List.generate(3, (index) {
                      final isActive = index <= model.currentStep;
                      return Expanded(
                        child: Container(
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.buttonColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Multi-step PageView
                Expanded(
                  child: PageView(
                    controller: model.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildStep0Owner(context, model),
                      _buildStep1Business(context, model),
                      _buildStep2Bank(context, model),
                    ],
                  ),
                ),

                // Bottom Action Buttons
                _buildBottomActions(context, model),
              ],
            ),
          ),
        );
      },
    );
  }

  String _stepTitle(int step) {
    switch (step) {
      case 0:
        return 'Owner Info';
      case 1:
        return 'Business & Branches';
      case 2:
        return 'Bank Settlement';
      default:
        return '';
    }
  }

  // STEP 0: Owner Credentials
  Widget _buildStep0Owner(BuildContext context, SignUpViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Form(
        key: model.step0FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              'Account Owner Details',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 4),
            AppText(
              'Enter your personal credentials to manage your store account.',
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 20),

            // Full Name
            const AppText(
              'Full Name *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              textEditingController: model.fullNameController,
              hintText: 'e.g. Sunday Olaifa',
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.person_outline,
                size: 20,
                color: Colors.grey,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email Address
            const AppText(
              'Email Address *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              textEditingController: model.emailController,
              hintText: 'e.g. sunday@bglow.com',
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.none,
              prefixIcon: const Icon(
                Icons.email_outlined,
                size: 20,
                color: Colors.grey,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your email address';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(val.trim())) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Phone Number
            const AppText(
              'Phone Number *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              textEditingController: model.phoneController,
              hintText: 'e.g. +2348034567890',
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.phone_outlined,
                size: 20,
                color: Colors.grey,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password
            const AppText(
              'Password *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              textEditingController: model.passwordController,
              hintText: 'Minimum 6 characters',
              obscureText: model.obscurePassword,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 20,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  model.obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: model.togglePasswordVisibility,
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter a password';
                }
                if (val.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Confirm Password
            const AppText(
              'Confirm Password *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              textEditingController: model.confirmPasswordController,
              hintText: 'Re-enter your password',
              obscureText: model.obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              maxLines: 1,
              prefixIcon: const Icon(
                Icons.lock_outline,
                size: 20,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  model.obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: model.toggleConfirmPasswordVisibility,
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please confirm your password';
                }
                if (val != model.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // STEP 1: Business & Branches
  Widget _buildStep1Business(BuildContext context, SignUpViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Form(
        key: model.step1FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              'Business & Branch Locations',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 4),
            AppText(
              'Provide your business name and store locations for receipts & invoices.',
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 20),

            // Business Name
            const AppText(
              'Business / Trade Name *',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppCustomTextField(
              textEditingController: model.businessNameController,
              hintText: 'e.g. BGlow Creation',
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.storefront_outlined,
                size: 20,
                color: Colors.grey,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your business name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Main Branch Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: AppColors.buttonColor,
                      ),
                      const SizedBox(width: 6),
                      const AppText(
                        'Main Branch / Head Office *',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const AppText(
                          'Primary',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Main Branch Name
                  const AppText(
                    'Branch Label',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 4),
                  AppCustomTextField(
                    textEditingController: model.mainBranchNameController,
                    hintText: 'e.g. Head Office & Main Store',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),

                  // Main Branch Address
                  const AppText(
                    'Physical Address *',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 4),
                  AppCustomTextField(
                    textEditingController: model.mainBranchAddressController,
                    hintText: 'e.g. Shop 6, Fasogbon Factory, Abegunde, Ibadan',
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter the branch address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Main Branch Phone
                  const AppText(
                    'Branch Phone Contact',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 4),
                  AppCustomTextField(
                    textEditingController: model.mainBranchPhoneController,
                    hintText: 'e.g. +2347067376069',
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Additional Branches List
            if (model.additionalBranches.isNotEmpty) ...[
              ...model.additionalBranches.asMap().entries.map((entry) {
                final index = entry.key;
                final branch = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.store,
                            size: 18,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 6),
                          AppText(
                            'Branch #${index + 2}',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () => model.removeBranch(index),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const AppText(
                        'Branch Name',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 4),
                      AppCustomTextField(
                        textEditingController: branch.nameController,
                        hintText: 'e.g. Sagamu Branch',
                      ),
                      const SizedBox(height: 12),
                      const AppText(
                        'Address',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 4),
                      AppCustomTextField(
                        textEditingController: branch.addressController,
                        hintText: 'e.g. No 26, Surulere Makun, Sagamu',
                      ),
                      const SizedBox(height: 12),
                      const AppText(
                        'Phone Contact',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 4),
                      AppCustomTextField(
                        textEditingController: branch.phoneController,
                        hintText: 'e.g. +2347067376069',
                        textInputType: TextInputType.phone,
                      ),
                    ],
                  ),
                );
              }),
            ],

            // Add Branch Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onPressed: model.addBranch,
              icon: const Icon(Icons.add, size: 18),
              label: const AppText(
                'Add Another Branch',
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // STEP 2: Bank Settlement Details
  Widget _buildStep2Bank(BuildContext context, SignUpViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Form(
        key: model.step2FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              'Bank Settlement Details',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 4),
            AppText(
              'This bank account will be automatically displayed on issued customer invoices.',
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 20),

            // Bank Information Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bank Name
                  const AppText(
                    'Bank Name',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 6),
                  AppCustomTextField(
                    textEditingController: model.bankNameController,
                    hintText: 'e.g. Moniepoint, GTBank, Access Bank',
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      Icons.account_balance_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Account Number
                  const AppText(
                    'Account Number',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 6),
                  AppCustomTextField(
                    textEditingController: model.accountNumberController,
                    hintText: 'e.g. 0123456789 (10 digits)',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      Icons.numbers_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Account Name
                  const AppText(
                    'Account Name',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 6),
                  AppCustomTextField(
                    textEditingController: model.accountNameController,
                    hintText: 'e.g. BGlow Creation / Sunday Olaifa',
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(
                      Icons.badge_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tip Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppText(
                      'You can also edit or update your bank settlement details anytime from your Profile settings.',
                      fontSize: 12,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, SignUpViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (model.currentStep > 0) ...[
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: model.isBusy ? null : model.previousStep,
                    child: const AppText(
                      'Back',
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                flex: 2,
                child: AppButton(
                  title: model.currentStep == 2
                      ? 'Complete Registration'
                      : 'Continue',
                  loading: model.isBusy,
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                  radius: 10,
                  height: 48,
                  onPressed: model.isBusy ? null : model.nextStep,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                'Already have an account? ',
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
              GestureDetector(
                onTap: () {
                  navigationService.pop();
                },
                child: const AppText(
                  'Sign In',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttonColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
