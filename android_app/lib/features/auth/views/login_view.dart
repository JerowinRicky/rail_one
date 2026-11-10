import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Get.offAllNamed('/home'),
            child: Text(
              'Skip'.tr,
              style: const TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.railOneLogo,
                  height: 90,
                  errorBuilder: (ctx, err, stack) => const Icon(
                    Icons.train,
                    size: 80,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'logIn'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Sign in with your IRCTC / RailOne Account'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              // User ID Field
              TextField(
                controller: authCtrl.userIdController,
                decoration: InputDecoration(
                  labelText: 'userID'.tr,
                  hintText: 'Enter User ID or Mobile',
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.primaryBlue),
                ),
              ),
              const SizedBox(height: 16),
              // Password Field
              Obx(() => TextField(
                    controller: authCtrl.passwordController,
                    obscureText: !authCtrl.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'password'.tr,
                      hintText: 'Enter Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primaryBlue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authCtrl.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: authCtrl.togglePasswordVisibility,
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'forgotPassword'.tr,
                    style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Slide to Login Slider Button
              Center(
                child: SliderButton(
                  action: () async {
                    await authCtrl.login();
                    Get.offAllNamed('/home');
                    return true;
                  },
                  label: Text(
                    'sliderLogin'.tr,
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
                  shimmer: true,
                ),
              ),
              const SizedBox(height: 24),
              // Biometric & Alternative Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 42,
                    icon: Image.asset(
                      AppAssets.fingerprintIcon,
                      errorBuilder: (ctx, err, stack) => const Icon(Icons.fingerprint, size: 40, color: AppColors.primaryBlue),
                    ),
                    onPressed: () async {
                      await authCtrl.login();
                      Get.offAllNamed('/home');
                    },
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    iconSize: 42,
                    icon: Image.asset(
                      AppAssets.faceIdLogo,
                      errorBuilder: (ctx, err, stack) => const Icon(Icons.face_unlock_outlined, size: 40, color: AppColors.primaryBlue),
                    ),
                    onPressed: () async {
                      await authCtrl.login();
                      Get.offAllNamed('/home');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'warningForAccount'.tr,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/signup'),
                    child: Text(
                      'signUp'.tr,
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
}
