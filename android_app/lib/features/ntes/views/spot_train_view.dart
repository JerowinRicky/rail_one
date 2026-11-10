import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SpotYourTrainView extends StatefulWidget {
  const SpotYourTrainView({super.key});

  @override
  State<SpotYourTrainView> createState() => _SpotYourTrainViewState();
}

class _SpotYourTrainViewState extends State<SpotYourTrainView> {
  final trainController = TextEditingController(text: '12952');

  final List<Map<String, dynamic>> stations = [
    {'name': 'New Delhi (NDLS)', 'time': '16:55 (Departed)', 'passed': true, 'platform': '1'},
    {'name': 'Mathura Junction (MTJ)', 'time': '18:25 (Passed)', 'passed': true, 'platform': '2'},
    {'name': 'Kota Junction (KOTA)', 'time': '21:05 (Departed)', 'passed': true, 'platform': '1'},
    {'name': 'Ratlam Junction (RTM)', 'time': '00:15 (Arriving in 10m)', 'current': true, 'platform': '4', 'delay': 5},
    {'name': 'Vadodara Junction (BRC)', 'time': '03:45 (Scheduled)', 'passed': false, 'platform': '3'},
    {'name': 'Surat (ST)', 'time': '05:18 (Scheduled)', 'passed': false, 'platform': '1'},
    {'name': 'Mumbai Central (BCT)', 'time': '08:35 (Scheduled)', 'passed': false, 'platform': '5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Spot Your Train'),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('12952 - MUMBAI RAJDHANI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.warningOrangeLight, borderRadius: BorderRadius.circular(4)),
                      child: const Text('5m Late', style: TextStyle(color: AppColors.warningOrange, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text('Approaching: Ratlam Jn (Platform 4)', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: stations.length,
              itemBuilder: (ctx, idx) {
                final s = stations[idx];
                final isPassed = s['passed'] == true;
                final isCurrent = s['current'] == true;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline indicator column
                    Column(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCurrent
                                ? AppColors.warningOrange
                                : isPassed
                                    ? AppColors.successGreen
                                    : Colors.grey.shade400,
                            border: isCurrent ? Border.all(color: Colors.white, width: 3) : null,
                            boxShadow: isCurrent ? [BoxShadow(color: AppColors.warningOrange.withOpacity(0.4), blurRadius: 6, spreadRadius: 2)] : null,
                          ),
                        ),
                        if (idx < stations.length - 1)
                          Container(
                            width: 2.5,
                            height: 60,
                            color: isPassed ? AppColors.successGreen : Colors.grey.shade300,
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    // Station Info
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s['name'],
                                  style: TextStyle(
                                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                                    fontSize: 14,
                                    color: isCurrent ? AppColors.primaryBlue : AppColors.textPrimary,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text('PF ${s['platform']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s['time'],
                              style: TextStyle(
                                fontSize: 12,
                                color: isCurrent ? AppColors.warningOrange : AppColors.textSecondary,
                                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

