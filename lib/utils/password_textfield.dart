import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatefulWidget {
  final VoidCallback onTap;
  final controller;

  const PasswordTextField(
      {super.key, required this.onTap, required this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

bool isPasswordHidden = true;

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
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
                    color: isPasswordHidden ? Colors.grey : Colors.blue,
                  )),
              hintText: "Password",
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Color(0xFF6C63FF)))),
        ));
  }
}
