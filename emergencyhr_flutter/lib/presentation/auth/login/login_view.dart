import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      // Brand Logo & Title Header
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade50,
                            border: Border.all(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Image.asset(
                            AppAssets.bglowLogoPng,
                            width: 64,
                            height: 64,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: AppText(
                          'BGlow Creation',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: AppText(
                          'Sign in to manage your fashion orders & invoices',
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          alignment: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Card Container for Inputs
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email Field
                            const AppText(
                              'Email Address',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(height: 8),
                            AppCustomTextField(
                              textEditingController: model.emailController,
                              hintText: 'e.g. user@example.com',
                              textInputType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                size: 20,
                                color: Colors.grey,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email address';
                                }
                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),

                            // Password Field
                            const AppText(
                              'Password',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(height: 8),
                            AppCustomTextField(
                              textEditingController: model.passwordController,
                              hintText: 'Enter your password',
                              obscureText: model.obscurePassword,
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              onSubmitted: (_) => model.login(),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Forgot Password Row
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  _showForgotPasswordInfo(context);
                                },
                                child: const AppText(
                                  'Forgot password?',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Sign In Button
                            AppButton(
                              title: 'Sign In',
                              loading: model.isBusy,
                              color: AppColors.primaryColor,
                              textColor: Colors.white,
                              radius: 12,
                              height: 52,
                              onPressed: model.isBusy ? null : model.login,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Sign Up Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            "Don't have an account? ",
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                          GestureDetector(
                            onTap: model.navigateToSignUp,
                            child: const AppText(
                              'Sign Up',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showForgotPasswordInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.lock_reset, color: AppColors.primaryColor),
            SizedBox(width: 8),
            AppText(
              'Reset Password',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        content: const AppText(
          'Please contact your business administrator or support at support@bglow.com to request a password reset.',
          fontSize: 13,
          color: Colors.black87,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const AppText('OK', color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
