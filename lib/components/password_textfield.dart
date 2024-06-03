import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatefulWidget {
  final VoidCallback onTap;
  final controller;
  final String? hintText;

  const PasswordTextField(
      {super.key,
      required this.onTap,
      required this.controller,
      this.hintText});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

bool isPasswordHidden = true;

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onTap: widget.onTap,
        obscureText: isPasswordHidden,
        controller: widget.controller,
        style: GoogleFonts.montserrat(),
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  });
                },
                icon: Icon(
                  isPasswordHidden ? Icons.lock : Icons.lock_open,
                  color: isPasswordHidden ? Colors.grey : themeColor,
                )),
            hintText: widget.hintText,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: lightGreen))),
      ),
    );
  }
}
