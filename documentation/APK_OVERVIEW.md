# Phase 1: APK Inspection & Identification Overview

## 1. Executive Summary

This document provides the foundational inspection, identification, and technical assessment of the reference Android APK (`One.apk`). 

- **Application Name (Brand):** RailOne (Internal codename: **Aikyam**)
- **Developer / Organization:** Centre for Railway Information Systems (CRIS) / Ministry of Railways, Government of India
- **Package Name:** `org.cris.aikyam`
- **Application Framework:** **Flutter** (Dart) with native Android (Java/Kotlin) wrapper plugins, Akamai Bot Manager anti-tamper security, and SQLCipher encrypted local database.
- **APK Format & Type:** Google Play Base Split APK (`requiredSplitTypes="base__abi,base__density"`) derived from an Android App Bundle (AAB).
- **Inspection Tooling:** REA MCP Server (`inspect_apk_signature`, `identify_flutter_build`), Python AXML binary parser, DEX binary analyzer, and Flutter asset extraction.

---

## 2. APK Metadata

| Field | Value | Evidence / Notes |
| :--- | :--- | :--- |
| **File Name** | `One.apk` | Located at `E:\ricky_workspace\s\REA_one\original_app\One.apk` |
| **File Size** | `40,072,882 bytes` (~38.22 MB) | 1,415 total zip archive entries |
| **Package Name** | `org.cris.aikyam` | Decoded from `AndroidManifest.xml` root package |
| **Application Label / Name** | `RailOne` | Asset `assets/icons/railone.png`, string resources `@string/app_name` |
| **Internal Codename** | `Aikyam` | Application class: `com.example.aikyam.AikyamApplication` |
| **Version Code** | `253` | Extracted from `android:versionCode` |
| **Version Name** | `2.1.79` | Extracted from `android:versionName` |
| **Minimum SDK** | `27` (Android 8.1 Oreo) | `android:minSdkVersion="27"` |
| **Target SDK** | `36` (Android 16 / Latest API) | `android:targetSdkVersion="36"` |
| **Compile SDK** | `36` | `android:compileSdkVersion="36"` |
| **Distribution Stamp** | Google Play Distribution APK | `com.android.stamp.source="https://play.google.com/store"`, `STAMP_TYPE_DISTRIBUTION_APK` |
| **Split APK Configuration** | `base__abi,base__density` | `com.android.vending.splits.required="true"`, derived APK ID: 3 |

---

## 3. Cryptographic Signing & Fingerprints

Verified via REA MCP tool `inspect_apk_signature`:

- **Signing Schemes Present:**
  - **APK Signature Scheme v1 (JAR signing):** False
  - **APK Signature Scheme v2:** True (1 signer)
  - **APK Signature Scheme v3:** True (1 signer)
  - **APK Signature Scheme v3.1:** False
- **Certificate SHA-256 (Signer):**
  `8a5f21a01ef7d1202500e143e34bdf4c3166cc43c5595b35f0f463b53f8f0d16`
- **Source Stamp (Google Play):**
  - Present: True
  - Certificate SHA-256: `3257d599a49d2c961a471ca9843f59d341a405884583fc087df4237b733bbd6d`
- **Content Integrity:** Self-consistent (`matches_apk: true`)

---

## 4. Framework Detection & Architectural Evidence

### Confirmed Framework: **Flutter (Dart)**

### Concrete Evidence:
1. **Asset Directory:** Contains complete Flutter framework bundle under `assets/flutter_assets/`:
   - `AssetManifest.bin` (Binary mapping for 1,232 asset entries)
   - `FontManifest.json` (Font definitions: MaterialIcons, FontAwesomeBrands, FontAwesomeRegular, FontAwesomeSolid, CupertinoIcons)
   - `NOTICES.Z` (Compressed open-source attribution bundle covering over 1,400 Dart packages)
   - `assets/fonts/NotoSans-Regular.ttf` & `NotoSans-Bold.ttf`
   - Complete localized UI strings in `assets/flutter_assets/assets/locales/en.json` (English) and `hi.json` (Hindi).
2. **Flutter Android Host Engine:**
   - Decoded manifest declares `io.flutter.embedding.android.NormalTheme` and metadata `flutterEmbedding = 2`.
   - `classes2.dex` defines `io.flutter.plugins.GeneratedPluginRegistrant`.
3. **Third-Party Flutter Packages Identified in Bundle:**
   - **State Management & DI:** `get` (GetX), `get_it`, `rxdart`
   - **Networking:** `dio`, `cookie_jar`, `http_certificate_pinning`
   - **Database & Security:** `sqflite_sqlcipher`, `flutter_secure_storage`, `root_jailbreak_sniffer`, `no_screenshot`, `encrypt`, `pointycastle`
   - **Payments:** `flutter_billdesk_sdk` (complete BillDesk payment gateway integration with SVGs)
   - **Mapping & Location:** `google_maps`, `geolocator`, `geodesy`, `latlong2`, `flutter_polyline_points`
   - **Vision & Scanning:** `mobile_scanner`, `camera`, `google_mlkit_commons`
   - **UI & Animation:** `carousel_slider`, `shimmer`, `skeletonizer`, `flutter_svg`, `slider_button`, `pin_code_fields`, `dots_indicator`, `dotted_border`, `flutter_typeahead`, `page_transition`
   - **Audio & Media:** `flutter_sound`, `audio_session`, `speech_to_text`, `vibration`
   - **Web Integration:** `flutter_inappwebview`

