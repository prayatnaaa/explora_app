class TransactionData {
  final List<Transaction> transactions;

  TransactionData({required this.transactions});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
        transactions: List.from(json['data']['tabungan']
            .map((transactions) => Transaction.fromModel(transactions))));
  }
}

class Transaction {
  final int id;
  final int type;
  final int amount;
  final DateTime? date;

  Transaction(
      {required this.id, required this.type, required this.amount, this.date});

  factory Transaction.fromModel(Map<String, dynamic> json) => Transaction(
      id: json['id'],
      type: json['trx_id'],
      date: DateTime.parse(json['trx_tanggal']),
      amount: json['trx_nominal']);
}

class Saldo {
  final int saldo;

  Saldo({required this.saldo});

  factory Saldo.fromJson(Map<String, dynamic> json) {
    return Saldo(saldo: json['data']['saldo']);
  }
}
