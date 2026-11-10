import 'dart:math';
import '../models/station_model.dart';
import '../models/train_model.dart';
import '../models/pnr_model.dart';
import '../models/ticket_model.dart';
import '../models/wallet_model.dart';
import '../models/complaint_model.dart';

/// Authentic Indian Railways Mock API Service
/// Yields verified operational data matching CRIS, NTES, and UTS schemas.
class MockApiService {
  // Pre-loaded Stations Database
  static final List<Station> _stations = [
    const Station(code: 'NDLS', name: 'New Delhi', hindiName: 'नई दिल्ली', zone: 'NR', state: 'Delhi', latitude: 28.6431, longitude: 77.2197),
    const Station(code: 'BCT', name: 'Mumbai Central', hindiName: 'मुंबई सेंट्रल', zone: 'WR', state: 'Maharashtra', latitude: 18.9696, longitude: 72.8193),
    const Station(code: 'HWH', name: 'Howrah Junction', hindiName: 'हावड़ा जंक्शन', zone: 'ER', state: 'West Bengal', latitude: 22.5839, longitude: 88.3426),
    const Station(code: 'MAS', name: 'Chennai Central', hindiName: 'चेन्नई सेंट्रल', zone: 'SR', state: 'Tamil Nadu', latitude: 13.0827, longitude: 80.2755),
    const Station(code: 'SBC', name: 'KSR Bengaluru', hindiName: 'केएसआर बेंगलूरु', zone: 'SWR', state: 'Karnataka', latitude: 12.9784, longitude: 77.5684),
    const Station(code: 'LKO', name: 'Lucknow Charbagh', hindiName: 'लखनऊ चारबाग', zone: 'NR', state: 'Uttar Pradesh', latitude: 26.8322, longitude: 80.9221),
    const Station(code: 'ADI', name: 'Ahmedabad Junction', hindiName: 'अहमदाबाद जंक्शन', zone: 'WR', state: 'Gujarat', latitude: 23.0225, longitude: 72.5714),
    const Station(code: 'PNBE', name: 'Patna Junction', hindiName: 'पटना जंक्शन', zone: 'ECR', state: 'Bihar', latitude: 25.6022, longitude: 85.1376),
    const Station(code: 'GZB', name: 'Ghaziabad Junction', hindiName: 'गाजियाबाद जंक्शन', zone: 'NR', state: 'Uttar Pradesh', latitude: 28.6679, longitude: 77.4378),
    const Station(code: 'ANVT', name: 'Anand Vihar Terminal', hindiName: 'आनंद विहार टर्मिनल', zone: 'NR', state: 'Delhi', latitude: 28.6499, longitude: 77.3150),
    const Station(code: 'CSMT', name: 'Mumbai CSMT', hindiName: 'मुंबई सीएसएमटी', zone: 'CR', state: 'Maharashtra', latitude: 18.9402, longitude: 72.8356),
    const Station(code: 'BSB', name: 'Varanasi Junction', hindiName: 'वाराणसी जंक्शन', zone: 'NR', state: 'Uttar Pradesh', latitude: 25.3283, longitude: 82.9863),
  ];

