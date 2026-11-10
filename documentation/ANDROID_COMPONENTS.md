# Android Components & Manifest Specification

## 1. Overview

This document provides a comprehensive component-by-component analysis of the Android host infrastructure declared in `AndroidManifest.xml` and implemented in the reference APK `One.apk` (`org.cris.aikyam`).

---

## 2. Application Component Definition

```xml
<application
    android:name="com.example.aikyam.AikyamApplication"
    android:label="@string/app_name"
    android:icon="@mipmap/ic_launcher"
    android:taskAffinity="com.example.aikyam.AikyamApplication"
    android:allowBackup="false"
    android:extractNativeLibs="false"
    android:usesCleartextTraffic="false"
    android:appComponentFactory="androidx.core.app.CoreComponentFactory"
    android:zygotePreloadName="com.emrys.rjsniffer.rjsniffer.AppZygotePreload"
    android:requestLegacyExternalStorage="true">
```

### Key Security Posture Attributes:
- **`allowBackup="false"`:** Disables `adb backup`, protecting local encrypted tokens and the SQLite database from physical extraction.
- **`usesCleartextTraffic="false"`:** Forces strict TLS/HTTPS network communication, blocking cleartext HTTP leaks.
- **`zygotePreloadName`:** Preloads `AppZygotePreload` to execute anti-root and environment validation before application initialization.

---

## 3. Activities Inventory

| Activity Class | Theme | Exported | Launch Mode | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **`com.example.aikyam.MainActivity`** | `@style/NormalTheme` | **`true`** | `singleTop` | Primary application window hosting the Flutter UI runtime, Flutter platform channels, and deep link entry point. |
| **`com.example.aikyam.native.WavesActivity`** | `@style/Theme.AppCompat.Light.NoActionBar` | `false` | `standard` | Dedicated native WebView interface for secure third-party railway web flows and external forms. |
| **`com.yalantis.ucrop.UCropActivity`** | `@style/Theme.AppCompat.Light.NoActionBar` | `false` | `standard` | Native image cropping activity for Rail Madad grievance proof attachments. Fixed portrait orientation. |
| **`com.pichillilorenzo.flutter_inappwebview_android.in_app_browser.InAppBrowserActivity`** | `@style/Theme.AppCompat.Light.NoActionBar` | `false` | `standard` | Embedded Chromium browser with navigation controls for external web links. |
| **`com.pichillilorenzo.flutter_inappwebview_android.chrome_custom_tabs.ChromeCustomTabsActivity`** | `@style/Theme.AppCompat.Translucent` | `false` | `standard` | In-app Chrome Custom Tabs provider for railway portal SSO. |
| **`com.pichillilorenzo.flutter_inappwebview_android.chrome_custom_tabs.ChromeCustomTabsActivitySingleInstance`** | `@style/Theme.AppCompat.Translucent` | `false` | `singleInstance` | Single-instance variant for OAuth/SSO redirects. |
| **`io.flutter.plugins.urllauncher.WebViewActivity`** | `@android:style/Theme.NoTitleBar` | `false` | `standard` | Fallback URL launcher activity. |
| **`com.google.android.play.core.common.PlayCoreDialogWrapperActivity`** | `@style/Theme.PlayCore.Dialog` | `false` | `standard` | Modal wrapper for Google Play in-app updates and reviews. |
| **`com.cyberfend.cyfsecurity.CCADialogActivity`** | `@style/Theme.AppCompat.Dialog` | `false` | `standard` | Akamai Cyberfend Bot challenge verification modal (`excludeFromRecents="true"`). |
| **`com.google.android.gms.common.api.GoogleApiActivity`** | `@android:style/Theme.Translucent.NoTitleBar` | `false` | `standard` | Google Play Services connection and account resolution activity. |

---

## 4. Services Inventory

| Service Class | Exported | Process | Permission | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **`com.baseflow.geolocator.GeolocatorLocationService`** | `false` | Main | — | Foreground service with `foregroundServiceType="location"` for high-precision GPS tracking during UTS ticket booking. |
| **`com.cyberfend.cyfsecurity.CYFWebViewService`** | `false` | `:com.akamai.webview.process` | — | Background service evaluating device telemetry, behavioral biometric touch patterns, and bot analysis. |
| **`klo.yui.bnm.LoggingService`** | `false` | Main | — | Obfuscated diagnostic logging service. |
| **`klo.yui.bnm.IsolatedService`** | `false` | Isolated | — | Isolated sandboxed service for cryptographic verification. |
| **`androidx.work.impl.background.systemjob.SystemJobService`** | `false` | Main | `android.permission.BIND_JOB_SERVICE` | WorkManager job scheduler for offline ticket sync and periodic cleanup. |
| **`com.google.firebase.messaging.FirebaseMessagingService`** | `false` | Main | — | Receives FCM push notifications for PNR status changes, train delay alerts, and ticket confirmations. |
| **`com.google.android.datatransport.runtime.scheduling.jobscheduling.JobInfoSchedulerService`** | `false` | Main | `android.permission.BIND_JOB_SERVICE` | Google DataTransport analytics scheduler. |
| **`androidx.room.MultiInstanceInvalidationService`** | `false` | Main | — | SQLite cross-process database invalidation coordinator. |

