import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/utils/cool_button.dart';
import 'package:flutter/material.dart';
import 'package:explora_app/utils/button.dart';
import 'package:explora_app/utils/textfield.dart';
import 'package:get/state_manager.dart';

class MemberButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController idNumController;
  final TextEditingController birthDateController;
  final TextEditingController phoneNumController;
  final VoidCallback? onPressed;

  const MemberButton({
    super.key,
    required this.nameController,
    required this.addressController,
    required this.idNumController,
    required this.birthDateController,
    required this.phoneNumController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyTextField(
              onTap: () {},
              hintText: "Id Number",
              controller: idNumController,
            ),
            MyTextField(
              onTap: () {},
              hintText: "Name",
              controller: nameController,
            ),
            MyTextField(
              onTap: () {},
              hintText: "Address",
              controller: addressController,
            ),
            MyTextField(
              onTap: () {},
              hintText: "Birth Date",
              controller: birthDateController,
            ),
            MyTextField(
              onTap: () {},
              hintText: "Phone Number",
              controller: phoneNumController,
            ),
            CoolButton(text: "Done", color: themeColor, onTap: onPressed),
          ],
        ),
      ),
    );
  }
}
