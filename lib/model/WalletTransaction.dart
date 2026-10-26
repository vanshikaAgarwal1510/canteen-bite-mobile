enum TransactionType { debit, credit }

class WalletTransaction {
  final int id;
  final String title;
  final String date;
  final double amount;
  final TransactionType type;
  final String status;

   WalletTransaction({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json){
    return WalletTransaction(
      id: json['id'],
      title: json['description'],
      date: json['createdAt'].toString(),
      amount: json['amount'],
      type: json['type'].toString().toLowerCase() =="credit"? TransactionType.credit:TransactionType.debit,
      status: json['status'],
    );
  }
}