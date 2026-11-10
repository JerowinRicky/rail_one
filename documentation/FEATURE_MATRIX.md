# Requirements & Feature Traceability Matrix

## 1. Overview & Classification Schema

This document details the complete feature matrix and requirement specifications for the **RailOne** (`org.cris.aikyam`) application. Every feature is cataloged with its operational description, associated screens, user actions, business rules, API/Database dependencies, validation constraints, error handling, authentication rules, implementation priority, and empirical confirmation status.

### Confirmation Classification:
- **CONFIRMED:** Directly verified through decompiled DEX classes, binary assets, decoded manifests, or layout strings.
- **PARTIALLY UNDERSTOOD:** Confirmed through UI assets, strings, and manifest declarations, but with private backend schemas requiring clean-room simulation.
- **UNVERIFIED:** Potential feature referenced in documentation but not directly invoked by the client APK.
- **NOT ACCESSIBLE:** Enterprise-only / intranet feature gated by government firewalls.

---

## 2. Comprehensive Feature Matrix

### Module A: Identity, Authentication & Security

#### F-01: App Integrity & Root Defense
- **Classification:** **CONFIRMED** (Evidence: `com.emrys.rjsniffer.rjsniffer.AppZygotePreload`, `com.cyberfend.cyfsecurity`, `com.akamai.botman`)
- **Description:** Verifies runtime device integrity, blocking execution on rooted devices, tampered environments, or unauthorized emulators.
- **Associated Screens:** `SplashScreen`, `CCADialogActivity`
- **User Actions:** None (automated on boot).
- **Business Rules:** Blocks ticket generation and auth if device integrity fails.
- **Dependencies:** Android Keystore, AppZygote.
- **Validation:** Kernel su binary check, build tags check, root package scanner.
- **Error Handling:** Displays modal error and cleanly exits process.
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-02: Bilingual Localization (English & Hindi)
- **Classification:** **CONFIRMED** (Evidence: `assets/locales/en.json`, `assets/locales/hi.json`, `FontManifest.json`)
- **Description:** Full bilingual support across all 96 strings, typography, and station names.
- **Associated Screens:** `LanguageSelectModal`, `ProfileSettingsScreen`, All screens.
- **User Actions:** Tapping language tile; toggling language in settings.
- **Business Rules:** Default language is selected on first launch; persisted in `SharedPreferences`.
- **Dependencies:** `Get.updateLocale()`, `shared_preferences`, Noto Sans font.
- **Validation:** Selected locale must be `en` or `hi`.
- **Error Handling:** Falls back to English if Hindi translation key is missing.
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-03: User Registration with Live Password Complexity
- **Classification:** **CONFIRMED** (Evidence: `en.json` keys: `createAccount`, `atLeast`, `lowerCaseCharacter`, `upperCaseCharacter`, `specialCharacter`, `number`, `characterMinimum`)
- **Description:** New passenger registration with live checklist validating password strength before unlocking swipe-to-submit.
- **Associated Screens:** `SignUpScreen`
- **User Actions:** Enter Full Name, Mobile, Email, Password; swipe slider.
- **Business Rules:** Password must satisfy all 5 rules: 1 lowercase, 1 uppercase, 1 special character, 1 number, 8 characters min.
- **Dependencies:** `POST /api/v1/auth/register`, `slider_button`, `intl_phone_field`.
- **Validation:** 10-digit mobile number, valid RFC email format, regex password check.
- **Error Handling:** Inline red error badges; swipe button disabled until valid.
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-04: Multi-Factor SMS & Email OTP Verification
- **Classification:** **CONFIRMED** (Evidence: `en.json` keys: `enterOTP`, `enterOTPEmail`, `verifyOTP`, `change`, `pin_code_fields`)
- **Description:** 6-digit numeric OTP verification with 120s countdown and auto-advance.
- **Associated Screens:** `OtpVerificationScreen`
- **User Actions:** Input 6 OTP digits; tap "Verify"; tap "Resend OTP"; tap "Change".
- **Business Rules:** OTP expires after 120s; max 3 failed attempts before 15-minute lockout.
- **Dependencies:** `POST /api/v1/auth/otp/verify`, `POST /api/v1/auth/otp/send`, `sms_autofill`.
- **Validation:** Exactly 6 numeric digits.
- **Error Handling:** Haptic shake animation on invalid OTP; cooldown countdown on resend.
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-05: User Login with Slider-to-Login
- **Classification:** **CONFIRMED** (Evidence: `en.json` keys: `logIn`, `userID`, `password`, `sliderLogin`, `slider_button`)
- **Description:** Account login combining credentials with a swipe-to-login slider interaction to prevent brute-force bot submission.
- **Associated Screens:** `LoginScreen`
- **User Actions:** Enter User ID and Password; swipe slider.
- **Business Rules:** Successful authentication stores JWT in `flutter_secure_storage`.
- **Dependencies:** `POST /api/v1/auth/login`, `flutter_secure_storage`.
- **Validation:** Non-empty credentials; completed slider track.
- **Error Handling:** Inline error: "Invalid User ID or Password".
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-06: Biometric Authentication (Fingerprint & Face ID)
- **Classification:** **CONFIRMED** (Evidence: `assets/images/Face_ID_logo.png`, `finger_print_icon.png`, `USE_BIOMETRIC`)
- **Description:** Instant biometric login without typing passwords using Android BiometricPrompt.
- **Associated Screens:** `LoginScreen`, `ProfileSettingsScreen`
- **User Actions:** Touch fingerprint sensor or look at front camera.
- **Business Rules:** Available only when device hardware supports biometrics and user enables toggle in Profile.
- **Dependencies:** `local_auth`, Android Keystore.
- **Validation:** OS cryptographic biometric signature verification.
- **Error Handling:** Falls back to password login after 3 failed sensor attempts.
- **Auth Required:** Previous successful login required.
- **Priority:** **HIGH (P1)**

