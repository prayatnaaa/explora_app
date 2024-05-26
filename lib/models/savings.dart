class DataSavings {
  final List<Savings> tabungan;

  DataSavings({required this.tabungan});

  factory DataSavings.fromJson(Map<String, dynamic> json) => DataSavings(
      tabungan: List.from(
          json['data']['tabungan'].map((data) => Savings.fromModel(data))));
}

class Savings {
  final int? id;
  final int trx_id;
  final int trx_nominal;
  Savings({this.id, required this.trx_id, required this.trx_nominal});

  factory Savings.fromModel(Map<String, dynamic> json) =>
      Savings(trx_id: json['trx_id'], trx_nominal: json['trx_nominal']);
}
