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
}
