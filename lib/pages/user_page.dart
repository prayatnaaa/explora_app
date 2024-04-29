import 'package:dio/dio.dart';
import 'package:explora_app/contents/colors.dart';
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
        // Navigator.pushReplacementNamed(context, '/login');
        tokenExpiredModal(context);
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
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: TextField(
            style: GoogleFonts.montserrat(),
            controller: searchController,
            decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: themeColor)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(Icons.clear))),
          ),
        ),
        Container(
          width: width,
          height: height / 4,
          color: themeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "hello, ",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          userName,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Text(
                      userEmail,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            color: themeColor,
                            onPressed: () {
                              // goUser();
                              Navigator.pushNamed(context, '/userProfile');
                            },
                            icon: const Icon(Icons.person)),
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        color: themeColor,
                        onPressed: () {
                          logoutModal(context, goLogOut);
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
