class Bunga {
  final int? id;
  final double persen;
  final int? isaktif;

  Bunga({this.id, required this.persen, required this.isaktif});

  factory Bunga.fromJson(Map<String, dynamic> json) =>
      Bunga(id: json['id'], persen: json['persen'], isaktif: json['isaktif']);
}

class DataBunga {
  final List<Bunga> bungas;

  DataBunga({required this.bungas});

  factory DataBunga.fromJson(Map<String, dynamic> json) => DataBunga(
      bungas: List.from(
          json['data']['settingbungas'].map((bunga) => Bunga.fromJson(bunga))));
}

class ActiveBunga {
  final Bunga aktifBunga;

  ActiveBunga({required this.aktifBunga});

  factory ActiveBunga.fromModel(Map<String, dynamic> json) {
    return ActiveBunga(
      aktifBunga: Bunga.fromJson(json['data']['activebunga']),
    );
  }
}
