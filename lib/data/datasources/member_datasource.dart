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

    print(response.data);
    return DataMember.fromJson(response.data);
  }

  Future<MemberDetail> getMembersById(int id) async {
    final response = await _dio.get('/anggota/$id',
        options: Options(headers: {
          "Authorization": "Bearer ${_localStorage.read("token")}"
        }));

    print(response.data);
    return MemberDetail.fromJson(response.data);
  }

  Future addMember(Member member) async {
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
          "telepon": member.telepon,
          "status_aktif": member.status_aktif
        },
        options: Options(headers: {
          "Authorization": "Bearer ${_localStorage.read("token")}"
        }));
  }

  Future goLogin(String email, String password) async {
    final response =
        await _dio.post('/login', data: {"email": email, "password": password});

    _localStorage.write('token', response.data['data']['token']);

    return response;
  }

  Future goRegister(User user, String password) async {
    final response = await _dio.post('/register',
        data: {"email": user.email, "name": user.name, "password": password});

    return response;
  }

  Future<User> goUser() async {
    final response = await _dio.get('/user',
        options: Options(headers: {
          'Authorization': 'Bearer ${_localStorage.read('token')}'
        }));

    return User.fromModel(response.data);
  }

  Future goLogout() async {
    return await _dio.get('/logout', options: _auth);
  }
}
