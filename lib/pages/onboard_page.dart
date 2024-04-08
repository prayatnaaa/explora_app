import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/motorcycle.png")),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Explore the\nworld easily",
                maxLines: 2,
                style: GoogleFonts.montserrat(
                    fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "To your desire",
                style: GoogleFonts.montserrat(
                    fontSize: 24, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
