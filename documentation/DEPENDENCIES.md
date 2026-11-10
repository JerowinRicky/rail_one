# Dependency Inventory & Technical Mapping

## 1. Executive Summary

This document catalogs all software libraries, frameworks, SDKs, and third-party dependencies identified through static decompilation, DEX string analysis, binary asset inspection, and the decompressed `NOTICES.Z` bundle from the reference APK (`One.apk`).

---

## 2. Flutter / Dart Dependency Catalog

Extracted from `assets/flutter_assets/NOTICES.Z` (decompressed 1.64 MB) and `AssetManifest.bin`:

### 2.1 State Management & Architecture
| Package | Version / Source | Purpose in Reference App |
| :--- | :--- | :--- |
| **`get` (GetX)** | Pub.dev | Reactive state management (`Obx`), dependency injection (`Get.put`), routing (`Get.toNamed`), and snackbars/dialogs |
| **`get_it`** | Pub.dev | Service locator for registering singletons (`ApiService`, `DatabaseService`, `AuthService`) |
| **`rxdart`** | Pub.dev | Reactive streams, debounce operators on search inputs |
| **`equatable`** | Pub.dev | Value equality comparisons for state objects and entities |

### 2.2 Networking & API Client
| Package | Purpose in Reference App |
| :--- | :--- |
| **`dio`** | Advanced HTTP client supporting interceptors, request cancelation, base URLs, and timeout controls |
| **`cookie_jar`** | Cookie management and session persistence across HTTP requests |
| **`http_certificate_pinning`** | Enforces SSL certificate pinning against bundled CRIS certificates (`root_uts.pem`, `inter_uts.pem`) |
| **`connectivity_plus`** | Monitors device network connection state changes (WiFi, Cellular, None) |
| **`internet_connection_checker_plus`** | Verifies true Internet reachability beyond socket connectivity |

### 2.3 Storage, Database & Cryptography
| Package | Purpose in Reference App |
| :--- | :--- |
| **`sqflite_sqlcipher`** | Encrypted SQLite storage for the 7.1 MB pre-loaded `UTSDb.sqlite` |
| **`flutter_secure_storage`** | Keychain / Android Keystore encrypted storage for auth tokens and user IDs |
| **`encrypt` / `pointycastle` / `cryptography`** | Cryptographic primitives (AES-256, RSA, HMAC-SHA256) for token creation and payload protection |
| **`shared_preferences`** | Key-value store for app settings, language preference (`en`/`hi`), and recent station searches |

### 2.4 User Interface, Animation & Styling
| Package | Purpose in Reference App |
| :--- | :--- |
| **`flutter_svg`** | High-performance vector rendering for train coaches, station icons, and action buttons |
| **`carousel_slider`** | Banner carousel on the main dashboard (`carousel_home_image.png`, railway advisories) |
| **`dots_indicator`** | Page indicators for the hero banner carousel and onboarding screens |
| **`slider_button`** | "Slide to Login" and "Slide to Sign Up" swipe verification component |
| **`pin_code_fields` / `pin_input_text_field`** | 6-digit OTP entry field with automatic focus progression and countdown |
| **`shimmer` / `skeletonizer`** | Skeleton loading placeholders for train search lists and live station lists |
| **`flutter_typeahead`** | Search station autocomplete dropdown with instant search results |
| **`dotted_border` / `dotted_line`** | Dotted ticket tear lines and coupon styling on railway e-tickets |
| **`badges`** | Notification and wallet balance badge counter overlays |
| **`flutter_advanced_switch`** | Custom toggle switches for settings (e.g. Hindi/English, Biometrics) |
| **`blinking_text`** | Animated blinking indicator for "Live" train status and urgent updates |
| **`page_transition` / `spring_animation`** | Smooth modal and screen transitions |
| **`intl_phone_field`** | Indian mobile number input with `+91` country code selector |

### 2.5 Hardware, Location & Vision
| Package | Purpose in Reference App |
| :--- | :--- |
| **`geolocator` / `geodesy` / `latlong2`** | High-accuracy GPS geolocation and distance calculation for station geofencing |
| **`google_maps` / `flutter_polyline_points`**| Station mapping and train track route visual rendering |
| **`mobile_scanner` / `camera`** | QR code scanner for station counter ticketing and ML Kit barcode recognition |
| **`google_mlkit_commons`** | Machine learning vision utilities |
| **`speech_to_text`** | Voice-assisted station and train search input |
| **`vibration`** | Haptic feedback on button clicks, slider completion, and error states |
| **`screen_brightness`** | Screen brightness boost when displaying barcode/QR for ticket checking |

