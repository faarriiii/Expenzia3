class TransactionModel {
  final int? id;
  final String transactionType;
  final String name;
  final double amount;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.transactionType,
    required this.name,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_type': transactionType,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      transactionType: map['transaction_type'] as String,
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
    );
  }
}