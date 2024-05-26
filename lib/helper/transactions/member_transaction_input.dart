import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/text.dart';
import 'package:explora_app/components/textfield.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';

class TransactionInput extends StatefulWidget {
  final dynamic memberIdController;
  final dynamic transactionIdController;
  final dynamic amountController;
  final String hintText;
  final Function()? onTap;
  const TransactionInput(
      {super.key,
      required this.hintText,
      required this.memberIdController,
      required this.transactionIdController,
      required this.amountController,
      required this.onTap});

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          MyText(
              child: "Transaction",
              fontSize: 16,
              color: themeColor,
              fontWeight: FontWeight.bold),
          const SizedBox(
            height: 24,
          ),
          MyTextField(
              onTap: () {},
              hintText: "Transaction ID",
              controller: widget.transactionIdController),
          MyTextField(
              onTap: () {},
              hintText: "Amount",
              controller: widget.amountController),
          const SizedBox(
            height: 36,
          ),
          CoolButton(text: "Add", color: Colors.green, onTap: widget.onTap)
        ],
      ),
    );
  }
}