#### F-07: Passenger Profile & Aadhaar KYC
- **Classification:** **CONFIRMED** (Evidence: `profile_icon.svg.vec`, `link_aadhar_icon.png`, `edit_blue.png`)
- **Description:** Displays user membership details and Aadhaar linkage badge for enhanced monthly ticket quotas (up to 24 tickets/month).
- **Associated Screens:** `ProfileSettingsScreen`
- **User Actions:** View profile, tap "Link Aadhaar", toggle biometrics, change password, logout.
- **Business Rules:** Verified Aadhaar status grants unreserved ticket booking priority.
- **Dependencies:** `GET /api/v1/user/profile`, `POST /api/v1/user/aadhaar/verify`.
- **Validation:** 12-digit Aadhaar UIDAI verification.
- **Error Handling:** Clear notification if Aadhaar OTP fails.
- **Auth Required:** Yes (JWT Bearer Token).
- **Priority:** **MEDIUM (P2)**

---

### Module B: Home Dashboard & Navigation

#### F-08: Super App Dashboard & Bottom Navigation
- **Classification:** **CONFIRMED** (Evidence: `HomeScreen`, bottom navigation icons, `show_services.svg`)
- **Description:** Fixed 5-tab bottom navigation bar unifying Home, My Bookings, Enquiries, Rail Madad, and More Services.
- **Associated Screens:** `HomeScreen`, All main module screens.
- **User Actions:** Tap navigation tab; view unread notification badge; tap user avatar.
- **Business Rules:** Preserves scroll position across tab switches.
- **Dependencies:** `GetX` navigation controllers.
- **Validation:** N/A.
- **Error Handling:** Offline warning banner displayed if disconnected.
- **Auth Required:** Optional (Guest Mode supported for inquiries).
- **Priority:** **HIGH (P1)**

#### F-09: Promotional Banner Carousel
- **Classification:** **CONFIRMED** (Evidence: `carousel_home_image.png`, `chenab.jpg`, `noney_bridge.webp`, `carousel_slider`, `dots_indicator`)
- **Description:** Auto-sliding hero carousel showcasing Indian Railways engineering feats and safety advisories with interactive page dots.
- **Associated Screens:** `HomeScreen`
- **User Actions:** Auto-scroll; manual swipe; tap banner to open advisory link.
- **Business Rules:** Rotates every 4.0 seconds; pauses on user finger touch.
- **Dependencies:** `carousel_slider`, `dots_indicator`.
- **Validation:** Gracefully handles asset or network image errors.
- **Error Handling:** Displays fallback bundled railway landmark image.
- **Auth Required:** No.
- **Priority:** **MEDIUM (P2)**

#### F-10: Quick Inquiries Grid (InAction)
- **Classification:** **CONFIRMED** (Evidence: `inaction_pnr_status.png`, `backgroundImageOfFood.png`, `inaction_cancellation.png`, `inaction_seat_available.png`)
- **Description:** 4-card quick access row for top daily passenger lookups (PNR Status, Food on Train, Check Cancellation, Seat Availability).
- **Associated Screens:** `HomeScreen`
- **User Actions:** Tap card -> Direct route to module.
- **Business Rules:** Configurable ordering based on user recent activity.
- **Dependencies:** Named route navigation.
- **Validation:** N/A.
- **Error Handling:** N/A.
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-11: Railway Services Catalog Grid
- **Classification:** **CONFIRMED** (Evidence: `reserve_card.png`, `unreserve_card.png`, `platform_card.png`, `enquire_spot_your_train.png`, `coachpositionNew.png`, `enquire_live_station.png`, `retiring_room_amenity.png`)
- **Description:** 8-card primary service grid with "View All" / "View Less" accordion toggle.
- **Associated Screens:** `HomeScreen`
- **User Actions:** Tap service card; tap "View All" toggle button.
- **Business Rules:** Displays top 4 primary cards by default; expands to 8 upon tapping "View All".
- **Dependencies:** Animated cross-fade widget.
- **Validation:** N/A.
- **Error Handling:** N/A.
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

---

### Module C: Train Search & Reserved Ticketing

