import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../data/models/ticket_model.dart';

class DigitalTicketView extends StatefulWidget {
  final String? ticketNumber;
  final String? trainName;
  final String? sourceStation;
  final String? destStation;
  final String? pnr;
  final String? fare;

  const DigitalTicketView({
    super.key,
    this.ticketNumber,
    this.trainName,
    this.sourceStation,
    this.destStation,
    this.pnr,
    this.fare,
  });

  @override
  State<DigitalTicketView> createState() => _DigitalTicketViewState();
}

class _DigitalTicketViewState extends State<DigitalTicketView> {
  late DigitalTicket ticket;
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (widget.ticketNumber != null) {
      final now = DateTime.now();
      ticket = DigitalTicket(
        ticketId: widget.ticketNumber!,
        type: TicketType.journey,
        mode: TicketMode.paperless,
        sourceStation: widget.sourceStation ?? 'NDLS',
        sourceStationName: widget.sourceStation ?? 'New Delhi',
        destinationStation: widget.destStation ?? 'BCT',
        destinationStationName: widget.destStation ?? 'Mumbai Central',
        trainType: widget.trainName ?? 'Suburban Express',
        classType: 'Second Class (2S)',
        adultCount: 1,
        childCount: 0,
        fare: double.tryParse((widget.fare ?? '29.10').replaceAll(RegExp(r'[^0-9.]'), '')) ?? 29.10,
        bookingTime: now,
        validTill: now.add(const Duration(hours: 3)),
        qrPayload: 'CRIS:UTS:${widget.ticketNumber}:${widget.sourceStation}:${widget.destStation}:${widget.fare}',
        barcodeNumber: '8492019842',
      );
    } else if (args is DigitalTicket) {
      ticket = args;
    } else {
      // Default sample ticket
      final now = DateTime.now();
      ticket = DigitalTicket(
        ticketId: 'UTS8492019',
        type: TicketType.journey,
        mode: TicketMode.paperless,
        sourceStation: 'NDLS',
        sourceStationName: 'New Delhi',
        destinationStation: 'GZB',
        destinationStationName: 'Ghaziabad',
        trainType: 'Ordinary',
        classType: 'Second Class (II)',
        adultCount: 1,
        childCount: 0,
        fare: 15.00,
        bookingTime: now,
        validTill: now.add(const Duration(hours: 3)),
        qrPayload: 'CRIS:UTS:8492019:NDLS:GZB:15.00',
        barcodeNumber: '8492019842',
      );
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _currentTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Active Digital Ticket'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed('/home'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Live Dynamic Watermark / Running Clock Banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.successGreenLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time_filled, color: AppColors.successGreen, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Live Anti-Tamper Time: ${DateFormat('HH:mm:ss • dd-MMM-yyyy').format(_currentTime)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.successGreen),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Digital Ticket Card
            Card(
              margin: EdgeInsets.zero,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(AppAssets.irLogoBlue, height: 36, errorBuilder: (ctx, err, stack) => const Icon(Icons.train, color: AppColors.primaryBlue)),
                        Text(
                          'HAPPY JOURNEY',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 12, letterSpacing: 1.2),
                        ),
                        Image.asset(AppAssets.crisLogo, height: 32, errorBuilder: (ctx, err, stack) => const Icon(Icons.verified, color: AppColors.primaryBlue)),
                      ],
                    ),
                    const Divider(height: 24),
                    Text(
                      'PAPERLESS JOURNEY TICKET',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue.shade900),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ticket.sourceStation, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                              Text(ticket.sourceStationName, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_rounded, color: AppColors.primaryBlue, size: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(ticket.destinationStation, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                              Text(ticket.destinationStationName, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Adult: ${ticket.adultCount} • Child: ${ticket.childCount}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('Class: ${ticket.classType}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Booked: ${DateFormat('dd-MMM HH:mm').format(ticket.bookingTime)}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        Text('Valid till: ${DateFormat('dd-MMM HH:mm').format(ticket.validTill)}', style: const TextStyle(fontSize: 12, color: AppColors.warningOrange, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 24),
                    // Scannable Optical QR Code
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: QrImageView(
                          data: ticket.qrPayload,
                          version: QrVersions.auto,
                          size: 160.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Ticket No: ${ticket.ticketId}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fare Paid: ₹ ${ticket.fare.toStringAsFixed(2)} (via R-Wallet)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.successGreen),
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
}

