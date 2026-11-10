import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/pnr_model.dart';
import '../../../data/services/mock_api_service.dart';

class PnrStatusView extends StatefulWidget {
  const PnrStatusView({super.key});

  @override
  State<PnrStatusView> createState() => _PnrStatusViewState();
}

class _PnrStatusViewState extends State<PnrStatusView> {
  final pnrController = TextEditingController(text: '2451892019');
  PnrRecord? pnrData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPnr('2451892019');
  }

  void _fetchPnr(String pnr) async {
    setState(() => isLoading = true);
    final data = await MockApiService.getPnrStatus(pnr);
    setState(() {
      pnrData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('PNR Status Enquiry'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: pnrController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: 'Enter 10-digit PNR',
                        hintText: 'e.g. 2451892019',
                        counterText: '',
                        prefixIcon: Icon(Icons.confirmation_num_outlined, color: AppColors.primaryBlue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => _fetchPnr(pnrController.text),
                    child: const Text('Get Status'),
                  ),
                ],
              ),
            ),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              )
            else if (pnrData != null) ...[
              // Chart Status Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                color: pnrData!.chartPrepared ? AppColors.successGreenLight : AppColors.warningOrangeLight,
                child: Row(
                  children: [
                    Icon(
                      pnrData!.chartPrepared ? Icons.check_circle : Icons.info,
                      color: pnrData!.chartPrepared ? AppColors.successGreen : AppColors.warningOrange,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      pnrData!.chartPrepared ? 'Chart Prepared' : 'Chart Not Prepared',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: pnrData!.chartPrepared ? AppColors.successGreen : AppColors.warningOrange,
                      ),
                    ),
                  ],
                ),
              ),
              // Journey Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${pnrData!.trainNumber} - ${pnrData!.trainName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(pnrData!.journeyDate, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('${pnrData!.fromStation} -> ${pnrData!.toStation}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      Text('Class: ${pnrData!.reservedClass} • Boarding: ${pnrData!.boardingPoint}', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              // Passengers List
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Passenger Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Divider(height: 20),
                      ...pnrData!.passengers.map((p) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Passenger ${p.number}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    Text('Booking: ${p.bookingStatus}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.successGreenLight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '${p.currentStatus} (${p.coach}, ${p.berth})',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.successGreen),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

