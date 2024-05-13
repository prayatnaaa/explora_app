import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatefulWidget {
  final void Function()? onPressed;
  final String child;
  final WidgetStateProperty<Color?>? color;
  const MyButton(
      {super.key, required this.onPressed, required this.child, this.color});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(backgroundColor: widget.color),
      child: Text(
        widget.child,
        style: GoogleFonts.montserrat(
            fontSize: 16, color: white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
