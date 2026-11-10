# Screen Inventory & UI Specifications

## 1. Overview

This document presents a comprehensive, screen-by-screen specification of all 20 accessible screens in the **RailOne** (`org.cris.aikyam`) application. Every specification details the layout hierarchy, interactive controls, states (loading, empty, error), typography, colors, and navigation transitions.

---

## 2. Screen Inventory Matrix

| # | Screen Identifier | Screen Title / Role | Primary Functional Module | Navigation Route |
| :- | :--- | :--- | :--- | :--- |
| **01** | `SplashScreen` | Splash & Bootstrapping | App Startup / Security Check | `/splash` |
| **02** | `LanguageSelectModal` | Select Language Modal | Localization (`en` / `hi`) | `/language-select` |
| **03** | `LoginScreen` | Login & Authentication | User Identity / SSO | `/login` |
| **04** | `SignUpScreen` | Create Account | New User Registration | `/signup` |
| **05** | `OtpVerificationScreen` | Enter OTP Verification | Security Credential Verification | `/verify-otp` |
| **06** | `HomeScreen` | Main Home Dashboard | Super App Service Hub | `/home` |
| **07** | `StationSearchModal` | Station Search & Autocomplete | Station Discovery | `/station-search` |
| **08** | `TrainResultsScreen` | Train Search Results | Reserved Ticketing | `/train-results` |
| **09** | `SpotYourTrainScreen` | Spot Your Train (Live Status) | NTES Live Tracking | `/spot-train` |
| **10** | `CoachPositionScreen` | Train Coach Position | Train Layout & Formation | `/coach-position` |
| **11** | `PnrStatusScreen` | PNR Status Enquiry | Reservation Lifecycle | `/pnr-status` |
| **12** | `UtsBookingScreen` | UTS Unreserved Ticketing | Suburban & General Tickets | `/uts-booking` |
| **13** | `DigitalTicketScreen` | Active Ticket / ERS Viewer | Ticket Inspection & QR | `/ticket-view` |
| **14** | `PlatformTicketScreen` | Platform Ticket Booking | Station Platform Passes | `/platform-ticket` |
| **15** | `RWalletScreen` | R-Wallet Balance & Recharge | Stored Value Account | `/r-wallet` |
| **16** | `BillDeskPaymentModal` | Payment Gateway Checkout | Payment Processing | `/payment-checkout` |
| **17** | `RailMadadScreen` | Rail Madad (File Complaint) | Passenger Grievance Redressal | `/rail-madad` |
| **18** | `TrackComplaintScreen` | Track Grievance Status | Complaint Tracking | `/track-complaint` |
| **19** | `StationAmenitiesScreen`| Know Your Station Amenities | Station Facilities Guide | `/station-amenities` |
| **20** | `ProfileSettingsScreen`| Profile & Security Settings | Account & Preferences | `/profile` |

---

## 3. Screen-by-Screen Specifications

---

### Screen 01: `SplashScreen`
1. **Screen Name:** `SplashScreen`
2. **Screen Purpose:** Bootstrapping the Flutter engine, executing environment and root detection (`AppZygotePreload`), validating pinned certificates, and verifying existing session tokens.
3. **Navigation Entry Point:** Cold start via `com.example.aikyam.MainActivity`.
4. **Layout Structure:** Centered single-column layout with brand logos and subtle spinner.
5. **Header & Toolbar:** Transparent / Full-screen immersive (status bar overlaid).
6. **Navigation Elements:** None (automated transition).
7. **Buttons:** None.
8. **Input Fields:** None.
9. **Cards & Lists:** None.
10. **Icons & Images:** Primary RailOne logo (`assets/icons/railone.png`), Indian Railways crest (`assets/images/IR_logo_blue.png`), CRIS crest (`assets/images/cris_logo.png`).
11. **Typography:** Noto Sans SemiBold 18sp ("RailOne - Super App for Indian Railways").
12. **Colors:** Background `#FFFFFF`, primary blue `#0D47A1`.
13. **Margins & Padding:** Center-aligned with 32dp bottom footer padding.
14. **Dialogs & Bottom Sheets:** None (except root warning dialog if device is rooted).
15. **Interactive Behavior:** Automatically branches after 1,500ms based on session state:
    - If first launch -> Open `LanguageSelectModal`.
    - If session valid -> Navigate to `HomeScreen`.
    - Else -> Navigate to `LoginScreen`.
16. **Loading State:** Circular loader (`loader.png` or `CircularProgressIndicator`).
17. **Empty State:** N/A.
18. **Error State:** Modal alert if root detected or security integrity fails.
19. **Navigation Destination:** `/language-select`, `/home`, or `/login`.

---

### Screen 02: `LanguageSelectModal`
1. **Screen Name:** `LanguageSelectModal`
2. **Screen Purpose:** Enables the user to select between English and Hindi (`en` / `hi`).
3. **Navigation Entry Point:** Invoked from `SplashScreen` (first run) or language button in app bar.
4. **Layout Structure:** Bottom sheet modal with title, radio selection tiles, and confirm button.
5. **Header & Toolbar:** Bottom sheet drag handle + Title ("Select Language" / "भाषा चुनें").
6. **Navigation Elements:** Close icon (`X`) at top-right.
7. **Buttons:** Primary "Continue" / "आगे बढ़ें" pill button.
8. **Input Fields:** None.
9. **Cards & Lists:** 2 selectable language option tiles:
   - English ("English") with tick indicator.
   - Hindi ("हिंदी") with tick indicator.
