import 'package:dio/dio.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/components/logout_modal.dart';
import 'package:explora_app/components/member_snippet.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/components/token_expired_message_modal.dart';
import 'package:explora_app/data/bloc/member_bloc/bloc/member_bloc.dart';
import 'package:explora_app/data/bloc/user_bloc/user_bloc.dart';
import 'package:explora_app/data/datasources/member_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void goLogOut() async {
    try {
      final response = await _dio.get('$_apiURL/logout',
          options: Options(
              headers: {'Authorization': 'Bearer ${_storage.read('token')}'}));
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode} - ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(remoteDataSource: RemoteDataSource())..add(UserLoad()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoaded) {
            final user = state.user;
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.name,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info_outline),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/profile");
                                  },
                                  color: Colors.white,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.logout_outlined),
                                  onPressed: () {
                                    logoutModal(context, goLogOut);
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    //TODO here are the add member method
                    Row(
                      children: [
                        MyText(
                            child: "Members",
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.w600)
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Expanded(child: MemberSnippet()),
                  ],
                ),
              ),
            );
          } else if (state is UserError) {
            return const Text("Error");
          }
          return Container();
        },
      ),
    );
  }
}