### Split APK Note regarding Native Libraries:
Because this file is a **Google Play Base Split APK**, native compiled binary libraries (`lib/<abi>/libflutter.so`, `libapp.so`, and native C++ security libraries) are separated into architecture-specific split APKs (`split_config.arm64_v8a.apk`). However, the complete UI asset catalogue, localization dictionaries, pre-packaged encrypted database (`UTSDb.sqlite`), station KML polygon coordinates, and DEX bytecode classes are 100% intact and available within this APK.

---

## 5. Android Manifest Component Inspection

Decoded from `AndroidManifest.xml`:

### 5.1 Main Entry Point & Activities
| Component | Class Name | Exported | Intent Filters / Details |
| :--- | :--- | :--- | :--- |
| **Main Launcher** | `com.example.aikyam.MainActivity` | **Yes** (`true`) | `android.intent.action.MAIN`, `android.intent.category.LAUNCHER`<br>Deep Link schemes: `zomato://`, `swiggy://`, `fot://` |
| **Native Webview** | `com.example.aikyam.native.WavesActivity` | No | Config changes: screen orientation, keyboard, screen size |
| **Image Cropper** | `com.yalantis.ucrop.UCropActivity` | No | Screen orientation portrait |
| **In-App Browser** | `com.pichillilorenzo.flutter_inappwebview_android.in_app_browser.InAppBrowserActivity` | No | Full-featured embedded browser |
| **Chrome Custom Tabs** | `...chrome_custom_tabs.ChromeCustomTabsActivity` | No | Standard and SingleInstance launch modes |
| **Trusted Web Activity**| `...chrome_custom_tabs.TrustedWebActivity` | No | Standard and SingleInstance launch modes |
| **URL Launcher** | `io.flutter.plugins.urllauncher.WebViewActivity` | No | Secondary webview handler |
| **Play Core Dialog** | `com.google.android.play.core.common.PlayCoreDialogWrapperActivity` | No | In-app update flow |
| **Security Dialog** | `com.cyberfend.cyfsecurity.CCADialogActivity` | No | Akamai Cyberfend challenge modal (`excludeFromRecents=true`) |
| **Google API** | `com.google.android.gms.common.api.GoogleApiActivity` | No | Play Services auth resolution |

### 5.2 Services
- `com.baseflow.geolocator.GeolocatorLocationService` (`foregroundServiceType="location"`)
- `com.cyberfend.cyfsecurity.CYFWebViewService` (Runs in isolated process `:com.akamai.webview.process`)
- `klo.yui.bnm.LoggingService` & `klo.yui.bnm.IsolatedService`
- `androidx.work.impl.background.systemjob.SystemJobService` (`BIND_JOB_SERVICE`)
- `com.google.firebase.messaging.FirebaseMessagingService` (`com.google.firebase.MESSAGING_EVENT`)
- `com.google.firebase.components.ComponentDiscoveryService`
- `com.google.android.datatransport.runtime.backends.TransportBackendDiscovery`
- `com.google.android.datatransport.runtime.scheduling.jobscheduling.JobInfoSchedulerService`
- `androidx.room.MultiInstanceInvalidationService`

### 5.3 Broadcast Receivers
- `com.cyberfend.cyfsecurity.CYFWebViewBroadCastReceiver` (`action="com.akamai.webview.data"`)
- `com.pichillilorenzo.flutter_inappwebview_android.chrome_custom_tabs.ActionBroadcastReceiver`
- `com.google.firebase.iid.FirebaseInstanceIdReceiver` (`com.google.android.c2dm.intent.RECEIVE`)
- `com.google.android.datatransport.runtime.scheduling.jobscheduling.AlarmManagerSchedulerBroadcastReceiver`
- `androidx.profileinstaller.ProfileInstallReceiver` (`INSTALL_PROFILE`, `SKIP_FILE`, `SAVE_PROFILE`, `BENCHMARK_OPERATION`)
- `androidx.work.impl.diagnostics.DiagnosticsReceiver`

### 5.4 Content Providers
- `io.flutter.plugins.imagepicker.ImagePickerFileProvider` (`org.cris.aikyam.flutter.image_provider`)
- `com.cyberfend.cyfsecurity.CYFWebViewInitProvider` (`org.cris.aikyam.akamai.webviewinit`)
- `com.cyberfend.cyfsecurity.SoLibraryInitProvider` (`org.cris.aikyam.sdkinitprovider`)
- `com.google.firebase.provider.FirebaseInitProvider` (`org.cris.aikyam.firebaseinitprovider`)
- `androidx.startup.InitializationProvider` (`org.cris.aikyam.androidx-startup`)

