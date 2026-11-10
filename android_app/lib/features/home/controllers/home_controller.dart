import 'package:get/get.dart';
import '../../../data/models/station_model.dart';

class HomeController extends GetxController {
  final currentTabIndex = 0.obs;
  final isServicesExpanded = false.obs;

  // Selected Route & Date
  final fromStation = const Station(code: 'NDLS', name: 'New Delhi', hindiName: 'नई दिल्ली', zone: 'NR', state: 'Delhi').obs;
  final toStation = const Station(code: 'BCT', name: 'Mumbai Central', hindiName: 'मुंबई सेंट्रल', zone: 'WR', state: 'Maharashtra').obs;
  final journeyDate = DateTime.now().obs;

  // Wallet
  final walletBalance = 2.00.obs;

  void swapStations() {
    final temp = fromStation.value;
    fromStation.value = toStation.value;
    toStation.value = temp;
  }

  void toggleServicesExpanded() {
    isServicesExpanded.value = !isServicesExpanded.value;
  }

  void updateTabIndex(int index) {
    currentTabIndex.value = index;
  }
}
