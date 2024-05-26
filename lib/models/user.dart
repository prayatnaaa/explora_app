class User {
  final String name;
  final String email;
  final String? password;

  User({required this.name, required this.email, this.password});

  factory User.fromModel(Map<String, dynamic> json) => User(
      name: json['name'], email: json['email'], password: json['password']);
}
