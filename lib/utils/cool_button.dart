import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoolButton extends StatefulWidget {
  final String text;
  final Color? color;
  final VoidCallback? onTap;

  const CoolButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap});

  @override
  State<CoolButton> createState() => _CoolButtonState();
}

class _CoolButtonState extends State<CoolButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: widget.color),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
          child: Text(
            widget.text,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
