import 'package:flutter/material.dart';
import 'package:tomnam/models/reservation.dart';
import 'package:intl/intl.dart';

class ReservationWidget extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback? onScanTap;

  const ReservationWidget({
    super.key,
    required this.reservation,
    this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Karenderya Name
            Text(
              reservation.karenderya.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),

            // Reservation Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${DateFormat('yyyy-MM-dd HH:mm').format(reservation.reserveDateTime)}',
                ),
                Text('Total: ₱${reservation.total.toStringAsFixed(2)}'),
              ],
            ),

            // Reserved Items
            const SizedBox(height: 8.0),
            const Text('Items:'),
            ...reservation.reservedItems
                .map((item) => Text(
                    '• ${item.foodName} x${item.quantity} (₱${item.unitPrice}/each)'))
                .toList(),

            // Scan to Complete
            const SizedBox(height: 8.0),
            SizedBox(
              child: reservation.status == 'Pending'
                  ? GestureDetector(
                      onTap: onScanTap,
                      child: const Text(
                        'Scan to Complete',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : const Text('☆☆☆☆☆'),
            )
          ],
        ),
      ),
    );
  }
}
