class User {
  final int? id;
  final String name;
  final String email;

  User({
    this.id,
    required this.name,
    required this.email,
  });

  factory User.fromModel(Map<String, dynamic> json) => User(
        id: json["data"]["user"]["id"],
        name: json["data"]["user"]["name"],
        email: json["data"]["user"]["email"],
      );
}
