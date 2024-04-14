import 'package:explora_app/contents/place_card_content.dart';
import 'package:explora_app/utils/place_card.dart';
import 'package:flutter/material.dart';

class SeePlacesPage extends StatelessWidget {
  const SeePlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: palace.length,
          itemBuilder: (_, i) {
            return PlaceCard(
              images: palace[i].images,
              description: palace[i].description,
              placeLocation: palace[i].placeLocation,
              placeName: palace[i].placeName,
            );
          }),
    );
  }
}
