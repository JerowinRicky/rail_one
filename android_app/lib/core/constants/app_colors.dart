import 'package:flutter/material.dart';

/// RailOne Official Application Color Palette
/// Derived from Indian Railways visual identity & reference APK assets.
class AppColors {
  // Primary Indian Railways Colors
  static const Color primaryBlue = Color(0xFF0D47A1);      // Deep Indian Railway Blue
  static const Color primaryBlueDark = Color(0xFF0A367B);  // App bar & status bar
  static const Color primaryBlueLight = Color(0xFF1976D2); // Hover & active states
  static const Color secondarySky = Color(0xFF0288D1);     // Accent actions & links
  static const Color accentGold = Color(0xFFF59E0B);       // R-Wallet & Tatkal badges
  static const Color accentGoldDark = Color(0xFFD97706);

  // Surface & Neutral Colors
  static const Color background = Color(0xFFF8FAFC);       // Scaffold off-white
  static const Color surface = Color(0xFFFFFFFF);          // Card white
  static const Color cardBorder = Color(0xFFE2E8F0);       // Light border grey
  static const Color divider = Color(0xFFEEF2F6);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);      // Primary heading text
  static const Color textSecondary = Color(0xFF64748B);    // Subtitles & timestamps
  static const Color textMuted = Color(0xFF94A3B8);        // Placeholders & hints
  static const Color textWhite = Color(0xFFFFFFFF);

  // Functional Status Colors
  static const Color successGreen = Color(0xFF16A34A);     // Confirmed (CNF) & Paperless
  static const Color successGreenLight = Color(0xFFDCFCE7);
  static const Color warningOrange = Color(0xFFEA580C);    // Waitlist (WL) & Delays
  static const Color warningOrangeLight = Color(0xFFFFEDD5);
  static const Color dangerRed = Color(0xFFDC2626);        // Cancelled tickets & errors
  static const Color dangerRedLight = Color(0xFFFEE2E2);
  static const Color infoBlue = Color(0xFF2563EB);         // RAC (Reservation Against Cancellation)
  static const Color infoBlueLight = Color(0xFFDBEAFE);

  // Train Coach Color Coding
  static const Color coach1A = Color(0xFF7C3AED); // Purple
  static const Color coach2A = Color(0xFFDC2626); // Red
  static const Color coach3A = Color(0xFF2563EB); // Blue
  static const Color coachSL = Color(0xFF059669); // Green
  static const Color coachGen = Color(0xFFD97706);// Amber

  // R-Wallet Gradients
  static const LinearGradient walletGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E3A8A), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
