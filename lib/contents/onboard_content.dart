class OnBoarding {
  final String image, description, text;

  OnBoarding(
      {required this.image, required this.description, required this.text});
}

final List data = [
  OnBoarding(
      image: "assets/motorcycle.png",
      description: "Explore the world easily",
      text: "To your desire"),
  OnBoarding(
      image: "assets/guitar.png",
      description: "Reach the unknown spot",
      text: "To your destination"),
  OnBoarding(
      image: "assets/tree.png",
      description: "Make connects with explora",
      text: "To your dream trip"),
];
