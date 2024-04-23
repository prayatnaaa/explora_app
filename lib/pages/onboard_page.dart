import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:explora_app/contents/onboard_content.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: PageView.builder(
            controller: _pageController,
            itemCount: data.length,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Image(image: AssetImage(data[i].image))),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data[i].description,
                          maxLines: 2,
                          style: GoogleFonts.montserrat(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data[i].text,
                          style: GoogleFonts.montserrat(
                              fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                List.generate(data.length, (index) => buildDot(index, context)),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.all(40),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9292FD)),
              child: Text(
                currentIndex == data.length - 1 ? "Continue" : "Next",
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (currentIndex == data.length - 1) {
                  Navigator.pushReplacementNamed(context, '/welcome');
                }
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
            ),
          )
        ],
      ),
    ));
  }

  buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
