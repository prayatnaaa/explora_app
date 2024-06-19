import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:flutter/material.dart';
import 'package:explora_app/components/textfield.dart';

class MemberButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController idNumController;
  final TextEditingController birthDateController;
  final TextEditingController phoneNumController;
  final VoidCallback? onPressed;
  final String title;

  const MemberButton(
      {super.key,
      required this.nameController,
      required this.addressController,
      required this.idNumController,
      required this.birthDateController,
      required this.phoneNumController,
      required this.onPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyText(
                  child: title,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 20,
              ),
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
              const SizedBox(
                height: 20,
              ),
              CoolButton(text: "Done", color: themeColor, onTap: onPressed),
            ],
          ),
        ),
      ),
    );
  }
}
