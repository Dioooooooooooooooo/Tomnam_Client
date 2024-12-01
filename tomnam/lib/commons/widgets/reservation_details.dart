import 'package:flutter/material.dart';

class ReservationDetailsContainer extends StatelessWidget {
  final int quantity;
  final VoidCallback incrementQuantity;
  final VoidCallback decrementQuantity;
  final String time;
  final String date;

  const ReservationDetailsContainer({
    Key? key,
    required this.quantity,
    required this.incrementQuantity,
    required this.decrementQuantity,
    required this.time,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD7D7D7).withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Reservation Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF272827),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildTimeDateSection(time, date),
          const SizedBox(height: 16),
          // Quantity selection
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: decrementQuantity,
                  color: Colors.black,
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: incrementQuantity,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '*Note: Failure to pick-up on reserved order on time or on date may deduct some of your behavior score.',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDateSection(String time, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimeDateInput('Time', time),
        _buildTimeDateInput('Date', date),
      ],
    );
  }

  Widget _buildTimeDateInput(String label, String value) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD7D7D7)),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
