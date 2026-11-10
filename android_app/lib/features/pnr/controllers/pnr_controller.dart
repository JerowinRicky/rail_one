import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/pnr_model.dart';
import '../../../data/services/mock_api_service.dart';

class PnrController extends GetxController {
  final pnrTextController = TextEditingController(text: '2451892019');
  final isLoading = false.obs;
  final pnrDetails = Rxn<PnrDetails>();
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkPnr('2451892019');
  }

  Future<void> checkPnr(String pnr) async {
    final cleanPnr = pnr.replaceAll(RegExp(r'\D'), '');
    if (cleanPnr.length != 10) {
      errorMessage.value = 'Please enter a valid 10-digit PNR number';
      return;
    }

    errorMessage.value = '';
    isLoading.value = true;
    try {
      final details = await MockApiService.getPnrStatus(cleanPnr);
      pnrDetails.value = details;
    } catch (e) {
      errorMessage.value = 'Unable to fetch PNR status. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pnrTextController.dispose();
    super.onClose();
  }
}
