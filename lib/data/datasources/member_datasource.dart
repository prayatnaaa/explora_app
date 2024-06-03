import 'package:dio/dio.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/models/user.dart';
import 'package:get_storage/get_storage.dart';

final _dio = Dio(BaseOptions(baseUrl: 'https://mobileapis.manpits.xyz/api'));
final _localStorage = GetStorage();

final _auth = Options(
    headers: {"Authorization": "Bearer ${_localStorage.read("token")}"});

class RemoteDataSource {
  Future<DataMember> getMembers() async {
    final response = await _dio.get('/anggota',
        options: Options(headers: {
          "Authorization": "Bearer ${_localStorage.read("token")}"
        }));
    return DataMember.fromJson(response.data);
  }

  Future<DataMember> getMembersById(int id) async {
    try {
      final response = await _dio.get('/anggota/$id',
          options: Options(headers: {
            "Authorization": "Bearer ${_localStorage.read("token")}"
          }));
      return DataMember.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
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

      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteMember(int? id) async {
    try {
      return await _dio.delete("/anggota/$id",
          options: Options(headers: {
            "Authorization": "Bearer ${_localStorage.read("token")}"
          }));
    } on DioException catch (e) {
      print(e.message);
    }
  }

  Future editMember(Member member) async {
    try {
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
    } on DioException catch (e) {
      print(e.message);
    }
  }

  Future goLogin(String email, String password) async {
    try {
      final response = await _dio
          .post('/login', data: {"email": email, "password": password});

      print(response.data);
      _localStorage.write('token', response.data['data']['token']);

      return response;
    } on DioException catch (e) {
      print(e.message);
    }
  }

  Future goRegister(User user, String password) async {
    try {
      final response = await _dio.post('/register',
          data: {"email": user.email, "name": user.name, "password": password});
      print(response.data);

      return response;
    } on DioException catch (e) {
      print(e.message);
    }
  }

  Future<User> goUser() async {
    try {
      final response = await _dio.get('/user',
          options: Options(headers: {
            'Authorization': 'Bearer ${_localStorage.read('token')}'
          }));

      print(response);

      return User.fromModel(response.data);
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.error);
    }
  }

  Future goLogout() async {
    try {
      return await _dio.get('/logout', options: _auth);
    } on DioException catch (e) {
      print(e.message);
    }
  }
}
