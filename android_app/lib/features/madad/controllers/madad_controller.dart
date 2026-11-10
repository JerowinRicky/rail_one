import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/complaint_model.dart';

class MadadController extends GetxController {
  final isTrainMode = true.obs;
  final pnrOrStationController = TextEditingController(text: '2451892019');
  final descriptionController = TextEditingController();
  final selectedCategory = 'Cleanliness'.obs;
  final selectedSubCategory = 'Coach Washroom Unclean'.obs;
  final selectedPhotoPath = RxnString();
  final isSubmitting = false.obs;

  final categories = const [
    'Cleanliness',
    'Medical Assistance',
    'Food & Catering',
    'Electrical & Air Conditioning',
    'Punctuality',
    'Security / RPF',
  ];

  final activeGrievances = <GrievanceComplaint>[
    GrievanceComplaint(
      referenceNumber: 'RM-2026-11-098231',
      complaintType: 'TRAIN',
      pnrOrStation: '2451892019',
      incidentDate: DateTime.now().subtract(const Duration(hours: 4)),
      category: 'Cleanliness',
      subCategory: 'Coach Washroom Unclean',
      description: 'Coach B2 washroom requires cleaning and liquid soap refill.',
      status: 'IN_PROGRESS',
    ),
  ].obs;

  void toggleMode(bool train) {
    isTrainMode.value = train;
    pnrOrStationController.clear();
  }

  Future<String> submitGrievance() async {
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 1));
    final ref = 'RM-2026-11-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    final newComplaint = GrievanceComplaint(
      referenceNumber: ref,
      complaintType: isTrainMode.value ? 'TRAIN' : 'STATION',
      pnrOrStation: pnrOrStationController.text,
      incidentDate: DateTime.now(),
      category: selectedCategory.value,
      subCategory: selectedSubCategory.value,
      description: descriptionController.text,
      status: 'REGISTERED',
      photoPath: selectedPhotoPath.value,
    );

    activeGrievances.insert(0, newComplaint);
    descriptionController.clear();
    selectedPhotoPath.value = null;
    isSubmitting.value = false;
    return ref;
  }

  void rateSatisfaction(String refNumber, int rating) {
    final idx = activeGrievances.indexWhere((g) => g.referenceNumber == refNumber);
    if (idx != -1) {
      final existing = activeGrievances[idx];
      activeGrievances[idx] = GrievanceComplaint(
        referenceNumber: existing.referenceNumber,
        complaintType: existing.complaintType,
        pnrOrStation: existing.pnrOrStation,
        incidentDate: existing.incidentDate,
        category: existing.category,
        subCategory: existing.subCategory,
        description: existing.description,
        status: 'RESOLVED',
        photoPath: existing.photoPath,
        satisfactionRating: rating,
      );
    }
  }

  @override
  void onClose() {
    pnrOrStationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
