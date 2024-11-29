import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class AnnouncementSection extends StatelessWidget {
  const AnnouncementSection({super.key});

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
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                children: [
                  TextSpan(text: "You have "),
                  TextSpan(
                    text: "2 orders",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(text: " reserved today."),
                ],
              ),
            ),
          ),
          const SizedBox(height: 35),
          _buildOrderButton("Karenderya ni Danny", "12:00pm", context),
          const SizedBox(height: 12),
          _buildOrderButton("Boarding House ni James", "3:00pm", context),
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
        margin:
            const EdgeInsets.only(left: 20, right: 20), // Margin for spacing
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