10. **Icons & Images:** `circle-tick.svg` on active selection.
11. **Typography:** Noto Sans Bold 18sp for title, Regular 16sp for language labels.
12. **Colors:** Sheet surface `#FFFFFF`, selected border `#0D47A1`, unselected `#E2E8F0`.
13. **Margins & Padding:** 24dp internal padding, 16dp item spacing.
14. **Dialogs & Bottom Sheets:** Modal bottom sheet behavior with rounded top corners (16dp).
15. **Interactive Behavior:** Tapping a language tile updates the active radio state; tapping Continue calls `Get.updateLocale()` and dismisses the modal.
16. **Loading State:** Instant transition.
17. **Empty State:** N/A.
18. **Error State:** N/A.
19. **Navigation Destination:** Dismisses modal and transitions to `/login` or `/home`.

---

### Screen 03: `LoginScreen`
1. **Screen Name:** `LoginScreen`
2. **Screen Purpose:** Authenticate returning passengers via credentials, biometric unlock, or Rail Connect SSO.
3. **Navigation Entry Point:** Route `/login`.
4. **Layout Structure:** Vertical scrollable form with top brand banner, input fields, slide-to-login button, and alternative SSO options.
5. **Header & Toolbar:** Minimal app bar with "Skip" / "Guest Mode" button on top-right.
6. **Navigation Elements:** Back button if navigated from another screen.
7. **Buttons:**
   - Swipe button: `slider_button` ("Slide to Login" / "slide to sign up").
   - Text button: "Forgot Password?".
   - Outlined button: "Rail Connect" SSO.
   - Text link: "Don't have an account? Sign up".
   - Biometric shortcut: Fingerprint / Face ID icon button.
8. **Input Fields:**
   - User ID / Mobile / Email text field with leading user icon.
   - Password field with leading lock icon and visibility toggle eye icon.
9. **Cards & Lists:** Centered elevated card containing the login inputs.
10. **Icons & Images:** `railone.png`, `login_security.svg`, `Face_ID_logo.png`, `finger_print_icon.png`.
11. **Typography:** Title: Noto Sans Bold 24sp ("Login"), Fields: 15sp, Helper: 13sp.
12. **Colors:** Background `#F8FAFC`, card `#FFFFFF`, primary button `#0D47A1`, accent gold `#F59E0B`.
13. **Margins & Padding:** 20dp horizontal screen padding, 16dp vertical field spacing.
14. **Dialogs & Bottom Sheets:** Biometric authentication prompt (`BiometricPrompt`).
15. **Interactive Behavior:**
    - Slide-to-login requires a full horizontal swipe to trigger the authentication API.
    - Tapping Biometric icon prompts system fingerprint/face dialog.
16. **Loading State:** Slider button shows spinning spinner while validating credentials.
17. **Empty State:** Disabled swipe button until both fields are populated.
18. **Error State:** Red inline error text ("Invalid User ID or Password").
19. **Navigation Destination:** `/home`, `/signup`, or `/verify-otp`.

---

### Screen 04: `SignUpScreen`
1. **Screen Name:** `SignUpScreen`
2. **Screen Purpose:** New passenger account registration with live password complexity validation.
3. **Navigation Entry Point:** Link from `LoginScreen` (`/signup`).
4. **Layout Structure:** Scrollable multi-field registration form with live validation checklist.
5. **Header & Toolbar:** App bar with back arrow and title "Create Account".
6. **Navigation Elements:** Left back arrow icon (`arrow.png`).
7. **Buttons:**
   - Swipe button: `slider_button` ("Slide to sign up").
   - Link: "Already have an account? Sign in".
8. **Input Fields:**
   - Full Name (`fullName`)
   - Mobile Number with `+91` country code (`intl_phone_field`)
   - Email ID (`email`)
   - Password (`password`) with visibility toggle
9. **Cards & Lists:** Live password rule verification checklist:
   - [x] At least 1 lowercase character (`lowerCaseCharacter`)
   - [x] At least 1 uppercase character (`upperCaseCharacter`)
   - [x] At least 1 special character (`specialCharacter`)
   - [x] At least 1 number (`number`)
   - [x] 8 characters minimum (`characterMinimum`)
10. **Icons & Images:** Green checkmark (`circle-tick.svg`) on satisfied criteria, grey dot on pending.
11. **Typography:** Header: 22sp Bold, Field labels: 14sp Medium, Rule text: 12sp Regular.
12. **Colors:** Rule check: `#16A34A` (satisfied), `#94A3B8` (pending), error red `#DC2626`.
13. **Margins & Padding:** 20dp horizontal, 14dp vertical gap between inputs.
14. **Dialogs & Bottom Sheets:** Terms and Privacy Policy bottom sheet link.
15. **Interactive Behavior:** Real-time regex evaluation updates rule checkmarks as the user types password. Slider unlocks only when all criteria pass.
16. **Loading State:** Loading spinner overlay on slider track.
17. **Empty State:** Inputs blank with placeholders.
18. **Error State:** Inline error text if mobile already exists or email is invalid.
19. **Navigation Destination:** Transitions to `/verify-otp` upon successful registration.

---

### Screen 05: `OtpVerificationScreen`
1. **Screen Name:** `OtpVerificationScreen`
2. **Screen Purpose:** Two-factor SMS and Email OTP verification for login, registration, and password recovery.
3. **Navigation Entry Point:** Route `/verify-otp`.
4. **Layout Structure:** Centered card with mobile number badge, 6-digit OTP boxes, countdown timer, and verify button.
5. **Header & Toolbar:** Back arrow navigation + title "Verify OTP".
6. **Navigation Elements:** Back arrow.
7. **Buttons:**
   - Primary "Verify" (`verifyOTP`) pill button.
   - Text button: "Change" (`change`) to edit mobile number.
   - Link button: "Resend OTP" (disabled during cooldown).
