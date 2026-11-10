# Visual & Media Resource Inventory

## 1. Overview

This document provides a comprehensive catalog of all visual, vector, audio, font, geographic, and localized resources extracted from the reference APK `One.apk`. Over 300 discrete graphical assets, 7 station boundary KML maps, 5 font families, and bilingual locale dictionaries have been cataloged.

---

## 2. Brand & Official Identity Assets

| Asset Path | Format | Visual Role / Purpose |
| :--- | :--- | :--- |
| `assets/icons/railone.png` | PNG | Official RailOne application logo |
| `assets/images/IR_logo_blue.png` | PNG | Indian Railways official crest (Navy Blue) |
| `assets/images/crisLogo.png` / `cris_logo.png` | PNG | Centre for Railway Information Systems (CRIS) logo |
| `assets/images/irctc.png` | PNG | Indian Railway Catering and Tourism Corporation badge |
| `assets/images/appIcon.svg.vec` / `app_icon_white.png` | SVG / PNG | Header brandmark and splash screen identity |
| `assets/images/Face_ID_logo.png` / `face_id_icon_svg.png` | PNG | Biometric Face Unlock authentication emblem |
| `assets/images/finger_print_icon.png` | PNG | Biometric Fingerprint authentication icon |

---

## 3. Train Rolling Stock & Coach Composition

Used in the **Coach Position** visual module to represent train rake layouts from engine to guard van:

| Coach Code | Vector / Raster Asset | Description |
| :--- | :--- | :--- |
| **Locomotive** | `images/engineNew.svg`, `images/engine_new.svg`, `images/engineWithCompt.png`, `images/extra_engine.png`, `images/electric.jpeg` | Lead engine and electric locomotive graphic |
| **1st AC (1A)** | `images/1A.svg`, `images/1A_engine.png` | AC First Class coach emblem |
| **2nd AC (2A)** | `images/2A.svg`, `images/2A_engine.png` | AC 2-Tier sleeper coach emblem |
| **3rd AC (3A)** | `images/3A.svg`, `images/3A_engine.png` | AC 3-Tier sleeper coach emblem |
| **Chair Car (CC)** | `images/cc_Engine.png` | AC Chair Car coach emblem |
| **Sleeper (S1)** | `images/S1.svg` | Non-AC Sleeper coach graphic |
| **General (Gen)** | `images/Gen.svg` | Unreserved General second-class coach |
| **Pantry Car (PC)**| `images/PC.svg` | Catering / Pantry car coach |
| **Power Car** | `images/Power.svg` | End-on generator power car |
| **Guard Van** | `images/gaurd.svg`, `images/end.svg` | Brake luggage van / Guard's rear compartment |
| **Coach Track** | `images/coach_new.svg`, `images/coach_position_new.svg.vec`, `images/coach1.png`, `images/new_tain_track.png` | Horizontal track scroller showing coach positions (1 to 24) |

---

## 4. Passenger Services & Enquiry Icons

High-resolution inquiry feature icons on the main dashboard and inquiry hub:

| Feature Name | Asset Reference | Visual Representation |
| :--- | :--- | :--- |
| **Spot Your Train** | `images/enquire_spot_your_train.png`, `images/track_your_train.svg.vec` | Train on GPS map pin |
| **PNR Status** | `images/enquire_pnr_icon.png`, `images/inaction_pnr_status.png` | 10-digit ticket with magnifying glass |
| **Train Between Stations** | `images/enquire_train_between_stations.png`, `images/search_train.svg.vec` | Dual stations linked with railway track |
| **Live Station** | `images/enquire_live_station.png`, `images/live_icon.jpeg` | Clock tower station with departing trains |
| **Coach Position** | `images/enquire_coach_position.png` | Multi-coach rake diagram |
| **Train Schedule** | `images/enquire_train_schedule.png` | Timetable calendar sheet |
| **Seat Availability** | `images/enquire_seat_availability.png`, `images/inaction_seat_available.png`, `images/seatAvailablity.png` | Berth seating diagram |
| **Cancelled / Diverted**| `images/more_cancelled_diverted_train.png`, `images/inaction_cancellation.png` | Train with warning triangle |
| **Fare Calculator** | `images/more_fare_calculator.png`, `images/calculator_svg.svg.vec`, `images/calculator_pink_svg.svg.vec` | Calculator with currency symbol |

---

## 5. Station Amenities & Passenger Facilities

Used in the **Know Your Station** feature to guide passengers inside major railway junctions:

| Amenity | Asset Reference |
| :--- | :--- |
| **Drinking Water** | `images/amenities_water.png`, `images/water_facility_image.png` |
| **Restrooms / Toilets**| `images/amenities_toilet_second.png` |
| **Waiting Halls** | `images/service_image.png`, `images/fan_image.png` |
| **Food Plaza & Refreshments** | `images/food_plaza_image.png`, `images/food_icon.png` |
| **Escalators & Lifts** | `images/escalator_image.png`, `images/lift_image.png` |
| **Foot Over Bridge** | `images/foot_on_bridge_image.png`, `images/foot_over_bridge.png` |
| **Entry & Exit Gates** | `images/entry_gate.png`, `images/exit_gate.png` |
| **Display Boards** | `images/display_board_image.png` |
| **Wheelchair Facility** | `images/wheelchair_amenity.png` |
| **Station Parking** | `images/parking_image.png` |
| **ATMs & Banking** | `images/atm_amenity.png`, `images/ic_logo_icici_mpp.png` |
| **Retiring Rooms & Dormitory** | `images/retiring_room_amenity.png`, `images/bedroll.png` |
| **Booking Counters** | `images/booking_counter_image.png`, `images/enquiry_amenity.png` |

