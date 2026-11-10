import 'package:get/get.dart';
import '../../../data/models/station_model.dart';
import '../../../data/models/train_model.dart';
import '../../../data/services/mock_api_service.dart';

class TrainSearchController extends GetxController {
  final originStation = const Station(
    code: 'NDLS',
    name: 'New Delhi',
    hindiName: 'नई दिल्ली',
    zone: 'NR',
    state: 'Delhi',
    latitude: 28.6431,
    longitude: 77.2197,
  ).obs;

  final destinationStation = const Station(
    code: 'BCT',
    name: 'Mumbai Central',
    hindiName: 'मुंबई सेंट्रल',
    zone: 'WR',
    state: 'Maharashtra',
    latitude: 18.9696,
    longitude: 72.8193,
  ).obs;

  final selectedJourneyDate = DateTime.now().add(const Duration(days: 2)).obs;
  final selectedQuota = 'General'.obs;
  final isLoadingTrains = false.obs;
  final searchResults = <Train>[].obs;

  void swapStations() {
    final temp = originStation.value;
    originStation.value = destinationStation.value;
    destinationStation.value = temp;
  }

  void setOrigin(Station station) {
    originStation.value = station;
  }

  void setDestination(Station station) {
    destinationStation.value = station;
  }

  void setDate(DateTime date) {
    selectedJourneyDate.value = date;
  }

  void setQuota(String quota) {
    selectedQuota.value = quota;
  }

  Future<void> searchTrains() async {
    isLoadingTrains.value = true;
    try {
      final results = await MockApiService.searchTrains(
        originStation.value.code,
        destinationStation.value.code,
        selectedJourneyDate.value.toIso8601String(),
      );
      searchResults.assignAll(results);
    } finally {
      isLoadingTrains.value = false;
    }
  }
}