---

## 5. Broadcast Receivers

| Receiver Class | Exported | Permission | Actions Filtered |
| :--- | :--- | :--- | :--- |
| **`com.cyberfend.cyfsecurity.CYFWebViewBroadCastReceiver`** | `false` | — | `com.akamai.webview.data` |
| **`com.pichillilorenzo.flutter_inappwebview_android.chrome_custom_tabs.ActionBroadcastReceiver`** | `false` | — | Custom tab action bar button clicks |
| **`com.google.firebase.iid.FirebaseInstanceIdReceiver`** | `true` | `com.google.android.c2dm.permission.SEND` | `com.google.android.c2dm.intent.RECEIVE` |
| **`com.google.android.datatransport.runtime.scheduling.jobscheduling.AlarmManagerSchedulerBroadcastReceiver`** | `false` | — | AlarmManager triggered telemetry upload |
| **`androidx.profileinstaller.ProfileInstallReceiver`** | `false` | `android.permission.DUMP` | `androidx.profileinstaller.action.INSTALL_PROFILE` |
| **`androidx.work.impl.diagnostics.DiagnosticsReceiver`** | `false` | `android.permission.DUMP` | `androidx.work.diagnostics.REQUEST_DIAGNOSTICS` |

---

## 6. Content Providers

| Provider Class | Authority | Exported | GrantUriPermissions |
| :--- | :--- | :--- | :--- |
| **`io.flutter.plugins.imagepicker.ImagePickerFileProvider`** | `org.cris.aikyam.flutter.image_provider` | `false` | `true` |
| **`dev.fluttercommunity.plus.share.ShareFileProvider`** | `org.cris.aikyam.flutter.share_provider` | `false` | `true` |
| **`net.nfet.flutter.printing.PrintFileProvider`** | `org.cris.aikyam.flutter.printing` | `false` | `true` |
| **`com.cyberfend.cyfsecurity.CYFWebViewInitProvider`** | `org.cris.aikyam.akamai.webviewinit` | `false` | `false` |
| **`com.cyberfend.cyfsecurity.SoLibraryInitProvider`** | `org.cris.aikyam.sdkinitprovider` | `false` | `false` |
| **`com.google.firebase.provider.FirebaseInitProvider`** | `org.cris.aikyam.firebaseinitprovider` | `false` | `false` |
| **`androidx.startup.InitializationProvider`** | `org.cris.aikyam.androidx-startup` | `false` | `false` |

---

## 7. Permissions Architecture

### 7.1 Dangerous (Runtime) Permissions
- `ACCESS_FINE_LOCATION` & `ACCESS_COARSE_LOCATION`: Required for station geofencing and paperless UTS ticketing.
- `CAMERA`: Required for QR code ticket scanning and Rail Madad proof attachment.
- `RECORD_AUDIO`: Voice input for station speech-to-text search.
- `READ_PHONE_STATE`: Telephony state binding for SIM-based ticketing verification (TelSDK).
- `POST_NOTIFICATIONS`: Android 13+ push notification permissions.
- `READ_EXTERNAL_STORAGE` (maxSdk 32) & `WRITE_EXTERNAL_STORAGE` (maxSdk 28).

### 7.2 Normal & Hardware Feature Permissions
- `INTERNET`, `ACCESS_NETWORK_STATE`, `ACCESS_WIFI_STATE`, `BLUETOOTH`
- `VIBRATE`, `WAKE_LOCK`, `MODIFY_AUDIO_SETTINGS`
- `USE_BIOMETRIC`, `USE_FINGERPRINT`
- `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_SHORT_SERVICE`
- `RECEIVE_BOOT_COMPLETED`
- `HIDE_OVERLAY_WINDOWS` (Prevents overlay tapjacking attacks)

### 7.3 Custom App Signature Permission
- Declared: `org.cris.aikyam.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` (`protectionLevel="signature"`)
- Restricts internal broadcasts exclusively to components signed with the same CRIS release key.

---

## 8. Deep Links & Inter-App Queries

### Handled Deep Links (in `MainActivity`)
- `zomato://`
- `swiggy://`
- `fot://` (Food on Track / IRCTC)

### Explicit Inter-App Queries (`<queries>`)
- **Speech Recognition:** `android.speech.RecognitionService`
- **Mapping:** `com.google.android.apps.maps`
- **UPI Payment Ecosystem:**
  - `upi://` URI scheme
  - Google Pay (`com.google.android.apps.nbu.paisa.user`)
  - Paytm (`net.one97.paytm`)
  - PhonePe (`com.phonepe.app`)
  - BHIM (`in.org.npci.upiapp`)
- **Custom Tabs:** `android.support.customtabs.action.CustomTabsService`
- **Play Store:** `com.android.vending`

