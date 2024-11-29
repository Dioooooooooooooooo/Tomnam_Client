class User {
  final String Id;
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  int? behaviorScore;

  User({required this.Id, required this.email, required this.role, required this.firstName, required this.lastName, this.behaviorScore});
}
