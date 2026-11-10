import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/train_model.dart';
import '../../../data/services/mock_api_service.dart';

class TrainResultsView extends StatefulWidget {
  const TrainResultsView({super.key});

  @override
  State<TrainResultsView> createState() => _TrainResultsViewState();
}

class _TrainResultsViewState extends State<TrainResultsView> {
  String from = 'NDLS';
  String to = 'BCT';
  String date = '2026-11-15';
  List<Train> trains = [];
  bool isLoading = true;
  String selectedQuota = 'General';

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      from = args['from'] ?? 'NDLS';
      to = args['to'] ?? 'BCT';
      date = args['date'] ?? '2026-11-15';
    }
    _loadTrains();
  }

  void _loadTrains() async {
    setState(() => isLoading = true);
    final results = await MockApiService.searchTrains(from, to, date);
    setState(() {
      trains = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$from -> $to', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(date, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Quota Selector Bar
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Quota:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                DropdownButton<String>(
                  value: selectedQuota,
                  underline: const SizedBox(),
                  items: ['General', 'Tatkal', 'Ladies', 'Lower Berth']
                      .map((q) => DropdownMenuItem(value: q, child: Text(q, style: const TextStyle(fontSize: 13))))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedQuota = val);
                  },
                ),
              ],
            ),
          ),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: trains.length,
                itemBuilder: (ctx, idx) {
                  final train = trains[idx];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${train.trainNumber} - ${train.trainName}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
                              ),
                              Row(
                                children: train.runDays
                                    .map((d) => Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryBlue.withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                          child: Text(d, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(train.departureTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                                  Text(train.departureStation, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(train.duration, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                  const Icon(Icons.arrow_forward_rounded, color: AppColors.primaryBlue, size: 20),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(train.arrivalTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                                  Text(train.arrivalStation, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          // Class Availability Chips
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: train.classes.map((cls) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: cls.isAvailable ? AppColors.successGreenLight : AppColors.warningOrangeLight,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: cls.isAvailable ? AppColors.successGreen : AppColors.warningOrange,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(cls.classCode, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                          const SizedBox(width: 6),
                                          Text('₹ ${cls.fare.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        cls.status,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: cls.isAvailable ? AppColors.successGreen : AppColors.warningOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

