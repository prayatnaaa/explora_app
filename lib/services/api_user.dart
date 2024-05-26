import 'package:dio/dio.dart';
import 'package:explora_app/components/success_register_modal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

mixin UserController {
  final _dio = Dio();
  final _apiURL = 'https://mobileapis.manpits.xyz/api';
  final _storage = GetStorage();

  void goLogin(BuildContext context, email, password, route) async {
    try {
      final response = await _dio
          .post('$_apiURL/login', data: {'email': email, 'password': password});
      print(response.data);

      if (response.statusCode == 200) {
        _storage.write('token', response.data['data']['token']);
        await Navigator.pushReplacementNamed(context, route);
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
      print(e.message);
    }
  }

  void goRegister(BuildContext context, name, email, password) async {
    try {
      final response = await _dio.post('$_apiURL/register',
          data: {'name': name, 'email': email, 'password': password});
      print(response.data);
      if (response.statusCode == 200) {
        SuccesRegisterModal;
        await Navigator.pushReplacementNamed(context, '/login');
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }
}
