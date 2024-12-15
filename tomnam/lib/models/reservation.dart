import '../models/karenderya.dart';
import '../models/reserved_item.dart';

class Reservation {
  final String id;
  final Karenderya karenderya;
  final DateTime reserveDateTime;
  final double total;
  final String modeOfPayment;
  final String status;
  final List<ReservedItem> reservedItems;

  Reservation({
    required this.id,
    required this.karenderya,
    required this.reserveDateTime,
    required this.total,
    required this.modeOfPayment,
    required this.status,
    required this.reservedItems,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      karenderya: Karenderya.fromJson(json['karenderya']),
      reserveDateTime: DateTime.parse(json['reserveDateTime']),
      total: json['total'].toDouble(),
      modeOfPayment: json['modeOfPayment'],
      status: json['status'],
      reservedItems: (json['reservedItems'] as List)
          .map((item) => ReservedItem.fromJson(item))
          .toList(),
    );
  }
}
