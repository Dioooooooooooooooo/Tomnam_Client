import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';
import '../../../models/reservation.dart';
import 'package:intl/intl.dart';

class AnnouncementSection extends StatelessWidget {
  final List<Reservation> reservationsToday;
  final VoidCallback onNavigateToCalendar;

  const AnnouncementSection({
    super.key,
    required this.reservationsToday,
    required this.onNavigateToCalendar,
  });

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
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
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView.builder(
                  shrinkWrap:
                      true, // Makes the ListView take up only the necessary height
                  itemCount: reservationsToday.length,
                  itemBuilder: (context, index) {
                    return _buildOrderButton(
                      reservationsToday[index].karenderya.name,
                      DateFormat("hh:mm a")
                          .format(reservationsToday[index].reserveDateTime),
                      context,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }

  Widget _buildOrderButton(
      String karenderyaName, String time, BuildContext context) {
    return GestureDetector(
      onTap: onNavigateToCalendar,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 26),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                karenderyaName,
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
