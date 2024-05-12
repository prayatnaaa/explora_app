class DataMember {
  final List<Member> anggotas;
  DataMember({required this.anggotas});
  factory DataMember.fromJson(Map<String, dynamic> json) => DataMember(
      anggotas: List.from(
          json['data']['anggotas'].map((member) => Member.fromModel(member))));
}

class Member {
  final int? id;
  final int nomor_induk;
  final String nama;
  final String alamat;
  final String tgl_lahir;
  final String telepon;
  final String? image_url;
  final int? status_aktif;

  Member(
      {this.id,
      required this.nomor_induk,
      required this.nama,
      required this.alamat,
      required this.tgl_lahir,
      required this.telepon,
      this.image_url,
      this.status_aktif});

  factory Member.fromModel(Map<String, dynamic> json) => Member(
      id: json['id'],
      nomor_induk: json['nomor_induk'],
      nama: json['nama'],
      alamat: json['alamat'],
      tgl_lahir: json['tgl_lahir'],
      telepon: json['telepon'],
      image_url: json['image_url'],
      status_aktif: json['id']);
}
