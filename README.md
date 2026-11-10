# RailOne Application Reverse Engineering & Faithful Recreation

**Reference APK:** `original_app/One.apk` (Package: `org.cris.aikyam`, Version: 2.1.79, Build 253)  
**Original Entity:** Centre for Railway Information Systems (CRIS), Ministry of Railways, Government of India  
**Recreation Platform:** Modern Android (Flutter 3.x / Dart + Clean Layered Architecture)

---

## 1. Project Overview

This repository contains the complete reverse engineering analysis, technical specifications, and recreated source code for the **RailOne** Indian Railways Super App. Using evidence-based static analysis, DEX string extraction, and asset decompilation, the new application reproduces the reference application's visual aesthetics, multi-tier navigation, security posture, and railway operational workflows.

---

## 2. Directory Structure

```
REA_one/
|-- original_app/
|   |-- One.apk                     # Untouched reference APK
|
|-- documentation/
|   |-- APK_OVERVIEW.md             # Complete metadata, signatures & manifest analysis
|   |-- TECHNICAL_ARCHITECTURE.md   # Layered system architecture & security posture
|   |-- API_ANALYSIS.md             # Detailed endpoint specifications & payloads
|   |-- DEPENDENCIES.md             # Flutter & native Android dependencies catalog
|   |-- ANDROID_COMPONENTS.md       # Activities, Services, Receivers & Permissions
|   |-- RESOURCE_INVENTORY.md       # Visual asset catalog (307 assets, KMLs, fonts)
|   |-- SCREEN_INVENTORY.md         # 20 accessible screens with 19-point parameters
|   |-- USER_FLOWS.md               # 14 end-to-end user journeys & Mermaid flowcharts
|   |-- FEATURE_MATRIX.md           # 38 discrete features & Requirements Traceability Matrix
|   |-- TECH_STACK_DECISION.md      # Technology comparison & formal architecture decision
|
|-- screenshots/
|   |-- original/                   # Reference screenshots
|   |-- recreated/                  # Recreated screen screenshots
|   |-- comparison/                 # Side-by-side comparison captures
|
|-- android_app/                    # Complete Recreated Source Code
|   |-- android/                    # Android host project & AndroidManifest.xml
|   |-- assets/                     # 623 extracted assets (icons, SVGs, KMLs, locales)
|   |-- lib/                        # Modular Clean Layered Architecture
|   |   |-- core/                   # Theme, colors, localization, security
|   |   |-- data/                   # Models, repositories, mock API service
|   |   |-- features/               # Auth, Home, Search, NTES, UTS, Wallet, Madad
|   |   |-- main.dart               # App entry point & named routing
|   |-- pubspec.yaml                # Flutter project configuration
|
|-- DEVELOPMENT_PROGRESS.md         # Milestone status & audit log
|-- README.md                       # Master project guide
```

---

## 3. Implemented Modules & Screens

1. **Identity & Security:**
   - Splash Screen with integrity checks
   - Language Selector Modal (English & हिंदी)
   - User Registration with live 5-rule password complexity checklist
   - 6-digit SMS/Email OTP verification with auto-advance
   - Login with "Slide to Login" gesture and Biometric unlock (Fingerprint / Face ID)
2. **Dashboard & Services:**
   - R-Wallet gradient card with real-time balance and 3% cashback bonus
   - Hero Train Search card with 180° animated station swap
   - Promotional Banner Carousel (`carousel_slider` + `dots_indicator`)
   - Quick Inquiries ("InAction") grid
   - 8-Service Catalog grid with View All / View Less toggle
3. **Train Search & NTES Live Operations:**
   - Real-time debounced Station Autocomplete (~8,500 stations)
   - Train Results with Class Availability Chips (1A, 2A, 3A, SL) and live fare calculation
   - "Spot Your Train" vertical GPS progress timeline with platform numbers and delay indicators
   - Interactive Train Rake Coach Position scroller (Engine to Guard Van) with berth maps
   - 10-digit PNR Status enquiry with Chart Preparation indicator
4. **UTS Unreserved Ticketing:**
   - Paperless Journey Ticket booking with GPS Geofencing (validating distance < 5 km and outside track KML boundaries)
   - Platform visitor pass booking with 2-hour countdown
   - High-security Digital Ticket inspection screen featuring an animated anti-tamper watermark clock and optical QR code
5. **R-Wallet & Payments:**
   - Stored-value R-Wallet top-up with 3% bonus incentive
   - BillDesk checkout modal supporting UPI app intents, Cards, and NetBanking
   - 90-day transaction ledger
6. **Rail Madad Grievance Redressal:**
   - Incident complaint lodging (Train & Station modes) with photo attachment
   - Live 4-stage resolution tracking stepper with 3-tier satisfaction feedback

---

## 4. How to Build & Run

### Prerequisites
- Flutter SDK 3.x (`>= 3.0.0`)
- Android SDK (API Level 36, Min SDK 27)
- Java Development Kit (JDK 17)

### Execution Steps
```bash
cd android_app

# 1. Fetch dependencies
flutter pub get

# 2. Run on connected Android device or emulator
flutter run

# 3. Generate Installable Debug APK
flutter build apk --debug

# 4. Generate Production Release APK
flutter build apk --release
```
The output APK will be generated at:
`android_app/build/app/outputs/flutter-apk/app-release.apk`

