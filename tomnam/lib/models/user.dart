class User {
  final String Id;
  final String email;
  final String role;
  final String firstName;
  final String lastName;

  int? behaviorScore;
  String? karenderyaId;

  User(
      {required this.Id,
      required this.email,
      required this.role,
      required this.firstName,
      required this.lastName,
      this.behaviorScore,
      this.karenderyaId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      behaviorScore:
          json['behaviorScore'] is int ? json['behaviorScore'] : null,
      karenderyaId:
          json['karenderyaId'] is String ? json['karenderyaId'] : null,
    );
  }
}