8. **Input Fields:** 6 individual square OTP input boxes (`pin_code_fields`) with automatic forward and backward focus.
9. **Cards & Lists:** Centered verification card.
10. **Icons & Images:** SMS illustration graphic, timer icon.
11. **Typography:** Title 20sp Bold, Subtitle 14sp ("Enter OTP sent to your mobile number \n +91 98765 43210"), Timer 14sp Bold.
12. **Colors:** Active box border `#0D47A1`, inactive `#CBD5E1`, filled `#F8FAFC`.
13. **Margins & Padding:** 24dp screen padding, 8dp gap between OTP boxes.
14. **Dialogs & Bottom Sheets:** None.
15. **Interactive Behavior:** Auto-fills SMS OTP via `sms_autofill`. Auto-submits when all 6 digits are entered.
16. **Loading State:** Button shows progress indicator; boxes disabled.
17. **Empty State:** Empty boxes with cursor blinking on box 1.
18. **Error State:** All boxes turn red (`#DC2626`) with haptic shake vibration and error message "Invalid OTP. 2 attempts remaining".
19. **Navigation Destination:** Route `/home` on successful verification.

---

### Screen 06: `HomeScreen`
1. **Screen Name:** `HomeScreen`
2. **Screen Purpose:** Central Super App dashboard unifying all Indian Railways passenger services.
3. **Navigation Entry Point:** Default landing screen (`/home`).
4. **Layout Structure:** Vertical scroll view with top app bar, hero search card, R-Wallet badge, promotional banner carousel, quick inquiry grid, booking services grid, parcel/freight section, and bottom navigation bar.
5. **Header & Toolbar:**
   - Left: RailOne app icon (`app_icon_white.png`) + "RailOne" title.
   - Right: Notification bell icon with red unread count badge + Profile avatar.
6. **Navigation Elements:** Fixed bottom navigation bar with 5 items:
   1. Home (Active)
   2. My Bookings (`my_transaction_icon.png`)
   3. Enquiries (`enquire_pnr_icon.png`)
   4. Rail Madad (`train_complaint_icon.png`)
   5. More Services (`show_services.svg`)
7. **Buttons:**
   - "Search Trains" primary button.
   - Station swap floating circular button (`swap_icon.png`).
   - "Add money now" wallet link.
   - "View All" / "View Less" toggle button.
8. **Input Fields:**
   - Origin Station selection tile ("From: Origin Station?").
   - Destination Station selection tile ("To: Where To?").
   - Journey Date picker tile ("When?").
9. **Cards & Lists:**
   - **Hero Search Card:** Rounded elevated card containing station inputs and date selector.
   - **R-Wallet Card:** Blue-gradient card displaying balance (`₹ 2.00`), "Low Balance", "Add money now" button, and cashback tag.
   - **Hero Banner Carousel:** Auto-sliding railway landmark photographs (`chenab.jpg`, `noney_bridge.webp`).
   - **Quick Actions Grid (4 items):** PNR Status, Food on Train, Check Cancellation, Seat Availability.
   - **Services Grid (8 items):** Reserved Ticket, UTS Unreserved, Platform Ticket, Spot Your Train, Coach Position, Live Station, Train Schedule, Retiring Room.
   - **Parcel & Freight Grid (4 items):** Book Parcel, Track Consignment, Rate Calculator, FOIS Freight.
10. **Icons & Images:** 30+ service icons (detailed in Resource Inventory).
11. **Typography:** Section Headers: 18sp Bold, Card Titles: 13sp SemiBold, Balance: 20sp Bold.
12. **Colors:** Scaffold `#F8FAFC`, App bar `#0D47A1`, Search card `#FFFFFF`, Wallet gradient `#1E3A8A` to `#2563EB`, Accent Gold `#F59E0B`.
13. **Margins & Padding:** 16dp horizontal page margin, 12dp grid spacing.
14. **Dialogs & Bottom Sheets:** Station search modal, Date picker sheet.
15. **Interactive Behavior:** Tapping any service tile routes instantly to that module. Swapping stations executes an animated 180-degree rotation on the swap icon.
16. **Loading State:** Shimmer placeholders (`skeletonizer`) on wallet balance and carousel.
17. **Empty State:** N/A.
18. **Error State:** Offline banner at top if disconnected.
19. **Navigation Destination:** Routes to screens 07 through 20.

---

### Screen 07: `StationSearchModal`
1. **Screen Name:** `StationSearchModal`
2. **Screen Purpose:** Fast fuzzy-search autocomplete for all ~8,500 Indian Railway stations.
3. **Navigation Entry Point:** Tapping "From" or "To" on `HomeScreen`.
4. **Layout Structure:** Full-screen modal with sticky top search bar, speech-to-text mic button, recent searches chip row, and live results list view.
5. **Header & Toolbar:** Search text bar with leading back arrow and trailing clear (`X`) button.
6. **Navigation Elements:** Back arrow.
7. **Buttons:** Clear query button, Speech-to-text mic icon.
8. **Input Fields:** Auto-focused search text input with placeholder "Search Station (Name or Code)".
9. **Cards & Lists:**
   - Recent searches horizontal chip list (e.g. `[NDLS - New Delhi]`, `[HWH - Howrah]`).
   - Vertical result list items showing: Station Name, Station Code badge (e.g. `NDLS`), Zone (e.g. `Northern Railway`), State.
