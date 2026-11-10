import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/complaint_model.dart';
import '../../../data/services/mock_api_service.dart';

class RailMadadView extends StatefulWidget {
  const RailMadadView({super.key});

  @override
  State<RailMadadView> createState() => _RailMadadViewState();
}

class _RailMadadViewState extends State<RailMadadView> {
  GrievanceType selectedType = GrievanceType.train;
  final idController = TextEditingController(text: '2451892019');
  final descController = TextEditingController();
  String selectedCategory = 'Cleanliness';
  String selectedSubCategory = 'Coach Washroom Unclean';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Rail Madad - Lodge Grievance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Train vs Station Mode Toggle
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Train Complaint')),
                    selected: selectedType == GrievanceType.train,
                    onSelected: (val) => setState(() => selectedType = GrievanceType.train),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('Station Complaint')),
                    selected: selectedType == GrievanceType.station,
                    onSelected: (val) => setState(() => selectedType = GrievanceType.station),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        labelText: selectedType == GrievanceType.train ? 'PNR Number / Train Number' : 'Station Code / Name',
                        prefixIcon: const Icon(Icons.confirmation_num_outlined, color: AppColors.primaryBlue),
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(labelText: 'Grievance Category'),
                      items: ['Cleanliness', 'Medical Assistance', 'Catering & Food', 'Electrical Equipment', 'Security']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) => setState(() => selectedCategory = v ?? 'Cleanliness'),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: descController,
                      maxLines: 4,
                      maxLength: 500,
                      decoration: const InputDecoration(
                        labelText: 'Description of Grievance',
                        hintText: 'Please describe the incident in detail...',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Attach Incident Photo'),
                      onPressed: () {
                        Get.snackbar('Photo Attached', 'Sample photo attached for verification');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await MockApiService.submitGrievance(
                  type: selectedType,
                  pnrOrStation: idController.text,
                  category: selectedCategory,
                  subCategory: selectedSubCategory,
                  description: descController.text,
                );

                Get.defaultDialog(
                  title: 'Grievance Registered',
                  middleText: 'Reference ID: ${result.referenceNumber}\nAssigned to On-Duty Railway Staff.',
                  textConfirm: 'Track Status',
                  confirmTextColor: Colors.white,
                  buttonColor: AppColors.primaryBlue,
                  onConfirm: () {
                    Get.back();
                    Get.toNamed('/track-complaint', arguments: result.referenceNumber);
                  },
                );
              },
              child: const Text('Submit to Railway Board'),
            ),
          ],
        ),
      ),
    );
  }
}

