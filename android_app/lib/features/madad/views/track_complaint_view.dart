import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class TrackComplaintView extends StatefulWidget {
  const TrackComplaintView({super.key});

  @override
  State<TrackComplaintView> createState() => _TrackComplaintViewState();
}

class _TrackComplaintViewState extends State<TrackComplaintView> {
  final refController = TextEditingController(text: 'RM-2026-11-849201');
  int selectedRating = 0;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is String) refController.text = args;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Track Rail Madad Grievance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: refController,
                    decoration: const InputDecoration(labelText: 'Grievance Reference ID'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Track'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Grievance ID: ${refController.text}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    const Text('Category: Cleanliness • Coach B2 Washroom', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    const Divider(height: 24),
                    const Text('Resolution Progress:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 12),
                    _buildStepItem('1. Registered via Mobile App', 'Today, 10:30 AM', true),
                    _buildStepItem('2. Assigned to On-Duty Train Staff', 'Today, 10:35 AM', true),
                    _buildStepItem('3. Cleanliness Action Initiated', 'Today, 10:45 AM', true),
                    _buildStepItem('4. Issue Resolved & Closed', 'Today, 11:10 AM', true),
                    const Divider(height: 24),
                    const Text('Rate Railway Service Quality:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFeedbackOption('Poor', Icons.sentiment_dissatisfied, 1, Colors.red),
                        _buildFeedbackOption('Average', Icons.sentiment_neutral, 2, Colors.amber),
                        _buildFeedbackOption('Good', Icons.sentiment_satisfied_alt, 3, Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(String title, String time, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? AppColors.successGreen : AppColors.textMuted, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title, style: TextStyle(fontWeight: isDone ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
          ),
          Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildFeedbackOption(String label, IconData icon, int rating, Color color) {
    final isSelected = selectedRating == rating;
    return GestureDetector(
      onTap: () {
        setState(() => selectedRating = rating);
        Get.snackbar('Thank you!', 'Your feedback helps improve Indian Railways.', backgroundColor: AppColors.successGreen, colorText: Colors.white);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? color : AppColors.cardBorder, width: isSelected ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

