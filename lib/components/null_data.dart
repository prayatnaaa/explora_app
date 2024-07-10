import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';

class NullData extends StatelessWidget {
  const NullData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Image(
          image: AssetImage('assets/empty.png'),
          width: 250,
          height: 250,
        ),
        MyText(
            child: "No data yet!",
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600)
      ],
    ));
  }
}
