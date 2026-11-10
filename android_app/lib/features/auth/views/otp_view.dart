import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/auth_controller.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String currentText = "";
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('verifyOTP'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'enterOTP'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '+91 ${authCtrl.mobileController.text.isNotEmpty ? authCtrl.mobileController.text : "9876543210"}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'change'.tr,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              // Pin Code Input Fields
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 48,
                  fieldWidth: 42,
                  activeFillColor: AppColors.surface,
                  inactiveFillColor: AppColors.surface,
                  selectedFillColor: AppColors.surface,
                  activeColor: AppColors.primaryBlue,
                  inactiveColor: AppColors.cardBorder,
                  selectedColor: AppColors.primaryBlue,
                ),
                enableActiveFill: true,
                controller: textEditingController,
                onCompleted: (v) {
                  currentText = v;
                },
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: currentText.length == 6
                    ? () async {
                        final success = await authCtrl.verifyOtp(currentText);
                        if (success) {
                          Get.offAllNamed('/home');
                        }
                      }
                    : null,
                child: Text('verifyOTP'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
