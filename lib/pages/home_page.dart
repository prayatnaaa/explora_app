import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/pages/see_places_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Welcome to Home",
              style: GoogleFonts.montserrat(
                  fontSize: 24, fontWeight: FontWeight.w400),
            ),
            const Image(image: AssetImage("assets/cat.png")),
            Text(
              "Explora is an UI template design that can be found in Figma. I, Tude Prayatna, use this template for my Mobile Programming course. I'm using flutter, a Dart Language's Framework, to duplicate this template.",
              style: GoogleFonts.montserrat(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: themeColor),
                onPressed: () {
                  Navigator.pushNamed(context, '/listUser');
                },
                child: Text("See Places",
                    style: GoogleFonts.montserrat(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
