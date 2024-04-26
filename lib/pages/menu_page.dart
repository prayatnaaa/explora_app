import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/pages/see_places_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.place),
              text: "Place",
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "Users",
            ),
            Tab(
              icon: Icon(Icons.navigate_before),
              text: "Back",
            )
          ],
        ),
        body: Stack(
          children: [
            const SeePlacesPage(),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        color: themeColor),
                    child: const Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
