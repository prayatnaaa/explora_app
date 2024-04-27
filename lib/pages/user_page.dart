import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String userName = '';
  String userEmail = '';

  final _storage = GetStorage();
  final _dio = Dio();
  final _apiURL = 'https://mobileapis.manpits.xyz/api';

  void goUser() async {
    try {
      final response = await _dio.get('$_apiURL/user',
          options: Options(
              headers: {'Authorization': 'Bearer ${_storage.read('token')}'}));
      print(response.data['data']['user']['name']);
      if (response.statusCode == 200) {
        setState(() {
          userName = jsonEncode(response.data['data']['user']['name']);
          userEmail = jsonEncode(response.data['data']['user']['email']);
        });
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 406) {
        _storage.remove('token');
        Navigator.pushReplacementNamed(context, '/login');
      }
      print('${e.response} - ${e.response?.statusCode} - ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      children: [
        // itemCount: userData == null ? 0 : userData.length,
        Card(
          child: ListTile(
            // title: Text(userData[index]['user']['name']),
            // subtitle: Text(userData[index]['user']['email']),
            title: Text(userName),
            subtitle: Text(userEmail),
          ),
        ),
        ElevatedButton(onPressed: goUser, child: const Text("See Profile"))
      ],
    ));
  }
}
