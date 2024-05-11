import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberList extends StatelessWidget {
  Member member;
  MemberList({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: themeColor),
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //member name
            Text(
              member.nama,
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            //member nomor_induk
            MyText(
                child: member.nomor_induk,
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.w500),
            //member telepon
            MyText(
                child: member.telepon,
                fontSize: 12,
                color: white,
                fontWeight: FontWeight.w300)
          ],
        ),
      ),
    );
  }
}
