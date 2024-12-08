class Reservation {
  final String karenderyaName;
  final List<Map<String, int>>
      items; // Each item is a map with name and quantity

  Reservation(this.karenderyaName, this.items);

  @override
  String toString() => karenderyaName;
}
