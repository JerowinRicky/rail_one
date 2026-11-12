import 'package:get/get.dart';
import '../../../data/models/station_model.dart';
import '../../../core/location/geofence_service.dart';

class HomeController extends GetxController {
  final currentTabIndex = 0.obs;
  final isServicesExpanded = false.obs;

  // Ticketing Mode: 0 = Reserved (IRCTC), 1 = Unreserved (UTS)
  final ticketingMode = 0.obs;

  // Selected Route & Date (Reserved)
  final fromStation = const Station(code: 'NDLS', name: 'New Delhi', hindiName: 'नई दिल्ली', zone: 'NR', state: 'Delhi').obs;
  final toStation = const Station(code: 'BCT', name: 'Mumbai Central', hindiName: 'मुंबई सेंट्रल', zone: 'WR', state: 'Maharashtra').obs;
  final journeyDate = DateTime.now().obs;
  final selectedQuota = 'General'.obs;
  final selectedClass = 'All Classes'.obs;

  // Unreserved (UTS) Specific State
  final utsBookingType = 'paperless'.obs; // 'paperless' or 'paper'
  final utsServiceType = 'journey'.obs;   // 'journey', 'platform', 'season'
  final utsTrainType = 'Mail/Express'.obs;
  final utsClass = 'Second Class (2S)'.obs;
  final utsAdultCount = 1.obs;
  final utsChildCount = 0.obs;
  final isInsideGeofence = true.obs;
  final geofenceDistanceMeters = 350.0.obs;

  // Bookings Tab Split: 0 = Reserved, 1 = Unreserved (UTS)
  final bookingsSubTabIndex = 0.obs;
  final bookingsFilter = 'all'.obs;

  // Wallet
  final walletBalance = 2.00.obs;

  void swapStations() {
    final temp = fromStation.value;
    fromStation.value = toStation.value;
    toStation.value = temp;
  }

  void setTicketingMode(int mode) {
    ticketingMode.value = mode;
  }

  void toggleServicesExpanded() {
    isServicesExpanded.value = !isServicesExpanded.value;
  }

  void updateTabIndex(int index) {
    currentTabIndex.value = index;
  }

  double calculateUtsFare() {
    double base = utsTrainType.value == 'Ordinary' ? 15.0 : (utsTrainType.value == 'Mail/Express' ? 30.0 : 45.0);
    if (utsClass.value.contains('First')) base *= 3.5;
    double total = (base * utsAdultCount.value) + (base * 0.5 * utsChildCount.value);
    return total;
  }

  double calculateUtsDiscountedFare() {
    double total = calculateUtsFare();
    return total * 0.97; // 3% R-Wallet discount
  }
}
