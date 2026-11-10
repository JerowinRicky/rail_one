import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/ticket_model.dart';
import '../../../data/services/mock_api_service.dart';

class UtsBookingView extends StatefulWidget {
  const UtsBookingView({super.key});

  @override
  State<UtsBookingView> createState() => _UtsBookingViewState();
}

class _UtsBookingViewState extends State<UtsBookingView> {
  String sourceStation = 'NDLS';
  String destStation = 'GZB';
  int adultCount = 1;
  int childCount = 0;
  String trainType = 'Ordinary';
  String classType = 'Second Class (II)';
  bool isPaperless = true;

  double get calculatedFare => 15.0 * adultCount + 10.0 * childCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('UTS Unreserved Ticket'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Geofence GPS Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.successGreenLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.successGreen.withOpacity(0.4)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.gps_fixed, color: AppColors.successGreen, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'GPS Verified: Within 5 km of station & outside tracks (Paperless Eligible)',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.successGreen),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // Station Selection Card
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Source:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('$sourceStation (New Delhi)', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Destination:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('$destStation (Ghaziabad)', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Passenger & Class Options Card
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Adult Passengers (12+ yrs):', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        DropdownButton<int>(
                          value: adultCount,
                          items: [1, 2, 3, 4].map((c) => DropdownMenuItem(value: c, child: Text('$c'))).toList(),
                          onChanged: (v) => setState(() => adultCount = v ?? 1),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Class:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        DropdownButton<String>(
                          value: classType,
                          items: ['Second Class (II)', 'First Class (I)']
                              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                              .toList(),
                          onChanged: (v) => setState(() => classType = v ?? 'Second Class (II)'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Total Fare Display
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
                  Text(
                    '₹ ${calculatedFare.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final ticket = await MockApiService.bookUtsTicket(
                  source: sourceStation,
                  dest: destStation,
                  type: TicketType.journey,
                  adults: adultCount,
                  children: childCount,
                );
                Get.offNamed('/ticket-view', arguments: ticket);
              },
              child: const Text('Book Ticket via R-Wallet'),
            ),
          ],
        ),
      ),
    );
  }
}

