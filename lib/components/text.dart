import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String child;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const MyText(
      {super.key,
      required this.child,
      required this.fontSize,
      required this.color,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      child,
      style: GoogleFonts.montserrat(
          fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
