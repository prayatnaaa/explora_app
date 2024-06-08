import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final List<Widget> children;
  const MyCard({super.key, required this.children});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: widget.children, // Use widget.children directly here
        ),
      ),
    );
  }
}
