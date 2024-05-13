import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberList extends StatelessWidget {
  final Member member;
  const MemberList({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: white),
        width: 280,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.person,
                  color: themeColor,
                  size: 80,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //member name
              Text(
                member.nama,
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeColor),
              ),
              //member nomor_induk
              MyText(
                  child: member.nama,
                  fontSize: 16,
                  color: themeColor,
                  fontWeight: FontWeight.bold),
              //member telepon
              MyText(
                  child: member.telepon,
                  fontSize: 12,
                  color: themeColor,
                  fontWeight: FontWeight.w300)
            ],
          ),
        ),
      ),
    );
  }
}