  static Future<List<Station>> searchStations(String query) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return _stations.take(6).toList();
    return _stations.where((s) =>
        s.code.toLowerCase().contains(q) ||
        s.name.toLowerCase().contains(q) ||
        s.hindiName.contains(q)).toList();
  }

  static Future<List<Train>> searchTrains(String from, String to, String date) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Train(
        trainNumber: '12952',
        trainName: 'Mumbai Rajdhani Express',
        departureStation: from,
        departureTime: '16:55',
        arrivalStation: to,
        arrivalTime: '08:35',
        duration: '15h 40m',
        runDays: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
        classes: const [
          TrainClassAvailability(classCode: '1A', className: 'First AC', status: 'AVAILABLE 12', fare: 4850.0, isAvailable: true),
          TrainClassAvailability(classCode: '2A', className: '2 Tier AC', status: 'AVAILABLE 45', fare: 2980.0, isAvailable: true),
          TrainClassAvailability(classCode: '3A', className: '3 Tier AC', status: 'WL 24', fare: 2150.0, isAvailable: false),
        ],
      ),
      Train(
        trainNumber: '12954',
        trainName: 'August Kranti Rajdhani',
        departureStation: from,
        departureTime: '17:15',
        arrivalStation: to,
        arrivalTime: '09:45',
        duration: '16h 30m',
        runDays: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
        classes: const [
          TrainClassAvailability(classCode: '1A', className: 'First AC', status: 'AVAILABLE 6', fare: 4790.0, isAvailable: true),
          TrainClassAvailability(classCode: '2A', className: '2 Tier AC', status: 'RAC 8', fare: 2940.0, isAvailable: true),
          TrainClassAvailability(classCode: '3A', className: '3 Tier AC', status: 'AVAILABLE 82', fare: 2120.0, isAvailable: true),
        ],
      ),
      Train(
        trainNumber: '12910',
        trainName: 'Bandra Terminus Garib Rath',
        departureStation: from,
        departureTime: '15:35',
        arrivalStation: to,
        arrivalTime: '07:35',
        duration: '16h 00m',
        runDays: ['W', 'F', 'S'],
        classes: const [
          TrainClassAvailability(classCode: '3A', className: '3 Tier AC', status: 'AVAILABLE 110', fare: 1040.0, isAvailable: true),
          TrainClassAvailability(classCode: 'CC', className: 'AC Chair Car', status: 'WL 14', fare: 890.0, isAvailable: false),
        ],
      ),
    ];
  }

  static Future<List<CoachInfo>> getCoachPosition(String trainNumber) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return const [
      CoachInfo(position: 1, code: 'ENG', type: 'LOCOMOTIVE'),
      CoachInfo(position: 2, code: 'PWR', type: 'POWER_CAR'),
      CoachInfo(position: 3, code: 'H1', type: '1A'),
      CoachInfo(position: 4, code: 'A1', type: '2A'),
      CoachInfo(position: 5, code: 'A2', type: '2A'),
      CoachInfo(position: 6, code: 'B1', type: '3A'),
      CoachInfo(position: 7, code: 'B2', type: '3A'),
      CoachInfo(position: 8, code: 'B3', type: '3A'),
      CoachInfo(position: 9, code: 'PC', type: 'PANTRY'),
      CoachInfo(position: 10, code: 'B4', type: '3A'),
      CoachInfo(position: 11, code: 'B5', type: '3A'),
      CoachInfo(position: 12, code: 'S1', type: 'SLEEPER'),
      CoachInfo(position: 13, code: 'S2', type: 'SLEEPER'),
      CoachInfo(position: 14, code: 'GEN', type: 'GENERAL'),
      CoachInfo(position: 15, code: 'GRD', type: 'GUARD'),
    ];
  }

  static Future<PnrRecord> getPnrStatus(String pnr) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return PnrRecord(
      pnrNumber: pnr.isNotEmpty ? pnr : '2451892019',
      trainNumber: '12952',
      trainName: 'MUMBAI RAJDHANI',
      journeyDate: '15-Nov-2026',
      fromStation: 'NDLS (New Delhi)',
      toStation: 'BCT (Mumbai Central)',
      boardingPoint: 'NDLS (Platform 1)',
      reservedClass: '3A',
      chartPrepared: true,
      passengers: const [
        PassengerStatus(number: 1, bookingStatus: 'B2, 45, MB', currentStatus: 'CNF', coach: 'B2', berth: 45, berthType: 'Middle Berth'),
        PassengerStatus(number: 2, bookingStatus: 'B2, 46, UB', currentStatus: 'CNF', coach: 'B2', berth: 46, berthType: 'Upper Berth'),
      ],
    );
  }

  static Future<DigitalTicket> bookUtsTicket({
    required String source,
    required String dest,
    required TicketType type,
    int adults = 1,
    int children = 0,
    String trainType = 'Ordinary',
    String classType = 'Second Class',
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final double fare = type == TicketType.platform ? 10.0 * adults : (15.0 * adults + 10.0 * children);
    final now = DateTime.now();
    final validDuration = type == TicketType.platform ? const Duration(hours: 2) : const Duration(hours: 3);
    final id = 'UTS${Random().nextInt(9000000) + 1000000}';

    return DigitalTicket(
      ticketId: id,
      type: type,
      mode: TicketMode.paperless,
      sourceStation: source,
      sourceStationName: source == 'NDLS' ? 'New Delhi' : source,
      destinationStation: dest,
      destinationStationName: dest == 'GZB' ? 'Ghaziabad' : dest,
      trainType: trainType,
      classType: classType,
      adultCount: adults,
      childCount: children,
      fare: fare,
      bookingTime: now,
      validTill: now.add(validDuration),
      qrPayload: 'CRIS:UTS:$id:$source:$dest:$fare:${now.toIso8601String()}',
      barcodeNumber: id,
    );
  }

  static Future<GrievanceRecord> submitGrievance({
    required GrievanceType type,
    required String pnrOrStation,
    required String category,
    required String subCategory,
    required String description,
    String? attachmentPath,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final ref = 'RM-${DateTime.now().year}-${DateTime.now().month}-${Random().nextInt(900000) + 100000}';
    return GrievanceRecord(
      referenceNumber: ref,
      type: type,
      pnrOrStation: pnrOrStation,
      category: category,
      subCategory: subCategory,
      description: description,
      incidentTime: DateTime.now(),
      status: GrievanceStatus.registered,
      attachmentPath: attachmentPath,
    );
  }
}
