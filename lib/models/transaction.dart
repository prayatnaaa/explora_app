import 'package:flutter/material.dart';

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

class TransactionType {
  final int id;
  final String type;
  final int multiply;
  final IconData icon;

  TransactionType({
    required this.id,
    required this.type,
    required this.multiply,
    required this.icon,
  });

  static final List<TransactionType> transactionsType = [
    // TransactionType(
    //     id: 1, type: "Saldo Awal", multiply: 1, icon: Icons.account_balance),
    TransactionType(id: 2, type: "Simpanan", multiply: 1, icon: Icons.savings),
    TransactionType(
        id: 3, type: "Penarikan", multiply: -1, icon: Icons.money_off),
    // TransactionType(id: 4, type: "Bunga Simpanan", multiply: 1, icon: Icons.interest),
    TransactionType(
        id: 5, type: "Koreksi Penambahan", multiply: 1, icon: Icons.add_circle),
    TransactionType(
        id: 6,
        type: "Koreksi Pengurangan",
        multiply: 1,
        icon: Icons.remove_circle),
  ];
}
