import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/pages/member_page.dart';
import 'package:explora_app/utils/member_list.dart';
import 'package:explora_app/utils/logout_modal.dart';
import 'package:explora_app/utils/token_expired_message_modal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with LogoutModal, TokenExpiredModal {
  String userName = '';
  String userEmail = '';
  final TextEditingController searchController = TextEditingController();

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
        // _storage.remove('token');
        Navigator.pushReplacementNamed(context, '/login');
      }
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  void goLogOut() async {
    try {
      final response = await _dio.get('$_apiURL/logout',
          options: Options(
              headers: {'Authorization': 'Bearer ${_storage.read('token')}'}));
      print(response.data);
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode} - ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: themeColor, borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_3_outlined),
                      onPressed: () {
                        logoutModal(context, goLogOut);
                      },
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const MemberPage(),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