10. **Icons & Images:** `station_icon.png`, `filter_icon.png`, mic icon.
11. **Typography:** Station Name 16sp Bold, Code 14sp SemiBold (White on Blue badge), Subtitle 12sp.
12. **Colors:** Search bar background `#F1F5F9`, Station code badge `#0D47A1`.
13. **Margins & Padding:** 16dp horizontal, 12dp item padding.
14. **Dialogs & Bottom Sheets:** None.
15. **Interactive Behavior:** Keystroke debouncing (300ms) filters local SQLite database in real-time. Selecting an item returns it to `HomeScreen` and closes the modal.
16. **Loading State:** Small circular progress indicator on right of search bar while querying.
17. **Empty State:** "No stations found matching '{query}'" with railway search suggestion.
18. **Error State:** N/A.
19. **Navigation Destination:** Pops back to `HomeScreen` or `TrainResultsScreen`.

---

### Screen 08: `TrainResultsScreen`
1. **Screen Name:** `TrainResultsScreen`
2. **Screen Purpose:** Displays all scheduled trains between selected stations with live availability and fares.
3. **Navigation Entry Point:** Route `/train-results` from "Search Trains" button.
4. **Layout Structure:** Top date ribbon scroller, quota/class filter chips bar, and vertical train card list.
5. **Header & Toolbar:** Top bar showing "NDLS -> BCT" with journey date and edit button (`train_search_edit.png`).
6. **Navigation Elements:** Back arrow.
7. **Buttons:**
   - Filter / Sort button (`filter_icon.png`).
   - "Book Now" button on selected class chip.
8. **Input Fields:** Quota dropdown selector (General, Tatkal, Premium Tatkal, Ladies).
9. **Cards & Lists:**
   - Date selector horizontal ribbon (-1 Day, Date, +1 Day).
   - **Train Cards:**
     - Train Number & Name (e.g. "12952 - MUMBAI RAJDHANI").
     - Runs on: M T W T F S S badges.
     - Departure Time, Station Code, Duration arrow, Arrival Time, Station Code.
     - Class Availability Horizontal Chips:
       - `1A` (₹ 4,850) -> `AVAILABLE 12` (Green)
       - `2A` (₹ 2,980) -> `AVAILABLE 45` (Green)
       - `3A` (₹ 2,150) -> `WL 24` (Orange)
10. **Icons & Images:** Train class badges (`1A.svg`, `2A.svg`, `3A.svg`, `S1.svg`), duration arrow.
11. **Typography:** Train Title 16sp Bold, Departure/Arrival times 18sp Bold, Availability 13sp SemiBold.
12. **Colors:** Available text `#16A34A`, Waitlist text `#EA580C`, Card background `#FFFFFF`.
13. **Margins & Padding:** 12dp card margin, 12dp internal card padding.
14. **Dialogs & Bottom Sheets:** Class fare breakdown bottom sheet, Passenger details entry sheet.
15. **Interactive Behavior:** Tapping a class chip expands the card to show fare breakup, cancellation policy, and "Book" button.
16. **Loading State:** Shimmer skeleton train cards (`shimmer`).
17. **Empty State:** "No direct trains found between these stations on the selected date" with alternate date suggestions.
18. **Error State:** "Unable to fetch train schedules. Pull to refresh".
19. **Navigation Destination:** Transitions to passenger details and payment flow.

---

### Screen 09: `SpotYourTrainScreen`
1. **Screen Name:** `SpotYourTrainScreen`
2. **Screen Purpose:** Real-time GPS-assisted train running status and delay tracker.
3. **Navigation Entry Point:** Route `/spot-train`.
4. **Layout Structure:** Top train info header card, delay summary banner, and vertical station progress timeline.
5. **Header & Toolbar:** Back arrow + Train number and name.
6. **Navigation Elements:** Back arrow, Refresh button (`refresh_icon.png`).
7. **Buttons:** "Refresh Status", "Share Status" (`share_icon.png`), "Set Station Alarm".
8. **Input Fields:** Date selector (Yesterday, Today, Tomorrow departure).
9. **Cards & Lists:**
   - Summary card: "Currently between KOTA and RTM", "5 mins late", "Next stop: Ratlam Jn (Platform 4)".
   - **Vertical Timeline:**
     - Departed stations: Solid green line, green dot, actual departure timestamp.
     - Current position: Pulsing train icon (`train_location.png`, `blinking_text`), live platform number.
     - Upcoming stations: Dotted grey line, grey dot, estimated arrival time.
10. **Icons & Images:** `track_long_image.png`, `train_engine.png`, `train_location.png`, `live_icon.jpeg`.
11. **Typography:** Station name 15sp SemiBold, Time 14sp Bold, Delay badge 13sp Bold.
12. **Colors:** Ontime `#16A34A`, Delayed `#EA580C`, Timeline line `#0D47A1`.
13. **Margins & Padding:** 16dp horizontal margin, 24dp timeline station spacing.
14. **Dialogs & Bottom Sheets:** Station alarm setup sheet.
15. **Interactive Behavior:** Pull-to-refresh queries latest NTES server timestamp; pinch-to-zoom on timeline.
16. **Loading State:** Animated train driving across track placeholder.
17. **Empty State:** "Train has not departed yet from originating station".
18. **Error State:** "GPS feed temporarily unavailable. Showing last scheduled timetable".
19. **Navigation Destination:** Back to `HomeScreen` or station details.

---