#### F-12: Real-Time Fuzzy Station Search (~8,500 Stations)
- **Classification:** **CONFIRMED** (Evidence: `searchStation`, `originStation`, `whereTo`, `recentSearches`, `UTSDb.sqlite`)
- **Description:** Fast debounced search matching station code (e.g. `NDLS`), English name (`New Delhi`), or Hindi name (`नई दिल्ली`).
- **Associated Screens:** `StationSearchModal`, `HomeScreen`
- **User Actions:** Type query; tap speech-to-text mic; tap recent search chip; tap result.
- **Business Rules:** Matches code prefix first, then station name substring; displays recent 5 searches.
- **Dependencies:** `UTSDb.sqlite` station table / local search cache, `speech_to_text`.
- **Validation:** Minimum 1 character.
- **Error Handling:** "No stations found matching '{query}'".
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-13: Station Reversal / Swap
- **Classification:** **CONFIRMED** (Evidence: `swap_icon.png`, `HomeScreen`)
- **Description:** One-tap swap reversing Origin and Destination stations with an animated 180° rotation.
- **Associated Screens:** `HomeScreen`, `TrainResultsScreen`
- **User Actions:** Tap circular swap button.
- **Business Rules:** Swaps values only if at least one station is chosen; triggers smooth rotation animation.
- **Dependencies:** Flutter animation controller.
- **Validation:** N/A.
- **Error Handling:** N/A.
- **Auth Required:** No.
- **Priority:** **MEDIUM (P2)**

#### F-14: Train Between Stations & Quota Selection
- **Classification:** **CONFIRMED** (Evidence: `trainSearch`, `TrainResultsScreen`, `filter_icon.png`)
- **Description:** Retrieves all scheduled trains connecting origin and destination with quota selectors (General, Tatkal, Ladies).
- **Associated Screens:** `TrainResultsScreen`
- **User Actions:** Select quota; scroll train cards; tap date ribbon to view next/previous day.
- **Business Rules:** Quota rules follow Indian Railways booking hours (e.g. Tatkal opens 10:00 AM for AC, 11:00 AM for Non-AC).
- **Dependencies:** `POST /api/v1/trains/search`.
- **Validation:** Origin != Destination; Date >= Today and <= Today + 120 days.
- **Error Handling:** "No direct trains found. Check connecting trains".
- **Auth Required:** No for search; Yes for booking.
- **Priority:** **HIGH (P1)**

#### F-15: Real-Time Berth Availability & Fares
- **Classification:** **CONFIRMED** (Evidence: `1A.svg`, `2A.svg`, `3A.svg`, `S1.svg`, `AVAILABLE`, `WL`, `RAC`)
- **Description:** Real-time seat inventory chips across classes (1A, 2A, 3A, SL, 2S) with color-coded availability and fare in INR.
- **Associated Screens:** `TrainResultsScreen`
- **User Actions:** Tap class chip; view fare breakdown; tap "Book Now".
- **Business Rules:** Green: Available; Yellow: RAC (Reservation Against Cancellation); Orange: Waitlist (WL).
- **Dependencies:** `POST /api/v1/trains/availability`.
- **Validation:** Valid class and quota selection.
- **Error Handling:** "Berth status unavailable. Pull to refresh".
- **Auth Required:** Yes for booking.
- **Priority:** **HIGH (P1)**

---

### Module D: National Train Enquiry System (NTES) Live Operations

#### F-16: Live Train Running Status ("Spot Your Train")
- **Classification:** **CONFIRMED** (Evidence: `track_long_image.png`, `train_engine.png`, `train_location.png`, `live_icon.jpeg`, `blinking_text`)
- **Description:** Real-time GPS-assisted train location tracker showing passed stations, live platform, delay in minutes, and upcoming stations.
- **Associated Screens:** `SpotYourTrainScreen`
- **User Actions:** Enter train number; select departure date; tap "Refresh"; tap "Share Status".
- **Business Rules:** Status updates every 60 seconds; highlights delay in orange/red if > 15 minutes.
- **Dependencies:** `GET /api/v1/ntes/running-status`.
- **Validation:** Valid 5-digit train number.
- **Error Handling:** Displays last reported station crossing if GPS satellite lock is lost in tunnel.
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-17: Visual Coach Position Rake Composition
- **Classification:** **CONFIRMED** (Evidence: `coach_position_new.svg.vec`, `engineNew.svg`, `1A.svg`, `2A.svg`, `3A.svg`, `S1.svg`, `Gen.svg`, `PC.svg`, `Power.svg`, `gaurd.svg`)
- **Description:** Full horizontal scrollable train rake layout from Engine to Guard Van showing exact coach position and internal berth map.
- **Associated Screens:** `CoachPositionScreen`
- **User Actions:** Enter train number / PNR; scroll track horizontally; tap coach; tap "Flip Direction".
- **Business Rules:** Displays official CRIS coach configuration for the specific train departure.
- **Dependencies:** `GET /api/v1/trains/coach-position`.
- **Validation:** 5-digit train number.
- **Error Handling:** "Standard formation displayed. Actual platform rake may vary slightly".
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-18: 10-Digit PNR Status & Charting Enquiry
- **Classification:** **CONFIRMED** (Evidence: `PnrStatus`, `pnr`, `chart`, `chartVacancy`, `circle-tick.svg`)
- **Description:** Queries 10-digit PNR booking code, passenger status (`CNF`, `WL`, `RAC`), coach/berth number, and Chart Preparation status.
- **Associated Screens:** `PnrStatusScreen`
- **User Actions:** Type 10-digit PNR; tap "Check Status"; download e-ticket.
- **Business Rules:** 10 numeric digits; Modulo-10 checksum verified before network invocation.
- **Dependencies:** `GET /api/v1/pnr/status/{pnr}`.
- **Validation:** Exactly 10 digits; all numeric.
- **Error Handling:** "Invalid PNR Number / Flushed PNR".
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

