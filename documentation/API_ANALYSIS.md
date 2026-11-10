# API & Network Integration Analysis

## 1. Executive Summary & Guidelines

This document presents the API endpoints, data models, network workflows, and authentication protocols identified from the reference APK.

> [!IMPORTANT]
> **Clean-Room Implementation & Security Compliance:**
> In strict accordance with Project Rule 11 and 12, no proprietary production API keys, signing secrets, or private server credentials extracted from the APK are hardcoded in the recreated application. All endpoints must be configured via environment variables and configuration files (`app_config.json`). Where CRIS/IRCTC backend services require proprietary enterprise credentials, clean modular service adapters and mock fallbacks are provided.

---

## 2. Base URLs & Infrastructure Domains

| Service Module | Host Domain / Gateway | Protocol | Purpose |
| :--- | :--- | :--- | :--- |
| **CRIS Aikyam Central Gateway** | `https://api.railone.cris.org.in` | HTTPS | User profile, authentication, wallet, and orchestration |
| **National Train Enquiry (NTES)** | `https://enquiry.indianrail.gov.in` | HTTPS | PNR status, train schedule, spot train, live station |
| **UTS Mobile Backend** | `https://uts.cris.org.in` | HTTPS | Unreserved ticketing, suburban fare calculation, season tickets |
| **IRCTC / eCatering** | `https://www.ecatering.irctc.co.in` | HTTPS | Food order on train, restaurant discovery |
| **Rail Madad Grievance** | `https://railmadad.indianrailways.gov.in`| HTTPS | Passenger complaint registration and tracking |
| **FOIS (Freight Operations)** | `https://fois.indianrail.gov.in` | HTTPS | Freight rates, consignment tracking |
| **BillDesk Payment Gateway** | `https://pgi.billdesk.com` | HTTPS | Payment processing, UPI, NetBanking, Cards |
| **Google Maps & Geocoding** | `https://maps.googleapis.com` | HTTPS | Station map rendering, routing lines |

---

## 3. Authentication & Security Headers

All authenticated API requests communicate using standardized JSON envelopes and security headers.

### Common Request Headers
```http
POST /api/v2/train/search HTTP/1.1
Host: api.railone.cris.org.in
Content-Type: application/json
Accept: application/json
Accept-Language: en
User-Agent: RailOne/2.1.79 (Android; Mobile; SDK 36)
Authorization: Bearer <JWT_ACCESS_TOKEN>
X-Device-Id: <UUID_HASH>
X-App-Version: 2.1.79
X-Client-Timestamp: 1731234567890
X-Request-Nonce: <CRYPTOGRAPHIC_NONCE>
```

---

## 4. Detailed Endpoint Specifications

### 4.1 Authentication & User Lifecycle

#### 1. Request Mobile / Email OTP
- **Endpoint:** `POST /api/v1/auth/otp/send`
- **Request Body:**
```json
{
  "identifier": "9876543210",
  "type": "MOBILE", // or "EMAIL"
  "purpose": "REGISTRATION" // or "LOGIN", "FORGOT_PASSWORD"
}
```
- **Response (200 OK):**
```json
{
  "status": "SUCCESS",
  "message": "OTP sent successfully",
  "data": {
    "otpSessionId": "otp_sess_9a8b7c6d",
    "expiresIn": 120,
    "resendCooldown": 30
  }
}
```

#### 2. Verify OTP & Authenticate
- **Endpoint:** `POST /api/v1/auth/otp/verify`
- **Request Body:**
```json
{
  "otpSessionId": "otp_sess_9a8b7c6d",
  "otp": "482910",
  "deviceId": "d41d8cd98f00b204e9800998ecf8427e"
}
```
- **Response (200 OK):**
```json
{
  "status": "SUCCESS",
  "data": {
    "accessToken": "eyJhbGciOi...",
    "refreshToken": "dGhpcy1pcy1...",
    "expiresIn": 3600,
    "user": {
      "userId": "CRIS_USER_1029",
      "name": "Passenger Name",
      "mobile": "9876543210",
      "email": "user@example.com",
      "rWalletBalance": 2.00,
      "isBiometricEnabled": false
    }
  }
}
```

