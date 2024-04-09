import 'package:explora_app/pages/login_page.dart';
import 'package:explora_app/pages/register_page.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/hotBalloon.png")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Explora",
                  style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Image(image: AssetImage("assets/logo.png")),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Text(
                "Explora is an UI template design that can be found in Figma. I, Tude Prayatna, use this template for my Mobile Programming course. I'm using flutter, a Dart Language's Framework, to duplicate this template.",
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const RegisterPage();
                      }));
                    },
                    child: const Text("Create account"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 13),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: Text(
                      "Click here",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13),
                    ))
              ],
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xFF6c63ff),
    );
  }
}