### Screen 10: `CoachPositionScreen`
1. **Screen Name:** `CoachPositionScreen`
2. **Screen Purpose:** Shows exact rake formation and coach sequence (Engine to Guard) for passenger boarding.
3. **Navigation Entry Point:** Route `/coach-position`.
4. **Layout Structure:** Train search bar at top, coach summary card, and horizontal scrollable train rake layout.
5. **Header & Toolbar:** Back arrow + Title "Coach Position".
6. **Navigation Elements:** Back arrow.
7. **Buttons:** Train number search button, Flip direction toggle button (`flip_icon.png`).
8. **Input Fields:** Train number / PNR input field.
9. **Cards & Lists:**
   - **Horizontal Scrollable Train Rake:**
     - Visual rendering of continuous railway track (`new_tain_track.png`).
     - Sequence of coach boxes:
       `[Engine] -> [Power] -> [H1] -> [A1] -> [A2] -> [B1] -> [B2] -> [PC] -> [S1] ... -> [Guard]`
   - Coach detail card displaying selected coach's class, berth count, and platform alignment.
10. **Icons & Images:** `engineNew.svg`, `1A.svg`, `2A.svg`, `3A.svg`, `S1.svg`, `Gen.svg`, `PC.svg`, `Power.svg`, `gaurd.svg`.
11. **Typography:** Coach Code: 14sp Bold (e.g. `B2`), Coach Type: 11sp Regular (`3 Tier AC`).
12. **Colors:** 1A: Purple `#7C3AED`, 2A: Red `#DC2626`, 3A: Blue `#2563EB`, Sleeper: Green `#059669`, General: Orange `#D97706`.
13. **Margins & Padding:** 8dp horizontal gap between coaches on track.
14. **Dialogs & Bottom Sheets:** Berth map modal showing internal seating layout (Lower, Middle, Upper, Side Lower, Side Upper).
15. **Interactive Behavior:** Horizontal drag scroller with inertia; tapping any coach highlights it and shows seating layout.
16. **Loading State:** Track shimmer animation.
17. **Empty State:** "Enter 5-digit Train Number to view coach formation".
18. **Error State:** "Coach formation not updated for this train today".
19. **Navigation Destination:** Back to previous screen.

---

### Screen 11: `PnrStatusScreen`
1. **Screen Name:** `PnrStatusScreen`
2. **Screen Purpose:** Check 10-digit PNR reservation details, berth allocation, and chart preparation status.
3. **Navigation Entry Point:** Route `/pnr-status`.
4. **Layout Structure:** PNR input bar at top, Charting status banner, Train journey summary card, and passenger status list.
5. **Header & Toolbar:** Back arrow + Title "PNR Status".
6. **Navigation Elements:** Back arrow, Share button.
7. **Buttons:** "Check Status" button, "Download Ticket" (`download_icon.png`), "Order Food" link (`order_food.svg`).
8. **Input Fields:** 10-digit numeric PNR input field with auto-advance and clear button.
9. **Cards & Lists:**
   - **Charting Status Banner:** Green ("Chart Prepared") or Orange ("Chart Not Prepared").
   - **Train Journey Card:** Train No/Name, From Station, To Station, Boarding Date, Boarding Point.
   - **Passenger Table Card:**
     - Row per passenger: Passenger No, Booking Status (e.g., `B2, 45, MB`), Current Status (`CNF`).
10. **Icons & Images:** `enquire_pnr_icon.png`, `circle-tick.svg`, `information_alert.png`.
11. **Typography:** PNR Title 18sp Bold, Passenger Status 16sp Bold, Labels 13sp Regular.
12. **Colors:** Confirmed `#16A34A`, Waitlist `#EA580C`, RAC `#CA8A04`, Card background `#FFFFFF`.
13. **Margins & Padding:** 16dp horizontal margin, 12dp card padding.
14. **Dialogs & Bottom Sheets:** Cancellation rules dialog.
15. **Interactive Behavior:** Automatically queries backend when 10 digits are typed.
16. **Loading State:** Circular loader inside "Check Status" button.
17. **Empty State:** Prompt to enter PNR with a list of recently checked PNRs.
18. **Error State:** "Invalid PNR Number / Flushed PNR" in red box.
19. **Navigation Destination:** Routes to Food on Train or E-Ticket download.

---

### Screen 12: `UtsBookingScreen`
1. **Screen Name:** `UtsBookingScreen`
2. **Screen Purpose:** Book unreserved suburban and general railway tickets (Paperless or Paper).
3. **Navigation Entry Point:** Route `/uts-booking`.
4. **Layout Structure:** Geofence status bar, ticket mode toggle (Paperless / Paper), station selectors, passenger count dropdown, class and train type selectors, fare display card, and payment button.
5. **Header & Toolbar:** Back arrow + Title "UTS Unreserved Ticket".
6. **Navigation Elements:** Back arrow.
7. **Buttons:** "Book Ticket" primary button, "Recharge R-Wallet" shortcut.
8. **Input Fields:**
   - Source Station (Auto-detected via GPS if paperless).
   - Destination Station selector.
   - Adult Passengers (1 to 4), Child Passengers (0 to 3).
   - Ticket Class: Second Class (`II`) / First Class (`I`).
   - Train Type: Ordinary (`O`) / Mail Express (`M`) / Superfast (`S`).
9. **Cards & Lists:**
   - **Geofence Validation Card:** Shows GPS location status ("Within 5 km radius of station - Eligible for Paperless").
   - **Fare Breakdown Card:** Total Fare in ₹, R-Wallet available balance.