#### 3. Slide-to-Login / Password Authentication
- **Endpoint:** `POST /api/v1/auth/login`
- **Request Body:**
```json
{
  "username": "9876543210",
  "password": "<SHA256_HASH>",
  "sliderVerified": true
}
```

---

### 4.2 Train Search & NTES Live Tracking

#### 1. Station Autocomplete & Search
- **Endpoint:** `GET /api/v1/trains/stations/suggest?q=NDLS`
- **Response (200 OK):**
```json
[
  {
    "code": "NDLS",
    "name": "New Delhi",
    "hindiName": "नई दिल्ली",
    "zone": "NR",
    "division": "DLI",
    "state": "Delhi"
  },
  {
    "code": "HWH",
    "name": "Howrah Junction",
    "hindiName": "हावड़ा जंक्शन",
    "zone": "ER",
    "division": "HWH",
    "state": "West Bengal"
  }
]
```

#### 2. Trains Between Stations
- **Endpoint:** `POST /api/v1/trains/search`
- **Request Body:**
```json
{
  "fromStationCode": "NDLS",
  "toStationCode": "BCT",
  "journeyDate": "2026-11-15",
  "quota": "GN" // General, Tatkal, Ladies, Lower Berth
}
```
- **Response (200 OK):**
```json
{
  "trains": [
    {
      "trainNumber": "12952",
      "trainName": "Mumbai Rajdhani Express",
      "departureTime": "16:55",
      "arrivalTime": "08:35",
      "duration": "15h 40m",
      "classes": [
        {"classCode": "1A", "className": "First AC", "available": 12, "fare": 4850},
        {"classCode": "2A", "className": "2 Tier AC", "available": 45, "fare": 2980},
        {"classCode": "3A", "className": "3 Tier AC", "available": 0, "status": "WL 24", "fare": 2150}
      ]
    }
  ]
}
```

#### 3. Live Train Running Status (Spot Your Train)
- **Endpoint:** `GET /api/v1/ntes/running-status?trainNo=12952&startDate=20261110`
- **Response (200 OK):**
```json
{
  "trainNo": "12952",
  "trainName": "Mumbai Rajdhani",
  "currentStation": "KOTA",
  "currentStatus": "Departed Kota Junction at 21:05",
  "delayMinutes": 5,
  "nextStation": "RTM",
  "distanceCoveredKm": 465,
  "totalDistanceKm": 1384,
  "lastUpdated": "2026-11-10T21:10:00Z"
}
```

#### 4. Coach Position Layout
- **Endpoint:** `GET /api/v1/trains/coach-position?trainNo=12952`
- **Response (200 OK):**
```json
{
  "trainNo": "12952",
  "coaches": [
    {"position": 1, "code": "ENG", "type": "ENGINE"},
    {"position": 2, "code": "PWR", "type": "POWER_CAR"},
    {"position": 3, "code": "H1", "type": "1A"},
    {"position": 4, "code": "A1", "type": "2A"},
    {"position": 5, "code": "A2", "type": "2A"},
    {"position": 6, "code": "B1", "type": "3A"},
    {"position": 7, "code": "PC", "type": "PANTRY_CAR"}
  ]
}
```

---

### 4.3 PNR Status & Reservation Inquiries

#### Check 10-Digit PNR Status
- **Endpoint:** `GET /api/v1/pnr/status/{pnrNumber}`
- **Validation:** 10 numeric digits, Modulo-10 checksum validation.
- **Response (200 OK):**
```json
{
  "pnr": "2451892019",
  "trainNo": "12952",
  "trainName": "MUMBAI RAJDHANI",
  "journeyDate": "2026-11-12",
  "boardingStation": "NDLS",
  "destinationStation": "BCT",
  "chartPrepared": false,
  "passengers": [
    {
      "passengerNumber": 1,
      "bookingStatus": "B2, 45, MB",
      "currentStatus": "CNF",
      "coach": "B2",
      "berth": 45,
      "berthType": "MIDDLE"
    }
  ]
}
```