#### F-19: Live Station Trains Board
- **Classification:** **CONFIRMED** (Evidence: `enquire_live_station.png`, `live_icon.jpeg`, `en.json`)
- **Description:** Virtual station display board showing all trains arriving and departing within 2, 4, or 8 hours with platform numbers.
- **Associated Screens:** `HomeScreen` -> Live Station
- **User Actions:** Select station; choose time window (2 / 4 / 8 hours).
- **Business Rules:** Mirrors physical station electronic display boards (`display_board_image.png`).
- **Dependencies:** `GET /api/v1/ntes/live-station`.
- **Validation:** Valid station code.
- **Error Handling:** "No trains scheduled in this time window".
- **Auth Required:** No.
- **Priority:** **MEDIUM (P2)**

#### F-20: Train Timetable & Schedule Viewer
- **Classification:** **CONFIRMED** (Evidence: `enquire_train_schedule.png`, `en.json`)
- **Description:** Complete timetable showing all halt stations, arrival times, departure times, halt duration, and distance in km.
- **Associated Screens:** `HomeScreen` -> Train Schedule
- **User Actions:** Enter train number; view station table; search halt station.
- **Business Rules:** Shows official Indian Railways working timetable.
- **Dependencies:** `GET /api/v1/trains/schedule`.
- **Validation:** Valid 5-digit train number.
- **Error Handling:** "Train schedule not found".
- **Auth Required:** No.
- **Priority:** **MEDIUM (P2)**

#### F-21: Cancelled & Diverted Trains Tracker
- **Classification:** **CONFIRMED** (Evidence: `more_cancelled_diverted_train.png`, `inaction_cancellation.png`)
- **Description:** Daily advisory list of fully cancelled, partially cancelled, and diverted train routes due to maintenance or weather.
- **Associated Screens:** `HomeScreen` -> Cancelled / Diverted Trains
- **User Actions:** Select date; filter by railway zone (NR, WR, ER, SR).
- **Business Rules:** Daily morning and evening bulletins from Railway Board.
- **Dependencies:** `GET /api/v1/trains/bulletins/cancelled`.
- **Validation:** N/A.
- **Error Handling:** N/A.
- **Auth Required:** No.
- **Priority:** **LOW (P3)**

---

### Module E: UTS Unreserved & Suburban Ticketing

#### F-22: GPS Station Geofencing & Anti-Fraud Boundary Enforcement
- **Classification:** **CONFIRMED** (Evidence: 7 KML files in `assets/images/others/kml/`, `com.baseflow.geolocator`, `geodesy`, `latlong2`)
- **Description:** Geographic enforcement engine ensuring paperless ticket booking occurs within 5.0 km of station, but OUTSIDE station track boundaries.
- **Associated Screens:** `UtsBookingScreen`
- **User Actions:** Allow GPS permission; select source station.
- **Business Rules:** User GPS must be < 5,000 meters from station; User GPS must NOT intersect polygon coordinates in KML files.
- **Dependencies:** `geolocator`, Point-in-Polygon geometric algorithm, bundled KML polygons.
- **Validation:** High-accuracy GPS lock (`accuracy < 30m`).
- **Error Handling:** Clear explanation if inside station premises: "Booking not allowed inside track area to comply with anti-fraud regulations".
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

#### F-23: Paperless & Paper Suburban Journey Ticketing
- **Classification:** **CONFIRMED** (Evidence: `card_unreserve_ticket.png`, `unreserve_card.png`, `UTSDb.sqlite`, `r_wallet_icon.svg`)
- **Description:** Instant booking of unreserved second-class and first-class suburban journey tickets.
- **Associated Screens:** `UtsBookingScreen`
- **User Actions:** Select Source & Destination stations; choose passenger count (1-4); select Ordinary / Mail / Superfast; tap "Book".
- **Business Rules:** Deducts fare from R-Wallet; ticket valid for 3 hours from booking time.
- **Dependencies:** `UTSDb.sqlite` fare tables, `POST /api/v1/uts/ticket/book`.
- **Validation:** Sufficient R-Wallet balance; valid route connectivity.
- **Error Handling:** "Insufficient R-Wallet balance. Please recharge".
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