---

## 6. Ticketing & Booking Cards

| Visual Component | Asset Reference | Functionality |
| :--- | :--- | :--- |
| **UTS Unreserved Ticket** | `images/card_unreserve_ticket.png`, `images/unreserve_card.png`, `images/others_uts_icon.png` | Unreserved journey ticketing card |
| **Reserved Ticket (IRCTC)** | `images/reserve_card.png`, `images/e_ticket.png` | PNR e-ticket representation |
| **Platform Ticket** | `images/platfor_ticket_icon.png`, `images/platform_card.png` | Station platform access pass card |
| **Barcode & QR Validation** | `images/ticketBarCode.png`, `images/my_logo_for_qr.png`, `images/scan-line.png` | Digital ticket QR inspector payload |
| **Ticket Background Texture** | `images/ticket_bcgrnd.png` | Security watermark pattern on active tickets |
| **Cancelled Ticket Stamp** | `images/cancelledTicket.png` | Red cancellation stamp overlay |

---

## 7. R-Wallet & Financial Visuals

| Component | Asset Reference | Visual Description |
| :--- | :--- | :--- |
| **R-Wallet Icon** | `images/r_wallet_icon.svg`, `icons/Wallet.gif` | Railway wallet emblem with currency |
| **Cashback & Bonus** | `icons/cashback.gif` | Cashback incentive badge (3% bonus on recharge) |
| **Transaction Cards** | `images/myTransactionCard.png`, `images/my_transaction_icon.png` | Ledger transaction card |
| **Payment Success** | `icons/icons8-success.gif`, `icons/Confetti.gif`, `images/circle-tick.svg` | Animated transaction success modal |
| **BillDesk Payment SVGs** | `packages/flutter_billdesk_sdk/assets/svgs/*.svg` (34 SVGs) | Card icons, UPI logo, NetBanking, Security shields |

---

## 8. Rail Madad & Customer Grievances

| Feature | Asset Reference |
| :--- | :--- |
| **Grievance Emblem** | `images/train_complaint_icon.png`, `images/help_centre_suggestion.svg.vec` |
| **Web Claim Portal** | `images/help_web_claim.png` |
| **Feedback Reactions** | `images/good_feedback_icon.svg.vec`, `images/coloured_good_icon.svg.vec`, `images/average_feedback_icon.svg.vec`, `images/coloured_average_icon.svg.vec`, `images/coloured_poor_icon.svg.vec` |

---

## 9. Station Geofencing Boundary Files (KML)

The reference APK bundles 7 geographic polygon boundaries under `assets/flutter_assets/assets/images/others/kml/`:
- `Ahmedabad.kml`
- `Delhi.kml`
- `Gurugram.kml`
- `Lucknow.kml`
- `Noida.kml`
- `Somnath.kml`
- `Vadodara.kml`

These polygon boundaries define restricted railway track and platform zones where ticket generation is forbidden by railway security policy to prevent passengers from booking a ticket after boarding without one.

---

## 10. Typography & Font Manifest

Decoded from `FontManifest.json`:

1. **Noto Sans:**
   - Regular: `assets/fonts/NotoSans-Regular.ttf`
   - Bold: `assets/fonts/NotoSans-Bold.ttf`
   - Primary application typography offering full Devanagari (Hindi) and Latin support.
2. **Font Awesome 7:**
   - Brands: `packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf`
   - Regular: `packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf`
   - Solid: `packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf`
3. **Cupertino Icons:**
   - `packages/cupertino_icons/assets/CupertinoIcons.ttf`
4. **Material Icons:**
   - `fonts/MaterialIcons-Regular.otf`

---

## 11. Color Palette & Theming System

Derived from native styles (`styles.xml`, `colors.xml`, SVG fill attributes):

| Role | Color Hex | Sample Usage |
| :--- | :--- | :--- |
| **Primary Railway Blue** | `#0D47A1` / `#1A365D` | App bars, primary action buttons, header cards, brand crest |
| **Secondary Teal / Sky** | `#0288D1` / `#00A3E0` | Active tab highlights, search icons, secondary action pills |
| **Accent Orange / Gold** | `#F59E0B` / `#D97706` | R-Wallet badge, Tatkal indicators, cashback banner |
| **Surface Card White** | `#FFFFFF` | Service cards, bottom sheets, form input fields |
| **Background Neutral** | `#F8FAFC` / `#F1F5F9` | Scaffold background, grouped list backgrounds |
| **Success Green** | `#16A34A` | Confirmed PNR status (`CNF`), active ticket valid state |
| **Warning Amber** | `#EA580C` | Waitlisted status (`WL`), delayed train alert |
| **Danger / Error Red** | `#DC2626` | Cancelled ticket, expired ticket, form validation error |
| **Text Primary** | `#0F172A` | Screen headers, station titles, train numbers |
| **Text Secondary** | `#64748B` | Timestamps, subtitles, helper labels |
| **Border Grey** | `#E2E8F0` | Card borders, text field outlines, dividers |

