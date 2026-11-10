import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../home/controllers/home_controller.dart';
import '../../payments/views/billdesk_modal.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final homeCtrl = Get.find<HomeController>();
  final amountController = TextEditingController(text: '500');

  final List<Map<String, dynamic>> transactions = [
    {'desc': 'Recharge via UPI', 'amount': '+ ₹500.00', 'isCredit': true, 'date': 'Today, 10:20 AM'},
    {'desc': 'Cashback Bonus (3%)', 'amount': '+ ₹15.00', 'isCredit': true, 'date': 'Today, 10:20 AM'},
    {'desc': 'UTS Ticket NDLS->GZB', 'amount': '- ₹15.00', 'isCredit': false, 'date': 'Yesterday, 04:15 PM'},
    {'desc': 'Platform Ticket NDLS', 'amount': '- ₹10.00', 'isCredit': false, 'date': '08-Nov, 02:30 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('rWallet'.tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.walletGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('rWallet'.tr, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.accentGold, borderRadius: BorderRadius.circular(4)),
                        child: const Text('3% Cashback', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Text(
                        '₹ ${homeCtrl.walletBalance.value.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 12),
                  const Text('Zero payment gateway surcharge on all tickets', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Quick Top-up Chips
            const Text('Select Recharge Amount:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              children: [100, 200, 500, 1000].map((amt) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        side: const BorderSide(color: AppColors.primaryBlue),
                      ),
                      onPressed: () => amountController.text = '$amt',
                      child: Text('₹$amt', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Custom Amount (₹)',
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                final double? amt = double.tryParse(amountController.text);
                if (amt != null && amt >= 100) {
                  Get.bottomSheet(
                    BillDeskModal(
                      amount: amt,
                      onSuccess: () {
                        final bonus = amt * 0.03;
                        homeCtrl.walletBalance.value += (amt + bonus);
                        Get.back();
                        Get.snackbar(
                          'Recharge Successful',
                          '₹$amt added + ₹$bonus Cashback Bonus credited!',
                          backgroundColor: AppColors.successGreen,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                    isScrollControlled: true,
                  );
                } else {
                  Get.snackbar('Error', 'Minimum recharge amount is ₹100');
                }
              },
              child: const Text('Proceed to Pay via BillDesk'),
            ),
            const SizedBox(height: 24),
            const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            ...transactions.map((tx) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      tx['isCredit'] ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                      color: tx['isCredit'] ? AppColors.successGreen : AppColors.dangerRed,
                    ),
                    title: Text(tx['desc'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    subtitle: Text(tx['date'], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    trailing: Text(
                      tx['amount'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: tx['isCredit'] ? AppColors.successGreen : AppColors.dangerRed,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