10. **Icons & Images:** `card_unreserve_ticket.png`, `current_location.png`, `r_wallet_icon.svg`.
11. **Typography:** Fare: 24sp Bold (`₹ 30.00`), Form labels: 14sp Medium.
12. **Colors:** Paperless indicator green `#16A34A`, Primary button `#0D47A1`.
13. **Margins & Padding:** 16dp horizontal, 16dp between section cards.
14. **Dialogs & Bottom Sheets:** Geofence error dialog ("You are inside station premises / track area. Paperless tickets cannot be booked inside station").
15. **Interactive Behavior:** Verifies GPS position against polygon KML boundaries before enabling Paperless booking.
16. **Loading State:** Location pin pulsing animation while acquiring GPS lock.
17. **Empty State:** N/A.
18. **Error State:** Red alert banner if GPS is disabled or outside valid distance.
19. **Navigation Destination:** Transitions to `/ticket-view` upon booking completion.

---

### Screen 13: `DigitalTicketScreen`
1. **Screen Name:** `DigitalTicketScreen`
2. **Screen Purpose:** Display active digital e-ticket or UTS ticket to Travelling Ticket Examiner (TTE) with dynamic anti-fraud animations.
3. **Navigation Entry Point:** Route `/ticket-view`.
4. **Layout Structure:** High-security digital ticket card with railway watermark, dynamic animated time banner, 2D barcode, QR inspection code, ticket attributes, and share/print actions.
5. **Header & Toolbar:** Back arrow + "Active Ticket".
6. **Navigation Elements:** Back arrow.
7. **Buttons:** "Share Ticket" (`share_icon.png`), "Print / PDF" (`printer_icon.png`), "Cancel Ticket".
8. **Input Fields:** None.
9. **Cards & Lists:**
   - **Security Ticket Card:**
     - Animated color-shifting ticker / clock (proves ticket is not a static screenshot).
     - Indian Railways Logo & Government of India emblem.
     - Origin Station -> Destination Station in large bold type.
     - Booking Time, Validity End Time ("Valid till 15:30").
     - Number of Passengers, Class, Fare (`₹ 30.00`).
     - Scannable QR code (`my_logo_for_qr.png`).
     - Barcode stripe (`ticketBarCode.png`).
10. **Icons & Images:** `ticket_bcgrnd.png`, `IR_logo_blue.png`, `circle-tick.svg`, `ticketBarCode.png`.
11. **Typography:** Station Codes 22sp Bold, Times 15sp Bold, Watermark 12sp.
12. **Colors:** Valid ticket green band `#16A34A`, Background `#FFFFFF`, Watermark `#F1F5F9`.
13. **Margins & Padding:** 16dp ticket margin, 20dp internal padding.
14. **Dialogs & Bottom Sheets:** Cancellation confirmation dialog.
15. **Interactive Behavior:**
    - `no_screenshot` blocks taking screenshots or screen recording.
    - Screen brightness automatically boosted to 100% for optical barcode scanning.
16. **Loading State:** Ticket loading animation.
17. **Empty State:** "No active tickets found".
18. **Error State:** If ticket has expired, displays red "EXPIRED" stamp (`cancelledTicket.png`).
19. **Navigation Destination:** Back to `HomeScreen` or `/r-wallet`.

---

### Screen 14: `PlatformTicketScreen`
1. **Screen Name:** `PlatformTicketScreen`
2. **Screen Purpose:** Quick 2-click booking of station platform visitor passes.
3. **Navigation Entry Point:** Route `/platform-ticket`.
4. **Layout Structure:** Current station card, passenger count chips, fare display, and quick payment button.
5. **Header & Toolbar:** Back arrow + Title "Platform Ticket".
6. **Navigation Elements:** Back arrow.
7. **Buttons:** "Book Platform Ticket" button, Passenger count chips (`1`, `2`, `3`, `4`).
8. **Input Fields:** Station name search field (defaults to current GPS station).
9. **Cards & Lists:** Station summary card, Platform pass rules card (valid for 2 hours from booking).
10. **Icons & Images:** `platform_card.png`, `platfor_ticket_icon.png`.
11. **Typography:** Fare: 24sp Bold (`₹ 10.00` or `₹ 20.00`), Rules: 12sp Regular.
12. **Colors:** Primary blue `#0D47A1`, Pass indicator `#2563EB`.
13. **Margins & Padding:** 16dp margin.
14. **Dialogs & Bottom Sheets:** None.
15. **Interactive Behavior:** Selecting passenger count immediately recalculates fare; one-tap booking via R-Wallet.
16. **Loading State:** Processing spinner.
17. **Empty State:** N/A.
18. **Error State:** "GPS station mismatch" error.
19. **Navigation Destination:** Direct to `/ticket-view`.

---

### Screen 15: `RWalletScreen`
1. **Screen Name:** `RWalletScreen`
2. **Screen Purpose:** Display railway wallet balance, offer recharge incentives, and view transaction history.
3. **Navigation Entry Point:** Route `/r-wallet`.
4. **Layout Structure:** Top gradient balance card, recharge amount chip selector, payment method selector, and transaction ledger list.
5. **Header & Toolbar:** Back arrow + Title "R-Wallet".
6. **Navigation Elements:** Back arrow.
7. **Buttons:**
   - Quick recharge chips: `+ ₹100`, `+ ₹200`, `+ ₹500`, `+ ₹1000`.
   - "Recharge Wallet" primary action button.
   - Filter ledger button.
8. **Input Fields:** Custom recharge amount numeric input.
9. **Cards & Lists:**
   - **Balance Card:** Dark blue gradient card showing available balance, account ID, and "3% Cashback on every recharge" banner (`cashback.gif`).
   - **Transaction Ledger:** Scrollable list of past recharges, ticket debits, and refunds with timestamps, status tags, and green/red amount indicators.
