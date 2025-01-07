import 'package:tomnam/models/reservation.dart';

class Transaction {
  final String Id;
  final String reservationId;
  final Reservation reservation;
  final double total;
  final DateTime dateTime;

  Transaction({
    required this.Id,
    required this.reservationId,
    required this.reservation,
    required this.total,
    required this.dateTime,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      Id: json['id'] as String,
      reservationId: json['reservationId'] as String,
      reservation: Reservation.fromJson(json['reservation']),
      total: json['total'] as double,
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
