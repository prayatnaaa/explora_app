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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: MyText(
                child: "Add Transaction",
                fontSize: 20,
                color: themeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            MyText(
              child: "Transaction ID",
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.normal,
            ),
            MyTextField(
              onTap: () {},
              hintText: "Enter Transaction ID",
              controller: widget.transactionIdController,
            ),
            const SizedBox(height: 16),
            MyText(
              child: "Amount",
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.normal,
            ),
            MyTextField(
              onTap: () {},
              hintText: "Enter Amount",
              controller: widget.amountController,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CoolButton(
                  text: "Add",
                  color: Colors.green,
                  onTap: widget.onTap,
                  textColor: white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
