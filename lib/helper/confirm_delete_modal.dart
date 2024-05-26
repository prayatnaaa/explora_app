import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class DeleteModal extends StatelessWidget {
  final void Function()? onTap;
  const DeleteModal({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            const MyText(
                child: "Confirm delete",
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            Row(
              children: [
                CoolButton(
                  text: "Delete",
                  color: Colors.red,
                  onTap: onTap,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const MyText(
                      child: "Cancel",
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ));
  }
}
