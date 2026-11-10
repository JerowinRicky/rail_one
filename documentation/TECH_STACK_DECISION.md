# Technology Stack Decision & Architecture Blueprint

## 1. Executive Summary

This document evaluates candidate technologies for the recreation of the reference Android application **RailOne** (`org.cris.aikyam`) and provides a definitive recommendation.

- **Reference Application Framework:** **Flutter (Dart)** with native Android wrappers (Akamai Bot Manager, SQLCipher, TelSDK).
- **Recommended Recreation Technology:** **Option B: Flutter 3.x (Dart) + Clean Layered Architecture (GetX)**.
- **Decision Rationale:** Maximum visual fidelity, direct 1:1 asset and localization dictionary reuse, native widget parity (swipe slider, coach formation scroller, live watermarks), and superior maintenance velocity.

---

## 2. Comprehensive Technology Evaluation

### Candidate Comparison Matrix

| Evaluation Criteria | Option A: Native Kotlin + Jetpack Compose | Option B: Flutter 3.x (Dart) [RECOMMENDED] | Option C: React Native (TypeScript) |
| :--- | :--- | :--- | :--- |
| **Framework Match with Reference** | Low (Architectural departure) | **Exact (100% Match)** | Low (Bridge / JS departure) |
| **Asset & Icon Reusability** | Low (Requires converting 300+ SVGs to VectorDrawables) | **Immediate (Direct drop-in for all 307 SVGs, GIFs, TTFs)** | Medium (Requires SVG conversion or third-party wrappers) |
| **Localization Compatibility** | Medium (Requires converting `en.json`/`hi.json` to `strings.xml`)| **Immediate (Direct JSON localization dictionary mapping)** | High (JSON supported via i18next) |
| **Complex Custom UI Fidelity** | Medium (Custom Canvas required for train rake scroller) | **Exact (Pixel-identical widgets: `slider_button`, `carousel_slider`)** | Medium (Complex gesture and scroll sync) |
| **Local Database & SQLCipher** | High (Room + SQLCipher) | **High (`sqflite_sqlcipher` matching reference DB structure)** | Medium (React Native SQLCipher bridges) |
| **Geofencing & Polygon Logic** | High (Android Geofencing API) | **High (`geolocator` + `geodesy` Point-in-Polygon KML parsing)** | Medium (Background geofencing bridge complexities) |
| **Anti-Screen Capture (`FLAG_SECURE`)**| High (`FLAG_SECURE` in Activity) | **High (`no_screenshot` / Platform Channel `FLAG_SECURE`)** | High (`react-native-flag-secure`) |
| **Performance & Frame Rate** | High (AOT Native JVM/ART) | **High (AOT Compiled Native ARM64/V8a Engine)** | Medium (Hermes JS Engine + Bridge overhead) |
| **Long-Term Maintainability** | High for Android specialists | **Exceptional (Single clean codebase, clean separation)** | Medium (Fragile npm native dependencies) |

---

## 3. In-Depth Analysis of Evaluated Options

### Option A: Kotlin + Jetpack Compose
- **Strengths:** Jetpack Compose is the gold standard for modern first-party native Android development. It provides direct, zero-overhead access to Android 15/16 platform APIs, Keystore cryptography, and hardware biometrics.
- **Weaknesses:**
  1. The reference application was built in Flutter. Its entire layout hierarchy, sizing metrics, asset tree (1,232 assets), and styling conventions are Dart/Flutter constructs.
  2. Translating 300+ SVG files and complex custom widgets (such as the horizontal coach position train rake and the swipe-to-login track) into Compose would require custom Canvas work and XML restructuring, risking visual drift from the reference.
  3. Bilingual localization would have to be manually flattened into Android `strings.xml`, losing the dynamic key-value flexibility of the original `en.json` and `hi.json`.

### Option B: Flutter 3.x (Dart) — [RECOMMENDED]
- **Strengths:**
  1. **Pixel-Perfect Visual Fidelity:** Directly reproduces every screen in the reference application with identical styling, margin/padding ratios, typography (Noto Sans), and interaction physics.
  2. **100% Asset Reuse:** All 307 graphics (train coach layouts `1A.svg`, `2A.svg`, `3A.svg`, `Gen.svg`, `PC.svg`, station amenity badges, animated GIFs `Wallet.gif`, `cashback.gif`, `Confetti.gif`, brand crests) and the 7 geographic geofencing KML files can be used immediately without lossy conversion.
  3. **Direct Architecture Parity:** Matches the reference app's reactive state management pattern (GetX controllers and reactive observables `RxBool`, `RxString`).
  4. **Target Platform Support:** Compiles directly into high-performance native Android ARM64/ARMv7 APKs targeting Android 16 (API Level 36) with minimum SDK 27 (Android 8.1 Oreo).

