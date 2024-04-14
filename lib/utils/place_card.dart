import 'package:explora_app/contents/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceCard extends StatelessWidget {
  final String images, description, placeName, placeLocation;
  const PlaceCard(
      {super.key,
      required this.images,
      required this.description,
      required this.placeName,
      required this.placeLocation});

  @override
  Widget build(BuildContext context) {
    final fitWidth = MediaQuery.of(context).size.width;
    final fitHeight = MediaQuery.of(context).size.height;
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
            Container(
              decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.only(right: 10),
              width: fitWidth / 3,
              height: fitHeight / 4,
              child: Image.asset(images),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placeName,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    placeLocation,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                  Text(
                    description,
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
