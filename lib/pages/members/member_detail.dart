import 'package:explora_app/components/card.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';

class MemberDetail extends StatelessWidget {
  const MemberDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyCard(
            children: [
              Center(
                child: MyText(
                    child: "Tude",
                    fontSize: 16,
                    color: themeColor,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
