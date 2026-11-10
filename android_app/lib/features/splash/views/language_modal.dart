import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class LanguageSelectModal extends StatefulWidget {
  const LanguageSelectModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const LanguageSelectModal(),
    );
  }

  @override
  State<LanguageSelectModal> createState() => _LanguageSelectModalState();
}

class _LanguageSelectModalState extends State<LanguageSelectModal> {
  String selectedLocale = Get.locale?.languageCode ?? 'en';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'selectLanguage'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildLanguageTile(
            title: 'English',
            subtitle: 'Default',
            code: 'en',
          ),
          const SizedBox(height: 10),
          _buildLanguageTile(
            title: 'हिंदी',
            subtitle: 'Hindi',
            code: 'hi',
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (selectedLocale == 'hi') {
                  Get.updateLocale(const Locale('hi', 'IN'));
                } else {
                  Get.updateLocale(const Locale('en', 'US'));
                }
                Navigator.pop(context);
              },
              child: const Text('Continue / आगे बढ़ें'),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({
    required String title,
    required String subtitle,
    required String code,
  }) {
    final isSelected = selectedLocale == code;
    return InkWell(
      onTap: () {
        setState(() {
          selectedLocale = code;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withOpacity(0.06) : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.radio_button_off,
              color: isSelected ? AppColors.primaryBlue : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
