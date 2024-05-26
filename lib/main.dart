import 'package:explora_app/pages/login_page.dart';
import 'package:explora_app/pages/member_page.dart';
import 'package:explora_app/pages/onboard_page.dart';
import 'package:explora_app/pages/profile_page.dart';
import 'package:explora_app/pages/register_page.dart';
import 'package:explora_app/pages/user_page.dart';
import 'package:explora_app/pages/user_profile_page.dart';
import 'package:explora_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/user': (context) => const UserPage(),
        '/profile': (context) => ProfilePage(),
        '/member': (context) => const MemberPage()
      },
    );
  }
}