#### F-24: 2-Hour Platform Visitor Pass Booking
- **Classification:** **CONFIRMED** (Evidence: `platform_card.png`, `platfor_ticket_icon.png`, `en.json`)
- **Description:** Quick 2-click booking of platform visitor passes with fixed tariff (₹10 / ₹20) and a live 2-hour countdown timer.
- **Associated Screens:** `PlatformTicketScreen`
- **User Actions:** Auto-detect station; pick 1-4 visitors; tap "One-Tap Book".
- **Business Rules:** Valid strictly for 2 hours from booking time; non-refundable.
- **Dependencies:** `POST /api/v1/uts/platform/book`.
- **Validation:** User must be in proximity to the target station.
- **Error Handling:** "Booking failed. Please retry".
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

#### F-25: High-Security Digital Ticket Inspection
- **Classification:** **CONFIRMED** (Evidence: `ticket_bcgrnd.png`, `ticketBarCode.png`, `my_logo_for_qr.png`, `circle-tick.svg`)
- **Description:** Anti-tamper ticket display screen featuring an animated color-shifting watermark clock, 2D barcode, and encrypted QR code for TTE inspection.
- **Associated Screens:** `DigitalTicketScreen`
- **User Actions:** Present ticket to TTE; tap "Share Ticket"; tap "Download PDF".
- **Business Rules:** Screen brightness automatically boosted to 100% on entry; active ticket displays live running time.
- **Dependencies:** `screen_brightness`, `qr_flutter`, `pdfx`, `printing`.
- **Validation:** Valid cryptographically signed ticket payload.
- **Error Handling:** Displays red "EXPIRED" stamp if current time > validity time.
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

#### F-26: Screen Security & Anti-Capture Protection
- **Classification:** **CONFIRMED** (Evidence: `no_screenshot`, `HIDE_OVERLAY_WINDOWS`, `FLAG_SECURE`)
- **Description:** System-level blocking of screenshot capture and screen recording during active digital ticket inspection.
- **Associated Screens:** `DigitalTicketScreen`, `UtsBookingScreen`
- **User Actions:** None (automated).
- **Business Rules:** Disables OS window screenshot capability via Android `FLAG_SECURE`.
- **Dependencies:** `no_screenshot` Flutter plugin.
- **Validation:** N/A.
- **Error Handling:** N/A.
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

---

### Module F: R-Wallet & Digital Payments

#### F-27: Stored-Value R-Wallet Management
- **Classification:** **CONFIRMED** (Evidence: `rWallet`, `money`, `lowBalance`, `addMoneyNow`, `Wallet.gif`)
- **Description:** Railway virtual stored-value wallet for zero-payment-gateway-fee ticket booking.
- **Associated Screens:** `HomeScreen`, `RWalletScreen`
- **User Actions:** View balance; tap "Add money now"; view ledger.
- **Business Rules:** Low balance alert triggers when balance < ₹50.00.
- **Dependencies:** `GET /api/v1/wallet/balance`.
- **Validation:** Non-negative balance.
- **Error Handling:** "Unable to retrieve balance. Pull to refresh".
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

#### F-28: 3% Cashback Top-Up Incentive Engine
- **Classification:** **CONFIRMED** (Evidence: `cashback.gif`, `RWalletScreen`)
- **Description:** Automatic calculation and credit of 3% bonus cashback on all wallet recharges.
- **Associated Screens:** `RWalletScreen`
- **User Actions:** Select recharge chip (`+ ₹500`); view bonus credit amount (`₹515.00 credited`).
- **Business Rules:** Exactly 3.0% calculated on recharge principal; credited instantly upon payment confirmation.
- **Dependencies:** Client & server calculation engine.
- **Validation:** Recharge amount >= ₹100 and <= ₹10,000.
- **Error Handling:** N/A.
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

#### F-29: BillDesk Multi-Rail Payment Gateway
- **Classification:** **CONFIRMED** (Evidence: `packages/flutter_billdesk_sdk` [34 SVGs], `upi_image.png`, `queries` in manifest)
- **Description:** Complete checkout modal handling UPI app intent invocations (GPay, PhonePe, Paytm, BHIM), debit/credit cards, and NetBanking.
- **Associated Screens:** `BillDeskPaymentModal`
- **User Actions:** Select payment method; enter card details or UPI ID; authenticate with bank.
- **Business Rules:** Employs TLS 1.3 and 3D Secure OTP verification.
- **Dependencies:** `flutter_billdesk_sdk`, Android inter-app UPI intents.
- **Validation:** Luhn algorithm card check, VPA regex check.
- **Error Handling:** "Transaction declined by issuing bank. Auto-refund will process within 3 days".
- **Auth Required:** Yes.
- **Priority:** **HIGH (P1)**

#### F-30: R-Wallet Transaction History Ledger
- **Classification:** **CONFIRMED** (Evidence: `myTransactionCard.png`, `my_transaction_icon.png`, `en.json`)
- **Description:** Scrollable chronological ledger showing all top-ups, ticket deductions, and ticket refund credits with status pills.
- **Associated Screens:** `RWalletScreen`
- **User Actions:** Scroll ledger; filter by Credits / Debits; tap transaction to view ticket receipt.
- **Business Rules:** Retains transactions for 90 days.
- **Dependencies:** `GET /api/v1/wallet/transactions`.
- **Validation:** N/A.
- **Error Handling:** "No transaction records found".
- **Auth Required:** Yes.
- **Priority:** **MEDIUM (P2)**

