import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';

class NullData extends StatelessWidget {
  const NullData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Icon(
          Icons.no_accounts_outlined,
          color: themeColor,
          size: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(
                child: "You didn't have any member yet! ",
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal),
            MyText(
                child: "Create here",
                fontSize: 18,
                color: themeColor,
                fontWeight: FontWeight.w600)
          ],
        )
      ],
    ));
  }
}
