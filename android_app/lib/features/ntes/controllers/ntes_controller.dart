import 'package:get/get.dart';
import '../../../data/models/train_model.dart';
import '../../../data/services/mock_api_service.dart';

class NtesController extends GetxController {
  final trainNumberInput = '12952'.obs;
  final isLoadingCoach = false.obs;
  final coachRake = <CoachInfo>[].obs;
  final selectedCoach = Rxn<CoachInfo>();
  final isRakeReversed = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCoachPosition('12952');
  }

  Future<void> loadCoachPosition(String trainNumber) async {
    isLoadingCoach.value = true;
    try {
      final rake = await MockApiService.getCoachPosition(trainNumber);
      coachRake.assignAll(rake);
      if (rake.length > 6) {
        selectedCoach.value = rake[6]; // Select B2 as default
      }
    } finally {
      isLoadingCoach.value = false;
    }
  }

  void selectCoach(CoachInfo coach) {
    selectedCoach.value = coach;
  }

  void flipDirection() {
    isRakeReversed.value = !isRakeReversed.value;
    coachRake.assignAll(coachRake.reversed.toList());
  }
}
