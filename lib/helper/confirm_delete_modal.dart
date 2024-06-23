import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class DeleteModal extends StatelessWidget {
  final void Function()? onTap;
  const DeleteModal({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyText(
                  child: "Confirm delete",
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              const SizedBox(
                height: 36,
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: const MyText(
                      child: "Delete",
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const MyText(
                        child: "Cancel",
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
