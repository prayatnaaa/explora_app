import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  VoidCallback onTap;
  final String hintText;
  final TextEditingController? controller;

  MyTextField(
      {super.key,
      required this.onTap,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onTap: onTap,
        controller: controller,
        style: GoogleFonts.montserrat(),
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: lightGreen))),
      ),
    );
  }
}
