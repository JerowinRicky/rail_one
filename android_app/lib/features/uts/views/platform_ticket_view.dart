import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/ticket_model.dart';
import '../../../data/services/mock_api_service.dart';

class PlatformTicketView extends StatefulWidget {
  const PlatformTicketView({super.key});

  @override
  State<PlatformTicketView> createState() => _PlatformTicketViewState();
}

class _PlatformTicketViewState extends State<PlatformTicketView> {
  int passengerCount = 1;
  String currentStation = 'NDLS';

  double get fare => 10.0 * passengerCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Platform Ticket Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Station (GPS Detected):', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Text('$currentStation - New Delhi', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                    const Divider(height: 24),
                    const Text('Number of Persons:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      children: [1, 2, 3, 4].map((count) {
                        final isSelected = count == passengerCount;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => passengerCount = count),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primaryBlue : AppColors.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.cardBorder),
                              ),
                              child: Text(
                                '$count',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Divider(height: 24),
                    const Text('Validity: 2 Hours from time of booking', style: TextStyle(color: AppColors.warningOrange, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Fare:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('₹ ${fare.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final ticket = await MockApiService.bookUtsTicket(
                  source: currentStation,
                  dest: currentStation,
                  type: TicketType.platform,
                  adults: passengerCount,
                );
                Get.offNamed('/ticket-view', arguments: ticket);
              },
              child: const Text('Book Platform Pass'),
            ),
          ],
        ),
      ),
    );
  }
}

