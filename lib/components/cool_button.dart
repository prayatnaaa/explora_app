import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoolButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback? onTap;
  Color? textColor = Colors.white;

  CoolButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap,
      this.textColor});

  @override
  State<CoolButton> createState() => _CoolButtonState();
}

class _CoolButtonState extends State<CoolButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.color)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
            child: Text(
              widget.text,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600, color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
