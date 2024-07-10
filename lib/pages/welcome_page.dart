import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const Image(image: AssetImage("assets/hotBalloon.png")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                      child: "Explora",
                      fontSize: 48,
                      color: white,
                      fontWeight: FontWeight.w900),
                  const Image(image: AssetImage("assets/logo.png")),
                ],
              ),

              const SizedBox(
                height: 300,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_registerButton(context), _loginButton(context)],
              ),
            ],
          ),
        ),
        backgroundColor: themeColor);
  }
}

Widget _loginButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.go("/login");
    },
    child: Container(
      margin: const EdgeInsets.only(left: 24),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: MyText(
            child: "Log in",
            fontSize: 16,
            color: themeColor,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _registerButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.go("/register");
    },
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: white),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: MyText(
            child: "Sign up",
            fontSize: 16,
            color: white,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
