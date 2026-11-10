import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Dynamic Bilingual Localization Engine (English & Hindi)
/// Loads directly from the original APK's en.json and hi.json locale files.
class AppTranslations extends Translations {
  static Map<String, String> _en = {};
  static Map<String, String> _hi = {};

  static Future<void> init() async {
    try {
      final enString = await rootBundle.loadString('assets/locales/en.json');
      final Map<String, dynamic> enJson = json.decode(enString);
      _en = enJson.map((k, v) => MapEntry(k, v.toString()));

      final hiString = await rootBundle.loadString('assets/locales/hi.json');
      final Map<String, dynamic> hiJson = json.decode(hiString);
      _hi = hiJson.map((k, v) => MapEntry(k, v.toString()));
    } catch (e) {
      // Fallback defaults if assets are loading asynchronously
      _en = {'app_name': 'RailOne', 'logIn': 'Login', 'search': 'Search'};
      _hi = {'app_name': 'रेलवन', 'logIn': 'लॉग इन करें', 'search': 'खोजें'};
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _en,
        'hi_IN': _hi,
      };
}
