class DataBunga {
  final List<Bunga> listBunga;
  final Bunga activeBunga;

  DataBunga({
    required this.listBunga,
    required this.activeBunga,
  });

  factory DataBunga.fromJson(Map<String, dynamic> json) {
    var listBungaJson = json["data"]["settingbungas"] as List<dynamic>;
    var listBunga =
        listBungaJson.map((bunga) => Bunga.fromModel(bunga)).toList();

    var activeBungaJson = json["data"]["activebunga"];
    var activeBunga = Bunga.fromModel(activeBungaJson);

    return DataBunga(
      listBunga: listBunga,
      activeBunga: activeBunga,
    );
  }
}

class Bunga {
  final int? id;
  final double persen;
  final int isActive;

  Bunga({
    this.id,
    required this.persen,
    required this.isActive,
  });

  factory Bunga.fromModel(Map<String, dynamic> json) {
    return Bunga(
      id: json["id"],
      persen: (json["persen"] as num).toDouble(),
      isActive: json["isaktif"],
    );
  }
}
