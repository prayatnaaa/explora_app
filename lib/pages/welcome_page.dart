import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Container(
                margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Text(
                  "Explora is an UI template design that can be found in Figma. I, Tude Prayatna, use this template for my Mobile Programming course. I'm using flutter, a Dart Language's Framework, to duplicate this template.",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  CoolButton(
                      textColor: themeColor,
                      text: "Register",
                      color: Colors.white,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 13),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            "Click here",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 13),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: themeColor);
  }
}
