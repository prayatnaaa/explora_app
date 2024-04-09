import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              children: [
                const Align(
                    alignment: Alignment.centerRight,
                    child: Image(image: AssetImage("assets/map.png"))),
                Positioned(
                  top: 130,
                  left: 120,
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.montserrat(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 100,
                  child: Text(
                    "by creating a free account",
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: TextField(
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
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: TextField(
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
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: TextField(
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
            margin: const EdgeInsets.only(top: 40),
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
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member? ",
                  style: GoogleFonts.montserrat(fontSize: 13),
                ),
                Text(
                  "Log in",
                  style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6C63FF)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
