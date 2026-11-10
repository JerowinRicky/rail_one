import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/wallet_model.dart';
import '../../home/controllers/home_controller.dart';

class WalletController extends GetxController {
  final rechargeAmountController = TextEditingController(text: '500');
  final selectedAmount = 500.0.obs;
  final cashbackBonus = 15.0.obs; // 3% of 500
  final isProcessingPayment = false.obs;

  final transactions = <WalletTransaction>[
    WalletTransaction(
      id: 'TXN91823019',
      title: 'UTS Journey Ticket - NDLS to GZB',
      description: '2 Adults • Second Class Ordinary',
      amount: 30.00,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: TransactionType.debit,
    ),
    WalletTransaction(
      id: 'TXN82710394',
      title: 'R-Wallet Top-up + 3% Bonus Cashback',
      description: 'BillDesk UPI • Axis Bank',
      amount: 515.00,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.credit,
    ),
    WalletTransaction(
      id: 'TXN71829031',
      title: 'Platform Ticket - New Delhi',
      description: '1 Visitor Pass • Valid 2 Hours',
      amount: 10.00,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.debit,
    ),
  ].obs;

  void selectAmount(double amount) {
    selectedAmount.value = amount;
    rechargeAmountController.text = amount.toInt().toString();
    calculateCashback(amount);
  }

  void calculateCashback(double amount) {
    cashbackBonus.value = amount * 0.03; // 3% bonus
  }

  Future<bool> processRecharge(double amount) async {
    isProcessingPayment.value = true;
    await Future.delayed(const Duration(seconds: 2));
    final totalCredit = amount + (amount * 0.03);

    // Update Home balance
    final homeController = Get.find<HomeController>();
    homeController.updateWalletBalance(homeController.rWalletBalance.value + totalCredit);

    // Add to ledger
    transactions.insert(
      0,
      WalletTransaction(
        id: 'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(4)}',
        title: 'R-Wallet Top-up + 3% Cashback',
        description: 'BillDesk Gateway • ₹${amount.toStringAsFixed(0)} + ₹${(amount * 0.03).toStringAsFixed(1)} Bonus',
        amount: totalCredit,
        timestamp: DateTime.now(),
        type: TransactionType.credit,
      ),
    );

    isProcessingPayment.value = false;
    return true;
  }

  @override
  void onClose() {
    rechargeAmountController.dispose();
    super.onClose();
  }
}
