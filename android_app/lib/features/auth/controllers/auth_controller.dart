import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final isBiometricsEnabled = false.obs;

  // Password Complexity Validation Flags
  final hasMinLength = false.obs;
  final hasLowercase = false.obs;
  final hasUppercase = false.obs;
  final hasNumber = false.obs;
  final hasSpecialChar = false.obs;

  bool get isPasswordValid =>
      hasMinLength.value &&
      hasLowercase.value &&
      hasUppercase.value &&
      hasNumber.value &&
      hasSpecialChar.value;

  void validatePassword(String value) {
    hasMinLength.value = value.length >= 8;
    hasLowercase.value = value.contains(RegExp(r'[a-z]'));
    hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
    hasNumber.value = value.contains(RegExp(r'[0-9]'));
    hasSpecialChar.value = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<bool> login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    isLoading.value = false;
    isLoggedIn.value = true;
    return true;
  }

  Future<bool> verifyOtp(String otp) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;
    isLoggedIn.value = true;
    return otp.length == 6;
  }

  void logout() {
    isLoggedIn.value = false;
    userIdController.clear();
    passwordController.clear();
    Get.offAllNamed('/login');
  }
}
