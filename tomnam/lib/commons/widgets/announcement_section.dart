import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class AnnouncementSection extends StatelessWidget {
  const AnnouncementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        gradient: AppColors.gradientGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Announcement Text with Bold Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(text: "You have "),
                  TextSpan(
                    text: "2 orders",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(text: " reserved today."),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Buttons for Each Order
          _buildOrderButton("Karenderya ni Danny 12:00pm", context),
          const SizedBox(height: 10),
          _buildOrderButton("Boarding House ni James 3:00pm", context),
        ],
      ),
    );
  }

  Widget _buildOrderButton(String orderDetails, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, calendarRoute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          orderDetails,
          style: const TextStyle(
            color: AppColors.mainGreenColor,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
