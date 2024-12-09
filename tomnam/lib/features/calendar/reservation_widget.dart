import 'package:flutter/material.dart';
import 'reservation.dart'; // Import the Reservation class
import '../../../utils/constants/tomnam_pallete.dart';

class ReservationWidget extends StatelessWidget {
  final Reservation reservation;

  const ReservationWidget({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.accentOrangeColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reservation.karenderyaName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            // Display each item with its quantity
            ...reservation.items.map((item) {
              //luh needed ning tulo ka tuldok ?? "..."
              final itemName = item.keys.first;
              final itemQuantity = item.values.first;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemName,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'x$itemQuantity',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 8.0),
            const Text(
              'Total: ₱120.00',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