### 2.6 Security & Anti-Tamper
| Package | Purpose in Reference App |
| :--- | :--- |
| **`root_jailbreak_sniffer`** | Integrity checks against Magisk, SuperSU, and unlocked bootloaders |
| **`no_screenshot`** | Disables screenshot taking and screen recording during active ticket inspection |

### 2.7 Documents, Web & Media
| Package | Purpose in Reference App |
| :--- | :--- |
| **`flutter_inappwebview`** | Embedded browser for Rail Connect SSO, Web Claim, and external railway portals |
| **`flutter_pdfview` / `pdfx`** | PDF rendering of Electronic Reservation Slips (ERS) and grievance acknowledgments |
| **`printing`** | Direct Bluetooth/WiFi receipt and ticket printing |
| **`share_plus`** | Native share intent for sharing PNR status and train arrival times |
| **`flutter_sound` / `audio_session`** | Audio playback for interactive voice alerts and accessibility |

### 2.8 Telemetry, Analytics & Notifications
| Package | Purpose in Reference App |
| :--- | :--- |
| **`firebase_core` / `firebase_analytics`** | Core Firebase initialization and user journey analytics |
| **`firebase_crashlytics`** | Real-time crash and ANR diagnostic reporting |
| **`firebase_performance`** | Network request latency and trace profiling |
| **`matomo_tracker`** | Self-hosted analytics for government/enterprise privacy compliance |
| **`flutter_local_notifications`** | Scheduled notifications for train arrival alerts and booking reminders |
| **`workmanager`** | Periodic background task scheduler for sync and push notifications |

---

## 3. Native Android Host Libraries

Identified from decoded `classes.dex`, `classes2.dex`, `classes3.dex`, and `AndroidManifest.xml`:

| Category | Native Library / Component | Identification Evidence |
| :--- | :--- | :--- |
| **AndroidX Jetpack** | Core KTX, AppCompat, Fragment, Lifecycle, ConstraintLayout | `androidx.core.app.CoreComponentFactory`, `androidx.lifecycle.*` |
| **Architecture** | WorkManager, Startup Runtime | `androidx.startup.InitializationProvider`, `SystemJobService` |
| **Security** | Android Security Crypto, Biometric | `androidx.security.crypto`, `androidx.biometric.BiometricPrompt` |
| **Database Engine** | SQLCipher Native SQLite | `net.zetetic.database.sqlcipher`, `SQLiteDatabase` |
| **Anti-Bot / Shield** | Akamai Bot Manager & Cyberfend | `com.cyberfend.cyfsecurity.*`, `com.akamai.botman` |
| **Device Integrity** | AppZygote Root Sniffer | `com.emrys.rjsniffer.rjsniffer.AppZygotePreload` |
| **Payment SDK** | Flutter BillDesk Payment SDK | `packages/flutter_billdesk_sdk`, `dev.fluttercommunity` |
| **Google Play** | Play Services Maps, Location, Auth, Review, In-App Update | `com.google.android.gms.*`, `com.google.android.play.core` |
| **Image Cropper** | Yalantis UCrop Native Activity | `com.yalantis.ucrop.UCropActivity` |

---

## 4. Recreation Dependency Architecture

For our clean-room recreation in modern Flutter / Kotlin, we will employ clean, up-to-date versions of these foundational packages:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management & DI
  get: ^4.6.6
  get_it: ^7.7.0
  
  # Networking
  dio: ^5.7.0
  connectivity_plus: ^6.1.0
  
  # Storage & Security
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.3.3
  sqflite: ^2.4.1
  
  # UI & Design System
  flutter_svg: ^2.0.16
  carousel_slider: ^5.0.0
  dots_indicator: ^3.0.0
  shimmer: ^3.0.0
  pin_code_fields: ^8.0.1
  slider_button: ^2.1.0
  intl_phone_field: ^3.2.0
  flutter_typeahead: ^5.2.0
  badges: ^3.1.2
  font_awesome_flutter: ^10.8.0
  cupertino_icons: ^1.0.8
  
  # Location & Maps
  geolocator: ^13.0.2
  latlong2: ^0.9.1
  
  # Barcode & Media
  qr_flutter: ^4.1.0
  mobile_scanner: ^6.0.2
  pdf: ^3.11.1
  printing: ^5.13.3
```

