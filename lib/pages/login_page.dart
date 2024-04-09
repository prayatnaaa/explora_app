import 'package:explora_app/pages/home_page.dart';
import 'package:explora_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              children: [
                const Align(
                    alignment: Alignment.centerRight,
                    child: Image(image: AssetImage("assets/map.png"))),
                Positioned(
                  top: 130,
                  left: 120,
                  child: Text(
                    "Welcome back",
                    style: GoogleFonts.montserrat(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 100,
                  child: Text(
                    "Sign in to access your account",
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: TextField(
              controller: emailController,
              style: GoogleFonts.montserrat(),
              decoration: const InputDecoration(
                  hintText: "Enter your email",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFF6C63FF)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: TextField(
              controller: passwordController,
              style: GoogleFonts.montserrat(),
              decoration: const InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Color(0xFF6C63FF)))),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color(0xFF6C63FF)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFCFCFC)),
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: Color(0xFFFCFCFC),
                  )
                ],
              ),
              onPressed: () {
                if (emailController.text == "tude") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Member? ",
                  style: GoogleFonts.montserrat(fontSize: 13),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterPage();
                    }));
                  },
                  child: Text(
                    "Register now",
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6C63FF)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
