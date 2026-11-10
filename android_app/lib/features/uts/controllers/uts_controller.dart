import 'package:get/get.dart';
import '../../../data/models/station_model.dart';
import '../../../data/models/ticket_model.dart';
import '../../../core/location/geofence_service.dart';
import '../../home/controllers/home_controller.dart';

class UtsController extends GetxController {
  final isPaperless = true.obs;
  final passengerCount = 1.obs;
  final childCount = 0.obs;
  final selectedClass = 'Second Class (II)'.obs;
  final selectedTrainType = 'Ordinary'.obs;
  final sourceStation = const Station(
    code: 'NDLS',
    name: 'New Delhi',
    hindiName: 'नई दिल्ली',
    zone: 'NR',
    state: 'Delhi',
    latitude: 28.6431,
    longitude: 77.2197,
  ).obs;

  final destinationStation = const Station(
    code: 'GZB',
    name: 'Ghaziabad',
    hindiName: 'गाजियाबाद',
    zone: 'NR',
    state: 'Uttar Pradesh',
    latitude: 28.6692,
    longitude: 77.4538,
  ).obs;

  final fareAmount = 15.0.obs;
  final geofenceStatus = 'Within 5 km radius • Eligible for Paperless Ticket'.obs;
  final isGeofenceValid = true.obs;
  final activeTicket = Rxn<DigitalTicket>();

  @override
  void onInit() {
    super.onInit();
    recalculateFare();
  }

  void recalculateFare() {
    double base = 15.0;
    if (selectedClass.value.contains('First')) {
      base = 75.0;
    }
    if (selectedTrainType.value == 'Superfast') {
      base += 15.0;
    }
    fareAmount.value = base * passengerCount.value + (base * 0.5 * childCount.value);
  }

  bool bookTicket() {
    final homeController = Get.find<HomeController>();
    if (homeController.rWalletBalance.value < fareAmount.value) {
      return false; // Insufficient balance
    }

    // Deduct balance
    homeController.updateWalletBalance(homeController.rWalletBalance.value - fareAmount.value);

    // Create digital ticket
    final now = DateTime.now();
    activeTicket.value = DigitalTicket(
      ticketId: 'UTS${now.millisecondsSinceEpoch.toString().substring(3)}',
      ticketType: 'JOURNEY',
      sourceStation: sourceStation.value.name,
      destinationStation: destinationStation.value.name,
      trainType: selectedTrainType.value.toUpperCase(),
      classType: selectedClass.value,
      passengerCount: passengerCount.value,
      fare: fareAmount.value,
      bookingTime: now,
      validTill: now.add(const Duration(hours: 3)),
      qrPayload: 'UTS:${sourceStation.value.code}:${destinationStation.value.code}:${now.millisecondsSinceEpoch}',
      barcodeNumber: '${now.millisecondsSinceEpoch}',
      isPaperless: isPaperless.value,
    );

    return true;
  }
}
