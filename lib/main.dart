import 'package:explora_app/pages/home_page.dart';
import 'package:explora_app/pages/login_page.dart';
import 'package:explora_app/pages/onboard_page.dart';
import 'package:explora_app/pages/register_page.dart';
import 'package:explora_app/pages/see_places_page.dart';
import 'package:explora_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
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
        '/welcome': (context) => const WelcomePage(),
        '/': (context) => const OnBoardPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/menu': (context) => const HomePage(),
        '/listUser': (context) => const SeePlacesPage()
      },
    );
  }
}