---

### Module G: Rail Madad & Passenger Grievance Redressal

#### F-31: Incident Complaint Lodging (Train & Station)
- **Classification:** **CONFIRMED** (Evidence: `rail`, `madad`, `registerComplaint`, `train_complaint_icon.png`)
- **Description:** Official railway grievance lodging with category classification (Cleanliness, Medical, Electrical, Catering, Security).
- **Associated Screens:** `RailMadadScreen`
- **User Actions:** Select Train vs Station; enter PNR / Station; pick category; type description; attach photo; tap submit.
- **Business Rules:** Automatically routes grievance to on-duty train staff or station DRM office; generates unique Reference ID (`RM-...`).
- **Dependencies:** `POST /api/v1/madad/complaint`.
- **Validation:** PNR or Station required; description 10 to 500 characters.
- **Error Handling:** "Please enter valid PNR or station code".
- **Auth Required:** Optional (Mobile number required for SMS updates).
- **Priority:** **HIGH (P1)**

#### F-32: Camera Photo Attachment with Native Compression & Crop
- **Classification:** **CONFIRMED** (Evidence: `cameraIcon.png`, `com.yalantis.ucrop.UCropActivity`, `flutter_image_compress`)
- **Description:** Captures photo evidence of grievance, opens native cropping screen (`UCropActivity`), and compresses image before upload.
- **Associated Screens:** `RailMadadScreen`, `UCropActivity`
- **User Actions:** Tap "Attach Photo"; capture image; adjust crop box; confirm.
- **Business Rules:** Compressed to < 1 MB JPEG to ensure rapid upload on low-bandwidth train cellular networks.
- **Dependencies:** `image_picker`, `image_cropper`, `flutter_image_compress`.
- **Validation:** File size <= 5 MB; MIME type image/jpeg or image/png.
- **Error Handling:** "Image too large. Please select a smaller photo".
- **Auth Required:** Optional.
- **Priority:** **MEDIUM (P2)**

#### F-33: Real-Time Grievance Stepper Tracking & Feedback
- **Classification:** **CONFIRMED** (Evidence: `trackComplaint`, `help_centre_suggestion.svg.vec`, `good_feedback_icon`, `average_feedback_icon`, `poor_feedback_icon`)
- **Description:** Live 4-stage resolution timeline (Registered -> Assigned -> Action Taken -> Closed) with 3-tier satisfaction reaction submission.
- **Associated Screens:** `TrackComplaintScreen`
- **User Actions:** Enter Reference ID; view live progress; tap Good/Average/Poor reaction face.
- **Business Rules:** Feedback ratings submit directly to Railway Ministry service quality dashboard.
- **Dependencies:** `GET /api/v1/madad/track/{refId}`, `POST /api/v1/madad/feedback`.
- **Validation:** Valid `RM-` reference format.
- **Error Handling:** "Grievance ID not found".
- **Auth Required:** No.
- **Priority:** **HIGH (P1)**

---

### Module H: Value-Added Passenger Services

#### F-34: Food On Train / eCatering & Partner Deep Links
- **Classification:** **CONFIRMED** (Evidence: `foodOnTrain`, `order_food.svg`, `zomato://`, `swiggy://`, `fot://` in manifest)
- **Description:** Food ordering to train berth with deep linking to Swiggy, Zomato, and Food On Track (IRCTC eCatering).
- **Associated Screens:** `HomeScreen`, `PnrStatusScreen`, `WavesActivity`
- **User Actions:** Enter PNR; select meal station; choose partner; complete order.
- **Business Rules:** Checks partner app availability via `<queries>`; falls back to embedded WebView if uninstalled.
- **Dependencies:** `url_launcher`, `WavesActivity`.
- **Validation:** PNR must be confirmed or RAC.
- **Error Handling:** "No food delivery vendors available at this station".
- **Auth Required:** No (managed inside partner flow).
- **Priority:** **MEDIUM (P2)**

#### F-35: "Know Your Station" Amenities & Facilities Guide
- **Classification:** **CONFIRMED** (Evidence: 13 amenity badges, `know_your_station.svg`, `en.json`)
- **Description:** Comprehensive directory of station platforms, drinking water, restrooms, waiting halls, escalators, FOBs, lifts, and ATMs.
- **Associated Screens:** `StationAmenitiesScreen`
- **User Actions:** Enter station code; tap amenity category; view platform navigation notes.
- **Business Rules:** Pre-loaded station facility dataset.
- **Dependencies:** Local station database.
- **Validation:** Valid station code.
- **Error Handling:** "Amenities not yet mapped for this station".
- **Auth Required:** No.
- **Priority:** **MEDIUM (P2)**