### Option C: React Native
- **Strengths:** Widely adopted JavaScript/TypeScript ecosystem with fast web developer onboarding.
- **Weaknesses:**
  1. Introduces an unnecessary JavaScript runtime (Hermes) and native bridge layer, which deviates from the reference APK's compiled binary footprint.
  2. Bridge latency can introduce stutter into the high-security animated ticket watermark and real-time GPS geofence calculations.
  3. Higher fragility with native Android SDK upgrades and dependency conflicts.

---

## 4. Proposed Application Architecture & Directory Blueprint

To ensure clean code separation, scalability, and testability, the recreated application will follow a **Clean Layered Feature Architecture**:

```
android_app/
|-- android/                         # Native Android host project (Gradle, Manifest, Keystore)
|   |-- app/
|   |   |-- src/main/
|   |   |   |-- AndroidManifest.xml  # Security flags (FLAG_SECURE, permissions, deep links)
|   |   |   |-- kotlin/.../MainActivity.kt # Platform channels
|   |   |   |-- res/                 # Launch icons and themes
|-- assets/
|   |-- certificates/                # Pinned CRIS SSL certificates
|   |-- fonts/                       # NotoSans-Regular.ttf, NotoSans-Bold.ttf
|   |-- icons/                       # Brand and animated GIF icons
|   |-- images/                      # Train coaches, amenities, cards, KML polygons
|   |-- locales/                     # en.json (English), hi.json (Hindi)
|   |-- sqlitedb/                    # Local SQLite stations & suburban fare database
|-- lib/
|   |-- core/                        # Cross-cutting foundational services
|   |   |-- constants/               # Colors, dimensions, asset paths, API endpoints
|   |   |-- localization/            # Bilingual translation loader (en/hi)
|   |   |-- location/                # GPS geofencing & KML point-in-polygon engine
|   |   |-- network/                 # Dio client, interceptors, error handling
|   |   |-- security/                # Biometrics, secure storage, screen capture blocker
|   |   |-- theme/                   # Railway Blue theme, typography, component styles
|   |-- data/                        # Repositories, models & mock adapters
|   |   |-- models/                  # Train, Station, PNR, Ticket, Wallet, Complaint models
|   |   |-- repositories/            # Data repository interfaces and implementations
|   |   |-- services/                # Local SQLite service, mock API service
|   |-- features/                    # Feature modules (View, Controller, Widgets)
|   |   |-- auth/                    # Login, Register, OTP verification
|   |   |-- home/                    # Dashboard, carousel, quick inquiries
|   |   |-- search/                  # Station autocomplete, date/quota selection
|   |   |-- trains/                  # Train search results, availability chips
|   |   |-- ntes/                    # Spot your train, coach position, live station
|   |   |-- pnr/                     # 10-digit PNR status, charting banner
|   |   |-- uts/                     # Suburban paperless journey & platform tickets
|   |   |-- tickets/                 # Active digital ticket viewer with animated clock
|   |   |-- wallet/                  # R-Wallet balance, 3% cashback, BillDesk checkout
|   |   |-- madad/                   # Rail Madad complaint lodging & tracking stepper
|   |   |-- station/                 # Station amenities directory & platform maps
|   |   |-- profile/                 # User settings, Aadhaar KYC, biometrics toggle
|   |-- main.dart                    # Application entry point & service initialization
|-- pubspec.yaml                     # Dependencies and asset declarations
```

---

## 5. Formal Technology Decision & Approval Request

- **Selected Language:** Dart 3.x
- **Selected Framework:** Flutter 3.x
- **State Management:** GetX (Reactive `Obx` + Controller DI)
- **Local Database:** SQLite (`sqflite`) for station directory and suburban routes
- **Secure Persistence:** `flutter_secure_storage` (Android Keystore backed)
- **HTTP Client:** `dio` (with modular `MockApiService` fallback)
- **Target OS:** Android (Min SDK 27, Target SDK 36)

> [!IMPORTANT]
> **Milestone Approval:**
> We are now pausing to request your approval of this Technology Stack Decision before creating the project structure and commencing Phase 6 (Project Setup) and Phase 7 (UI Development).