10. **Icons & Images:** `Wallet.gif`, `cashback.gif`, `myTransactionCard.png`, `upi_image.png`.
11. **Typography:** Balance: 28sp Bold, Ledger items: 15sp Medium, Subtitles: 12sp Regular.
12. **Colors:** Credit: `#16A34A`, Debit: `#DC2626`, Card gradient `#0F172A` to `#1E3A8A`.
13. **Margins & Padding:** 16dp padding.
14. **Dialogs & Bottom Sheets:** Recharge success modal with `Confetti.gif`.
15. **Interactive Behavior:** Tapping an amount chip populates the input field and computes the 3% cashback bonus value in real-time.
16. **Loading State:** Balance shimmer; transaction history skeleton list.
17. **Empty State:** "No transactions in the last 30 days".
18. **Error State:** "Payment failed. If amount was debited, it will be refunded within 3 working days".
19. **Navigation Destination:** Opens `BillDeskPaymentModal` on recharge trigger.

---

### Screen 16: `BillDeskPaymentModal`
1. **Screen Name:** `BillDeskPaymentModal`
2. **Screen Purpose:** Checkout payment gateway modal for processing payments via UPI, Credit/Debit cards, and NetBanking.
3. **Navigation Entry Point:** Triggered by recharge or ticket payment actions.
4. **Layout Structure:** Bottom sheet modal with order amount banner, payment option tabs (UPI, Card, NetBanking), input form, and Pay button.
5. **Header & Toolbar:** BillDesk security lock emblem + Order total (`₹ 500.00`) + Close icon.
6. **Navigation Elements:** Close button (`cancel_payment.svg`).
7. **Buttons:** "Pay ₹500.00" button, "Scan UPI QR" button (`QrImage.svg`).
8. **Input Fields:** Card Number, Expiry MM/YY, CVV, Cardholder Name, or UPI VPA ID.
9. **Cards & Lists:** Supported UPI apps horizontal row (GPay, PhonePe, Paytm, BHIM).
10. **Icons & Images:** 34 SVGs from `packages/flutter_billdesk_sdk/assets/svgs/`.
11. **Typography:** Amount: 22sp Bold, Option labels: 14sp SemiBold.
12. **Colors:** BillDesk accent `#0284C7`, Security badge `#16A34A`.
13. **Margins & Padding:** 20dp modal padding.
14. **Dialogs & Bottom Sheets:** Bank OTP 3D-Secure webview dialog.
15. **Interactive Behavior:** Card number auto-formats with spaces; detects Visa/Mastercard/RuPay card type automatically.
16. **Loading State:** Full-screen modal overlay "Connecting to Bank Secure Gateway...".
17. **Empty State:** N/A.
18. **Error State:** "Transaction declined by bank. Please check your CVV and try again".
19. **Navigation Destination:** Returns success payload to calling screen.

---

### Screen 17: `RailMadadScreen`
1. **Screen Name:** `RailMadadScreen`
2. **Screen Purpose:** Lodge official passenger complaints, grievances, and emergency assistance requests to Indian Railways.
3. **Navigation Entry Point:** Route `/rail-madad`.
4. **Layout Structure:** Tab toggle (Train Complaint / Station Complaint), PNR / Station input, incident datetime, grievance category dropdown, description field, proof attachment picker, and submit button.
5. **Header & Toolbar:** Back arrow + Title "Rail Madad".
6. **Navigation Elements:** Back arrow, "Track Existing Complaint" top-right text button.
7. **Buttons:**
   - Mode Toggle: "Train" vs "Station".
   - "Attach Photo / Video" button (`cameraIcon.png`).
   - "Submit Grievance" primary button.
   - Emergency helpline dialer button ("Dial 139").
8. **Input Fields:**
   - PNR Number (if Train) or Station Name (if Station).
   - Incident Date & Time picker.
   - Grievance Category (Medical Assistance, Cleanliness, Food & Catering, Punctuality, Electrical, Security).
   - Description text area (up to 500 characters).
9. **Cards & Lists:** Image attachment thumbnail card with remove (`X`) button.
10. **Icons & Images:** `train_complaint_icon.png`, `cameraIcon.png`, `file_icon.png`, `help_centre_suggestion.svg.vec`.
11. **Typography:** Header: 20sp Bold, Form labels: 14sp Medium, Character counter: 12sp Regular.
12. **Colors:** Primary blue `#0D47A1`, Emergency red `#DC2626`.
13. **Margins & Padding:** 16dp padding.
14. **Dialogs & Bottom Sheets:** Image cropper dialog (`UCropActivity`).
15. **Interactive Behavior:** Attaching a photo launches camera or file picker and runs native image compression (`flutter_image_compress`).
16. **Loading State:** Submission progress indicator with upload percentage.
17. **Empty State:** Blank form.
18. **Error State:** "Please enter a valid 10-digit PNR or Station Code".
19. **Navigation Destination:** Displays reference ID modal and navigates to `/track-complaint`.

---

### Screen 18: `TrackComplaintScreen`
1. **Screen Name:** `TrackComplaintScreen`
2. **Screen Purpose:** Track resolution progress of filed Rail Madad complaints and submit satisfaction feedback.
3. **Navigation Entry Point:** Route `/track-complaint`.
4. **Layout Structure:** Reference number search bar, complaint summary card, progress status stepper, and feedback reaction bar.
5. **Header & Toolbar:** Back arrow + Title "Track Complaint".
6. **Navigation Elements:** Back arrow.
7. **Buttons:** "Search", "Call Railway Division", Feedback rating buttons.
8. **Input Fields:** Complaint Reference Number (e.g., `RM-2026-11-098231`).
9. **Cards & Lists:**
   - **Status Stepper Card:**
     1. Registered (`circle-tick.svg`)
     2. Assigned to On-Duty Staff / DRM Office
     3. Action In-Progress
     4. Resolved / Closed
   - **Feedback Reaction Bar:** 3 feedback emotion faces:
     - Good (`coloured_good_icon.svg.vec`)
     - Average (`coloured_average_icon.svg.vec`)
     - Poor (`coloured_poor_icon.svg.vec`)