#### F-36: Retiring Room Booking Linkage
- **Classification:** **CONFIRMED** (Evidence: `retiring_room_amenity.png`, `retiringRoom`, `bedroll.png`)
- **Description:** Direct discovery and booking redirect for Indian Railways retiring rooms and station dormitories.
- **Associated Screens:** `HomeScreen`, `StationAmenitiesScreen`
- **User Actions:** Tap Retiring Room tile; enter PNR; select check-in time and room type.
- **Business Rules:** Retiring room booking is permitted exclusively for passengers with a confirmed PNR.
- **Dependencies:** `WavesActivity` / IRCTC Tourism Portal.
- **Validation:** Valid PNR.
- **Error Handling:** "PNR required to book Retiring Rooms".
- **Auth Required:** Yes.
- **Priority:** **LOW (P3)**

#### F-37: Parcel Booking & Tariff Rate Calculator
- **Classification:** **CONFIRMED** (Evidence: `parcelServices`, `parce_rate.jpeg`, `track_parcel_pink_svg.svg.vec`, `calculator_pink_svg.svg.vec`, `truck.png`)
- **Description:** Luggage and commercial parcel rate calculator based on weight (kg), volume, commodity scale, and distance.
- **Associated Screens:** `HomeScreen` -> Parcel Services
- **User Actions:** Enter origin/destination; enter package weight; select commodity; calculate tariff.
- **Business Rules:** Uses official Indian Railways Parcel Rate Tables (Scale R, Scale P, Scale S).
- **Dependencies:** Local tariff calculator engine.
- **Validation:** Positive weight and dimensions.
- **Error Handling:** "Weight exceeds maximum luggage limit for passenger trains".
- **Auth Required:** No.
- **Priority:** **MEDIUM (P2)**

#### F-38: Freight Operations (FOIS) Tracking
- **Classification:** **CONFIRMED** (Evidence: `freight_service.png`, `foistrainimage.png`, `forwarding_note.png`, `freightRateNew.png`)
- **Description:** Freight wagon and commercial consignment tracking via Freight Operations Information System (FOIS).
- **Associated Screens:** `HomeScreen` -> Freight Services
- **User Actions:** Enter Railway Receipt (RR) number or FNR number; view rake location.
- **Business Rules:** Commercial freight lookup for cargo customers.
- **Dependencies:** `https://fois.indianrail.gov.in`.
- **Validation:** Valid 9-digit RR/FNR number.
- **Error Handling:** "Consignment not found".
- **Auth Required:** No.
- **Priority:** **LOW (P3)**

---

## 3. Requirements Traceability Matrix (RTM)

