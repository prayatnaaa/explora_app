import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/contents/place_card_content.dart';
import 'package:explora_app/utils/place_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SeePlacesPage extends StatelessWidget {
  const SeePlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
              itemCount: palace.length,
              itemBuilder: (_, i) {
                return PlaceCard(
                  images: palace[i].images,
                  description: palace[i].description,
                  placeLocation: palace[i].placeLocation,
                  placeName: palace[i].placeName,
                );
              }),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(15),
              child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: themeColor),
                  child: const Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