---

### 4.4 UTS Unreserved & Suburban Ticketing

#### 1. Geofence & Location Validation
- **Endpoint:** `POST /api/v1/uts/geofence/validate`
- **Request Body:**
```json
{
  "latitude": 28.6431,
  "longitude": 77.2197,
  "stationCode": "NDLS"
}
```
- **Business Rule:**
  - Must be **within 5.0 km** of the departure station.
  - Must be **outside 30 meters** of the track/station platform (outside the polygon defined in bundled KML files).
- **Response (200 OK):**
```json
{
  "eligibleForPaperless": true,
  "distanceMeters": 420,
  "stationCode": "NDLS"
}
```

#### 2. Book UTS Paperless Journey Ticket
- **Endpoint:** `POST /api/v1/uts/ticket/book`
- **Request Body:**
```json
{
  "sourceStation": "NDLS",
  "destinationStation": "GZB",
  "ticketType": "JOURNEY", // or "PLATFORM", "SEASON"
  "passengerCount": 2,
  "trainType": "ORDINARY", // or "MAIL_EXPRESS", "SUPERFAST"
  "classType": "SECOND", // or "FIRST"
  "paymentMode": "R_WALLET"
}
```
- **Response (200 OK):**
```json
{
  "ticketId": "UTS9918234812",
  "bookingTime": "2026-11-10T12:30:00Z",
  "validTill": "2026-11-10T15:30:00Z",
  "source": "NDLS",
  "destination": "GZB",
  "fare": 30.00,
  "qrPayload": "UTS:9918234812:NDLS:GZB:2:20261110",
  "barcodeData": "9918234812"
}
```

---

### 4.5 R-Wallet & BillDesk Payment Gateway

#### 1. Wallet Balance & History
- **Endpoint:** `GET /api/v1/wallet/balance`
- **Response (200 OK):**
```json
{
  "balance": 2.00,
  "currency": "INR",
  "isLowBalance": true,
  "bonusCashbackPct": 3.0
}
```

#### 2. Initiate BillDesk Payment
- **Endpoint:** `POST /api/v1/payments/billdesk/order`
- **Request Body:**
```json
{
  "amount": 500.00,
  "orderType": "WALLET_RECHARGE" // or "TICKET_BOOKING"
}
```
- **Response (200 OK):**
```json
{
  "billdeskOrderId": "BD_ORD_8192301",
  "token": "BD_AUTH_TOKEN_SAMPLE",
  "returnUrl": "https://api.railone.cris.org.in/api/v1/payments/callback"
}
```

---

### 4.6 Rail Madad (Grievance Registration)

#### Submit Passenger Complaint
- **Endpoint:** `POST /api/v1/madad/complaint`
- **Form Data:**
  - `complaintType`: "TRAIN" / "STATION"
  - `pnrOrUts`: "2451892019"
  - `incidentDate`: "2026-11-10"
  - `category`: "CLEANLINESS" / "FOOD" / "PUNCTUALITY" / "ELECTRICAL"
  - `subCategory`: "Coach washroom not clean"
  - `description`: "Water facility empty in coach B2"
  - `attachment`: Binary image payload (from camera or image picker)
- **Response (200 OK):**
```json
{
  "complaintReferenceNumber": "RM-2026-11-098231",
  "status": "REGISTERED",
  "estimatedResolutionHours": 2
}
```

---

## 5. Mock & Offline Adapter Strategy

For legitimate recreation and offline testing, the new application includes a configurable `MockApiService` that intercepts network calls when `USE_MOCK_DATA = true`. The mock service yields authentic response structures populated with realistic Indian Railway train numbers, stations, coach layouts, and PNR data.

