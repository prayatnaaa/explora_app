import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin SuccesRegisterModal {
  void successRegisterModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.green,
            alignment: Alignment.topCenter,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 50),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text: "Register success!",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
