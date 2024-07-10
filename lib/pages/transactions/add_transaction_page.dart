import 'package:explora_app/components/text.dart';
import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTransactionPage extends StatefulWidget {
  final String transactionID;
  const AddTransactionPage({super.key, required this.transactionID});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  @override
  Widget build(BuildContext context) {
    int id = int.tryParse(widget.transactionID) ?? 0;
    final TextEditingController amountController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: themeColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                    child: "Add Transaction",
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.bold),
                _textfield(amountController, "Enter amount")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _textfield(TextEditingController? controller, String labelText) {
  if (controller!.text.isEmpty) {
    print("cannot");
  }
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: TextField(
        controller: controller,
        cursorColor: white,
        decoration: InputDecoration(
            hintText: controller.text,
            hintStyle: GoogleFonts.poppins(color: white),
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(color: white, fontSize: 12),
            hoverColor: white,
            fillColor: white,
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: lightGreen)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: lightGreen)),
            filled: false)),
  );
}
