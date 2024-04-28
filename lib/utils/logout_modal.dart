import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin LogoutModal {
  void logoutModal(BuildContext context, onTap) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 10),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text: "Sure wanted to leave?",
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "Log out",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      "Cancel",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
