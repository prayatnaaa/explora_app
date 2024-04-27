import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceCard extends StatelessWidget {
  final String id, name, email;
  const PlaceCard(
      {super.key, required this.id, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    final fitWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        constraints: BoxConstraints(
            maxHeight: 200, minHeight: 150, maxWidth: fitWidth, minWidth: 150),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    id,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    name,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                  Text(
                    email,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Visit",
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.location_on),
                ],
              ),
            )
          ],
        ));
  }
}