10. **Icons & Images:** `help_centre_suggestion.svg.vec`, feedback icons, stepper dots.
11. **Typography:** Reference Number 18sp Bold, Stepper titles 14sp SemiBold.
12. **Colors:** Stepper active green `#16A34A`, pending grey `#94A3B8`.
13. **Margins & Padding:** 16dp horizontal, 16dp card padding.
14. **Dialogs & Bottom Sheets:** Feedback submission thank-you dialog.
15. **Interactive Behavior:** Tapping a feedback face submits satisfaction rating instantly.
16. **Loading State:** Stepper shimmer.
17. **Empty State:** "Enter your complaint reference number to track live status".
18. **Error State:** "Reference number not found. Please verify the code from your SMS".
19. **Navigation Destination:** Back to `HomeScreen`.

---

### Screen 19: `StationAmenitiesScreen`
1. **Screen Name:** `StationAmenitiesScreen`
2. **Screen Purpose:** Detailed station facilities and amenities directory ("Know Your Station").
3. **Navigation Entry Point:** Route `/station-amenities`.
4. **Layout Structure:** Station selector header, categorical tabs (All, Platforms, Food, Restrooms, Accessibility), and 2-column facility cards grid.
5. **Header & Toolbar:** Back arrow + Title "Station Amenities".
6. **Navigation Elements:** Back arrow, Station search icon.
7. **Buttons:** Category filter tabs, "Locate on Map" button.
8. **Input Fields:** Station code search bar.
9. **Cards & Lists:**
   - 2-Column Grid of Amenity Cards:
     - Drinking Water booths (Platform numbers)
     - AC / Non-AC Waiting Halls
     - Clean Restrooms / Toilets
     - IRCTC Food Plazas & Stalls
     - Escalators & Lifts
     - Foot Over Bridges (FOBs)
     - ATMs & Currency
     - Wheelchair Assistance & Braille Signage
     - Retiring Rooms & Dormitories
10. **Icons & Images:** 13 amenity badges (`amenities_water.png`, `amenities_toilet_second.png`, `escalator_image.png`, `lift_image.png`, `wheelchair_amenity.png`).
11. **Typography:** Card title: 14sp Bold, Platform text: 12sp Regular.
12. **Colors:** Card background `#FFFFFF`, Amenity badge `#F1F5F9`, Primary `#0D47A1`.
13. **Margins & Padding:** 16dp screen padding, 12dp grid spacing.
14. **Dialogs & Bottom Sheets:** Retiring room booking redirection sheet.
15. **Interactive Behavior:** Tapping an amenity opens detailed station platform location notes.
16. **Loading State:** Grid skeleton placeholders.
17. **Empty State:** "No specific amenities documented for this station".
18. **Error State:** N/A.
19. **Navigation Destination:** Back to `HomeScreen`.

---

### Screen 20: `ProfileSettingsScreen`
1. **Screen Name:** `ProfileSettingsScreen`
2. **Screen Purpose:** Passenger profile management, Aadhaar linkage, security settings, and app configurations.
3. **Navigation Entry Point:** Route `/profile`.
4. **Layout Structure:** Top user profile header card, KYC verification badge, settings section tiles list, and logout button.
5. **Header & Toolbar:** Back arrow + Title "My Profile".
6. **Navigation Elements:** Back arrow.
7. **Buttons:**
   - "Edit Profile" button (`edit_blue.png`).
   - "Link Aadhaar" action card (`link_aadhar_icon.png`).
   - "Change Password" tile (`change_password.png`).
   - "Logout" danger button.
8. **Input Fields:** None (displays user details).
9. **Cards & Lists:**
   - **User Info Card:** Avatar, Passenger Full Name, Mobile Number, Email ID, Member Since date.
   - **Settings List Sections:**
     1. Security & Biometrics:
        - Biometric Fingerprint / Face ID toggle (`flutter_advanced_switch`).
        - Two-factor authentication toggle.
     2. Preferences:
        - Language selector tile (English / हिंदी).
        - Push notification permissions toggle.
     3. Legal & Support:
        - Terms and Conditions, Privacy Policy.
        - App Version (`2.1.79`).
10. **Icons & Images:** `profile_icon.svg.vec`, `link_aadhar_icon.png`, `finger_print_icon.png`, `Face_ID_logo.png`, `edit_blue.png`.
11. **Typography:** User Name: 20sp Bold, Field titles: 15sp Medium, Version: 12sp Grey.
12. **Colors:** User card background `#0D47A1` (White text), Logout red `#DC2626`.
13. **Margins & Padding:** 16dp horizontal margin, 12dp list item gap.
14. **Dialogs & Bottom Sheets:** Logout confirmation dialog ("Are you sure you want to log out?"), Language selector modal.
15. **Interactive Behavior:** Toggling biometrics prompts OS fingerprint sensor to verify identity before saving preference to `flutter_secure_storage`.
16. **Loading State:** Saving indicator on toggle switches.
17. **Empty State:** N/A.
18. **Error State:** N/A.
19. **Navigation Destination:** Transitions to `/login` upon logout.

