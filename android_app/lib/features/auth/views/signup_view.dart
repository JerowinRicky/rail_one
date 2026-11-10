import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/auth_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('createAccount'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: authCtrl.fullNameController,
                decoration: InputDecoration(
                  labelText: 'fullName'.tr,
                  hintText: 'Enter full name',
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.primaryBlue),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: authCtrl.mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'mobile'.tr,
                  hintText: 'Enter 10-digit mobile number',
                  prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primaryBlue),
                  prefixText: '+91  ',
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: authCtrl.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'email'.tr,
                  hintText: 'Enter email ID',
                  prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primaryBlue),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: authCtrl.passwordController,
                obscureText: true,
                onChanged: authCtrl.validatePassword,
                decoration: InputDecoration(
                  labelText: 'password'.tr,
                  hintText: 'Create strong password',
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryBlue),
                ),
              ),
              const SizedBox(height: 16),
              // Live Password Complexity Checklist
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Requirements:'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    _buildRuleItem('characterMinimum'.tr, authCtrl.hasMinLength),
                    _buildRuleItem('lowerCaseCharacter'.tr, authCtrl.hasLowercase),
                    _buildRuleItem('upperCaseCharacter'.tr, authCtrl.hasUppercase),
                    _buildRuleItem('number'.tr, authCtrl.hasNumber),
                    _buildRuleItem('specialCharacter'.tr, authCtrl.hasSpecialChar),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Slide to Sign Up Slider
              Obx(() => Opacity(
                    opacity: authCtrl.isPasswordValid ? 1.0 : 0.45,
                    child: IgnorePointer(
                      ignoring: !authCtrl.isPasswordValid,
                      child: SliderButton(
                        action: () async {
                          Get.toNamed('/verify-otp');
                          return true;
                        },
                        label: Text(
                          'slider'.tr,
                          style: const TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.textWhite,
                        ),
                        width: double.infinity,
                        radius: 10,
                        buttonColor: AppColors.primaryBlue,
                        backgroundColor: AppColors.primaryBlue.withOpacity(0.12),
                        shimmer: authCtrl.isPasswordValid,
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'alreadyHaveAccount'.tr,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'signIn'.tr,
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem(String text, RxBool condition) {
    return Obx(() {
      final isValid = condition.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        child: Row(
          children: [
            Icon(
              isValid ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 16,
              color: isValid ? AppColors.successGreen : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isValid ? AppColors.successGreen : AppColors.textSecondary,
                fontWeight: isValid ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
    });
  }
}
