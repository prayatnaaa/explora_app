import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message,
    {required Color? color, required Color? contentColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: color,
      showCloseIcon: true,
      content: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: contentColor,
          ),
          const SizedBox(
            width: 6,
          ),
          MyText(
              child: message,
              fontSize: 12,
              color: contentColor,
              fontWeight: FontWeight.w500),
        ],
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 60, right: 20, left: 20),
    ),
  );
}
