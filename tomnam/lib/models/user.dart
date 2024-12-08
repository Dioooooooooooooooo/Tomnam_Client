class User {
  final String Id;
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  
  int? behaviorScore;

  User(
      {required this.Id,
      required this.email,
      required this.role,
      required this.firstName,
      required this.lastName,
      this.behaviorScore});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      behaviorScore:
          json['behaviorScore'] is int ? json['behaviorScore'] : null,
    );
  }
}
