enum TransactionType { credit, debit }
enum TransactionStatus { success, pending, failed }

class WalletTransaction {
  final String id;
  final String description;
  final double amount;
  final double bonusCashback;
  final TransactionType type;
  final TransactionStatus status;
  final DateTime timestamp;
  final String? ticketId;

  const WalletTransaction({
    required this.id,
    required this.description,
    required this.amount,
    this.bonusCashback = 0.0,
    required this.type,
    required this.status,
    required this.timestamp,
    this.ticketId,
  });
}

class WalletState {
  final double balance;
  final double bonusPct;
  final List<WalletTransaction> transactions;

  const WalletState({
    required this.balance,
    this.bonusPct = 3.0,
    required this.transactions,
  });
}
