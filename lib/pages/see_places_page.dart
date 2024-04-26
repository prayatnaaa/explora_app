import 'package:flutter/material.dart';
import 'package:explora_app/contents/place_card_content.dart';
import 'package:explora_app/utils/place_card.dart';

class SeePlacesPage extends StatefulWidget {
  const SeePlacesPage({super.key});

  @override
  State<SeePlacesPage> createState() => _SeePlacesPageState();
}

class _SeePlacesPageState extends State<SeePlacesPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: palace.length,
        itemBuilder: (_, i) {
          return PlaceCard(
            images: palace[i].images,
            description: palace[i].description,
            placeLocation: palace[i].placeLocation,
            placeName: palace[i].placeName,
          );
        });
  }
}