### 5.5 Declared Permissions
- **Network & Connectivity:** `INTERNET`, `ACCESS_NETWORK_STATE`, `ACCESS_WIFI_STATE`, `BLUETOOTH`
- **Location:** `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`
- **Camera & Hardware:** `CAMERA` (`android.hardware.camera`, `android.hardware.camera.autofocus`), `RECORD_AUDIO`, `MODIFY_AUDIO_SETTINGS`, `CAPTURE_AUDIO_OUTPUT`, `VIBRATE`, `WAKE_LOCK`
- **Biometrics:** `USE_BIOMETRIC`, `USE_FINGERPRINT`
- **Device & Phone:** `READ_PHONE_STATE`
- **Notifications & Background:** `POST_NOTIFICATIONS`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_SHORT_SERVICE`, `RECEIVE_BOOT_COMPLETED`, `HIDE_OVERLAY_WINDOWS`
- **Storage:** `READ_EXTERNAL_STORAGE` (maxSdk 32), `WRITE_EXTERNAL_STORAGE` (maxSdk 28)
- **Play Services / Cloud Messaging:** `com.google.android.c2dm.permission.RECEIVE`, `BIND_GET_INSTALL_REFERRER_SERVICE`
- **Custom App Permission:** `org.cris.aikyam.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` (`protectionLevel="signature"`)

### 5.6 Inter-App Queries & Deep Link Schemes
Declared in `<queries>`:
- **Speech Recognition:** `android.speech.RecognitionService`
- **Maps:** `com.google.android.apps.maps`
- **UPI Payment Apps:**
  - `upi://` URI scheme
  - Google Pay (`com.google.android.apps.nbu.paisa.user`)
  - Paytm (`net.one97.paytm`)
  - PhonePe (`com.phonepe.app`)
  - BHIM (`in.org.npci.upiapp`)
- **Food Delivery Integrations:**
  - `zomato://`
  - `swiggy://`
  - `fot://` (Food on Track / IRCTC eCatering)
- **Play Store:** `com.android.vending`

---

## 6. Security & Anti-Reverse Engineering Findings

1. **Akamai Bot Manager & Cyberfend Protection:**
   - Packages: `com.akamai.botman`, `com.cyberfend.cyfsecurity`
   - Purpose: Detects automated environments, headless browsers, emulators, and API tampering.
   - Separate isolated process: `:com.akamai.webview.process`.
2. **Root & Jailbreak Detection:**
   - Package: `com.emrys.rjsniffer.rjsniffer`
   - App zygote preload: `android:zygotePreloadName="com.emrys.rjsniffer.rjsniffer.AppZygotePreload"`
   - Uses low-level system checks to block rooted devices.
3. **Obfuscation (R8 / ProGuard):**
   - High degree of dictionary and alpha obfuscation across native Java classes (e.g. `kdea01cf`, `cl4z8p06`, `F2CSobyS`).
4. **Local Database Encryption:**
   - `assets/flutter_assets/assets/sqlitedb/UTSDb.sqlite` is encrypted using SQLCipher (`net.zetetic.database.sqlcipher`).
5. **Screen Security:**
   - Implements `no_screenshot` package and `HIDE_OVERLAY_WINDOWS` permission to prevent screen mirroring and overlay tapjacking attacks.

---

## 7. Status of Analysis Prerequisites & Dependencies

| Tool / Dependency | Status | Notes & Remediation |
| :--- | :--- | :--- |
| **Java Runtime** | **Installed** | Located at `C:\Program Files\Common Files\Oracle\Java\javapath\java.exe` |
| **Python Runtime** | **Installed** | Python 3.13.12 64-bit available and active |
| **REA MCP Server** | **Active** | Successfully ran `inspect_apk_signature` and `identify_flutter_build` |
| **JADX MCP Headless** | **Missing** | REA requires `REA_JADX_MCP_JAR` pointing to `jadx-headless-mcp 0.7.1.jar`. Java bytecode decompilation via JADX MCP is currently offline until this JAR is supplied. |
| **Apktool / aapt** | **Not in PATH** | Binary XML and DEX parsing were performed using custom Python scripts. |

---

## 8. Conclusion & Next Phase Recommendation

Phase 1 (APK Inspection and Identification) is **100% complete**. We have extracted full metadata, confirmed the Flutter architecture, decoded the complete Android manifest, cataloged all activities/services/receivers/permissions, and identified the security framework and third-party dependencies.

**Recommended Next Step:**
Proceed to **PHASE 2: REVERSE ENGINEERING USING REA & RESOURCE MAPPING**. We will systematically extract and catalog the technical architecture, resource inventory (over 300 UI icons and SVGs, fonts, locale dictionaries), API endpoints, and component models.

