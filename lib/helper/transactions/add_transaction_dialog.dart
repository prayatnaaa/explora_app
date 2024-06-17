import 'package:explora_app/components/cool_button.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTransactionDialog extends StatefulWidget {
  //  final TextEditingController? transactionController;
  final TextEditingController? amountController;
  final VoidCallback onTap;
  const AddTransactionDialog(
      {super.key, required this.amountController, required this.onTap});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: themeColor,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: widget.amountController,
                style: GoogleFonts.montserrat(color: lightGreen),
                decoration: InputDecoration(
                    prefixText: "Rp ",
                    prefixStyle: GoogleFonts.montserrat(color: white),
                    labelStyle: GoogleFonts.montserrat(color: white),
                    labelText: "Amount",
                    hoverColor: lightGreen,
                    fillColor: lightGreen,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightGreen)),
                    filled: false),
              ),
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
      ),
    );
  }
}
