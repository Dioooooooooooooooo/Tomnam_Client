class User {
  final String email;
  final String token;

  User({required this.email, required this.token});

  // Factory constructor to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      token: json['accessToken'],
    );
  }
}
