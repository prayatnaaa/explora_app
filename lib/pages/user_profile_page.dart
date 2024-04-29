import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String userName = '';
  String userEmail = '';
  final _storage = GetStorage();
  final _dio = Dio();
  final _apiURL = 'https://mobileapis.manpits.xyz/api';

  @override
  void initState() {
    super.initState();
    goUser();
  }

  void goUser() async {
    try {
      final response = await _dio.get('$_apiURL/user',
          options: Options(
              headers: {'Authorization': 'Bearer ${_storage.read('token')}'}));
      print(response.data['data']['user']['name']);
      print(response.data['data']['expired']);
      if (response.statusCode == 200) {
        setState(() {
          userName = (response.data['data']['user']['name']);
          userEmail = (response.data['data']['user']['email']);
        });
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 406) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      print('${e.response} - ${e.response?.statusCode} - ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                userName,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
              ),
              Text(userEmail)
            ],
          ),
        ),
      ),
    );
  }
}
