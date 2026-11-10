import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class BillDeskModal extends StatelessWidget {
  final double amount;
  final VoidCallback onSuccess;

  const BillDeskModal({super.key, required this.amount, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.lock_outline, color: AppColors.successGreen, size: 20),
                  SizedBox(width: 8),
                  Text('BillDesk Secure Checkout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Payable:', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              Text('₹ ${amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Select Payment Option:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 10),
          _buildPaymentTile(
            title: 'UPI (GPay / PhonePe / Paytm / BHIM)',
            subtitle: 'Instant transfer via UPI App',
            icon: Icons.qr_code_2_rounded,
            onTap: onSuccess,
          ),
          _buildPaymentTile(
            title: 'Debit / Credit Card',
            subtitle: 'Visa, MasterCard, RuPay',
            icon: Icons.credit_card_rounded,
            onTap: onSuccess,
          ),
          _buildPaymentTile(
            title: 'NetBanking',
            subtitle: 'All Major Indian Banks',
            icon: Icons.account_balance_rounded,
            onTap: onSuccess,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildPaymentTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}

