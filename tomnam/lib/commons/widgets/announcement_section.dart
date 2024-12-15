import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';
import '../../../models/reservation.dart';

class AnnouncementSection extends StatelessWidget {
  final List<Reservation> reservationsToday;

  const AnnouncementSection({super.key, required this.reservationsToday});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        gradient: AppColors.gradientGreenColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                children: [
                  const TextSpan(text: "You have "),
                  TextSpan(
                    text: "${reservationsToday.length} orders",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const TextSpan(text: " reserved today."),
                ],
              ),
            ),
          ),
          const SizedBox(height: 35),
          // Dynamically render buttons based on reservations
          for (var reservation in reservationsToday)
            _buildOrderButton(
              reservation.karenderya
                  .name, // Assuming 'karenderya.name' is the store name
              "${reservation.reserveDateTime.hour}:${reservation.reserveDateTime.minute.toString().padLeft(2, '0')}pm",
              context,
            ),
        ],
      ),
    );
  }

  Widget _buildOrderButton(
      String orderDetails, String time, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, calendarRoute);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 26),
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                orderDetails,
                style: const TextStyle(
                  color: AppColors.mainGreenColor,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                color: AppColors.mainGreenColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
