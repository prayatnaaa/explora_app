import 'package:dio/dio.dart';
import 'package:explora_app/models/member.dart';
import 'package:get_storage/get_storage.dart';

class RemoteDataSource {
  final _dio = Dio(BaseOptions(baseUrl: 'https://mobileapis.manpits.xyz/api'));
  final _localStorage = GetStorage();

  Future<DataMember> getMembers() async {
    final response = await _dio.get('/anggota',
        options: Options(headers: {
          "Authorization": "Bearer ${_localStorage.read("token")}"
        }));
    return DataMember.fromJson(response.data);
  }

  Future addMember(Member member) async {
    try {
      final response = await _dio.post('/anggota',
          data: {
            "nomor_induk": member.nomor_induk,
            "nama": member.nama,
            "alamat": member.alamat,
            "tgl_lahir": member.tgl_lahir,
            "telepon": member.telepon
          },
          options: Options(headers: {
            "Authorization": "Bearer ${_localStorage.read("token")}"
          }));

      print(response);

      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteMember(int? id) async {
    return await _dio.delete("/anggota/$id",
        options: Options(headers: {
          "Authorization": "Bearer ${_localStorage.read("token")}"
        }));
  }

  Future editMember(Member member) async {
    return await _dio.put("/anggota/${member.id}",
        data: {
          "nomor_induk": member.nomor_induk,
          "nama": member.nama,
          "alamat": member.alamat,
          "tgl_lahir": member.tgl_lahir,
          "telepon": member.telepon
        },
        options: Options(headers: {
          "Authorization": "Bearer ${_localStorage.read("token")}"
        }));
  }
}