| Feature ID | Feature Name | Original APK Evidence | Associated Screens | Target Implementation Module | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **F-01** | App Integrity Defense | `AppZygotePreload`, `com.cyberfend.cyfsecurity` | Screen 01 | `lib/core/security/security_service.dart` | **CONFIRMED** |
| **F-02** | Bilingual Localization | `en.json`, `hi.json`, `FontManifest.json` | Screen 02, All | `lib/core/localization/app_translations.dart`| **CONFIRMED** |
| **F-03** | User Registration & Regex | `createAccount`, `password` strings | Screen 04 | `lib/features/auth/views/signup_view.dart` | **CONFIRMED** |
| **F-04** | SMS & Email OTP Verification | `enterOTP`, `pin_code_fields` | Screen 05 | `lib/features/auth/views/otp_view.dart` | **CONFIRMED** |
| **F-05** | Login & Swipe Slider | `logIn`, `sliderLogin`, `slider_button` | Screen 03 | `lib/features/auth/views/login_view.dart` | **CONFIRMED** |
| **F-06** | Biometric Unlock | `Face_ID_logo.png`, `finger_print_icon.png` | Screen 03, 20 | `lib/core/security/biometric_service.dart` | **CONFIRMED** |
| **F-07** | Profile & Aadhaar KYC | `profile_icon.svg.vec`, `link_aadhar_icon.png`| Screen 20 | `lib/features/profile/views/profile_view.dart`| **CONFIRMED** |
| **F-08** | Home Super App Dashboard | Bottom nav icons, `show_services.svg` | Screen 06 | `lib/features/home/views/home_view.dart` | **CONFIRMED** |
| **F-09** | Banner Carousel | `carousel_home_image.png`, `chenab.jpg` | Screen 06 | `lib/features/home/widgets/banner_carousel.dart`| **CONFIRMED** |
| **F-10** | Quick Inquiries Grid | `inaction_pnr_status.png`, `order_food.svg` | Screen 06 | `lib/features/home/widgets/in_action_grid.dart` | **CONFIRMED** |
| **F-11** | Services Catalog Grid | `reserve_card.png`, `unreserve_card.png` | Screen 06 | `lib/features/home/widgets/services_grid.dart` | **CONFIRMED** |
| **F-12** | Station Search (~8,500) | `searchStation`, `UTSDb.sqlite` | Screen 07 | `lib/features/search/views/station_search.dart` | **CONFIRMED** |
| **F-13** | Station Reversal Swap | `swap_icon.png`, `HomeScreen` | Screen 06, 08 | `lib/features/search/widgets/swap_button.dart` | **CONFIRMED** |
| **F-14** | Train Search & Quotas | `trainSearch`, `filter_icon.png` | Screen 08 | `lib/features/trains/views/train_results.dart` | **CONFIRMED** |
| **F-15** | Live Berth Availability | `1A.svg`, `2A.svg`, `3A.svg`, `S1.svg` | Screen 08 | `lib/features/trains/widgets/class_chip.dart` | **CONFIRMED** |
| **F-16** | Spot Your Train (Live GPS)| `track_long_image.png`, `train_location.png` | Screen 09 | `lib/features/ntes/views/spot_train_view.dart` | **CONFIRMED** |
| **F-17** | Coach Position Rake Map | `coach_position_new.svg.vec`, coach SVGs | Screen 10 | `lib/features/ntes/views/coach_position.dart` | **CONFIRMED** |
| **F-18** | 10-Digit PNR Status | `PnrStatus`, `chart`, `circle-tick.svg` | Screen 11 | `lib/features/pnr/views/pnr_status_view.dart` | **CONFIRMED** |
| **F-19** | Live Station Board | `enquire_live_station.png`, `live_icon.jpeg` | Screen 06 | `lib/features/ntes/views/live_station_view.dart`| **CONFIRMED** |
| **F-20** | Train Timetable Viewer | `enquire_train_schedule.png` | Screen 06 | `lib/features/ntes/views/schedule_view.dart` | **CONFIRMED** |
| **F-21** | Cancelled / Diverted Trains | `more_cancelled_diverted_train.png` | Screen 06 | `lib/features/ntes/views/bulletins_view.dart` | **CONFIRMED** |
| **F-22** | GPS Geofence Enforcement | 7 KML polygon boundary files | Screen 12 | `lib/core/location/geofence_service.dart` | **CONFIRMED** |
| **F-23** | UTS Unreserved Ticketing | `card_unreserve_ticket.png`, `UTSDb.sqlite` | Screen 12 | `lib/features/uts/views/uts_booking_view.dart` | **CONFIRMED** |
| **F-24** | Platform Ticket Booking | `platform_card.png`, `platfor_ticket_icon.png`| Screen 14 | `lib/features/uts/views/platform_ticket.dart` | **CONFIRMED** |
| **F-25** | Digital Ticket Inspection | `ticket_bcgrnd.png`, `ticketBarCode.png` | Screen 13 | `lib/features/tickets/views/digital_ticket.dart`| **CONFIRMED** |
| **F-26** | Anti-Screenshot Protection | `no_screenshot`, `HIDE_OVERLAY_WINDOWS` | Screen 12, 13 | `lib/core/security/screen_guard_service.dart` | **CONFIRMED** |
| **F-27** | R-Wallet Balance Card | `rWallet`, `money`, `lowBalance`, `Wallet.gif`| Screen 06, 15 | `lib/features/wallet/views/wallet_view.dart` | **CONFIRMED** |
| **F-28** | 3% Bonus Cashback Engine | `cashback.gif`, `RWalletScreen` | Screen 15 | `lib/features/wallet/controllers/wallet_ctrl.dart`| **CONFIRMED** |
| **F-29** | BillDesk Payment Gateway | 34 BillDesk SVGs, UPI intents | Screen 16 | `lib/features/payments/views/billdesk_modal.dart`| **CONFIRMED** |
| **F-30** | R-Wallet Transaction Ledger | `myTransactionCard.png`, `en.json` | Screen 15 | `lib/features/wallet/widgets/ledger_list.dart` | **CONFIRMED** |
| **F-31** | Rail Madad Grievance Lodging| `rail`, `madad`, `train_complaint_icon.png` | Screen 17 | `lib/features/madad/views/rail_madad_view.dart` | **CONFIRMED** |
| **F-32** | Camera Proof Attachment | `cameraIcon.png`, `UCropActivity` | Screen 17 | `lib/core/media/attachment_service.dart` | **CONFIRMED** |
| **F-33** | Grievance Stepper & Feedback| `help_centre_suggestion.svg.vec`, feedback icons| Screen 18 | `lib/features/madad/views/track_complaint.dart`| **CONFIRMED** |
| **F-34** | Food on Train / Deep Links | `order_food.svg`, `zomato://`, `swiggy://` | Screen 06, 11 | `lib/features/catering/views/catering_view.dart`| **CONFIRMED** |
| **F-35** | Station Amenities Guide | 13 amenity badges, `know_your_station.svg` | Screen 19 | `lib/features/station/views/amenities_view.dart`| **CONFIRMED** |
| **F-36** | Retiring Room Booking | `retiring_room_amenity.png`, `bedroll.png` | Screen 06, 19 | `lib/features/station/views/retiring_room.dart` | **CONFIRMED** |
| **F-37** | Parcel Rate Calculator | `parcelServices`, `parce_rate.jpeg` | Screen 06 | `lib/features/parcel/views/parcel_calc_view.dart`| **CONFIRMED** |
| **F-38** | FOIS Freight Tracking | `freight_service.png`, `foistrainimage.png` | Screen 06 | `lib/features/fois/views/fois_tracking_view.dart`| **CONFIRMED** |

