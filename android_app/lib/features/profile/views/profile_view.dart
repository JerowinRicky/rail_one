import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCtrl = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile & Security'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 36, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Passenger Name', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('+91 98765 43210', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('user@railone.gov.in', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Aadhaar Verification Card
            Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: const Icon(Icons.verified_user, color: AppColors.successGreen),
                title: const Text('Aadhaar KYC Verification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text('Linked: Up to 24 tickets / month enabled', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                trailing: const Icon(Icons.check_circle, color: AppColors.successGreen),
              ),
            ),
            const SizedBox(height: 14),
            // Settings List Card
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  Obx(() => SwitchListTile(
                        title: const Text('Biometric Login (Fingerprint/Face ID)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        subtitle: const Text('Fast access without typing password', style: TextStyle(fontSize: 12)),
                        value: authCtrl.isBiometricsEnabled.value,
                        activeColor: AppColors.primaryBlue,
                        onChanged: (val) {
                          authCtrl.isBiometricsEnabled.value = val;
                          Get.snackbar('Biometrics', val ? 'Biometric authentication activated' : 'Biometric login disabled');
                        },
                      )),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Change Language', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: Text(Get.locale?.languageCode == 'hi' ? 'हिंदी (Hindi)' : 'English', style: const TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      if (Get.locale?.languageCode == 'hi') {
                        Get.updateLocale(const Locale('en', 'US'));
                      } else {
                        Get.updateLocale(const Locale('hi', 'IN'));
                      }
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Change Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.dangerRed,
                  side: const BorderSide(color: AppColors.dangerRed),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Logout from Account', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Confirm Logout',
                    middleText: 'Are you sure you want to log out of your RailOne account?',
                    textConfirm: 'Logout',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    buttonColor: AppColors.dangerRed,
                    onConfirm: () {
                      Get.back();
                      authCtrl.logout();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text('RailOne Version 2.1.79 (Build 253)\nCentre for Railway Information Systems (CRIS)', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}

