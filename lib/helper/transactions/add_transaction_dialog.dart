import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/components/textfield.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';

class AddTransactionDialog extends StatefulWidget {
  final TextEditingController? transactionController;
  final TextEditingController? amountController;
  final VoidCallback onTap;
  const AddTransactionDialog(
      {super.key,
      required this.transactionController,
      required this.amountController,
      required this.onTap});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextField(
                onTap: () {},
                hintText: "transaction",
                controller: widget.transactionController),
            MyTextField(
                onTap: () {},
                hintText: "amount",
                controller: widget.amountController),
            const SizedBox(
              height: 24,
            ),
            CoolButton(
              onTap: widget.onTap,
              text: "Add Transaction",
              color: themeColor,
              textColor: white,
            )
          ],
        ),
      ),
    );
  }
}
