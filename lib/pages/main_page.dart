import 'package:explora_app/contents/colors.dart';
import 'package:explora_app/pages/members/member_page.dart';
import 'package:explora_app/pages/transactions/interest_page.dart';
import 'package:explora_app/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final tabs = [const UserPage(), const MemberPage(), const InterestPage()];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        index = 0;
        break;
      case 1:
        index = 1;
        break;
      case 2:
        index = 2;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: themeColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            backgroundColor: themeColor,
            color: lightGreen,
            activeColor: themeColor,
            tabBackgroundColor: white,
            padding: const EdgeInsets.all(10),
            gap: 8,
            iconSize: 26,
            textStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
            onTabChange: _onTabChange,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.people,
                text: "Members",
              ),
              GButton(
                icon: Icons.money,
                text: "Interests",
              ),
            ],
          ),
        ),
      ),
      body: tabs[_selectedIndex],
    );
  }
}
