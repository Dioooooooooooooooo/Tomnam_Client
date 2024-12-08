import 'package:flutter/material.dart';
import 'package:tomnam/models/user.dart';
import 'package:tomnam/utils/constants/routes.dart';
import '../../../utils/constants/tomnam_pallete.dart';

class BehaviorScore extends StatelessWidget {
  final User user;
  final bool clicked;
  const BehaviorScore(this.user, this.clicked, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        !clicked
            ? Navigator.pushNamed(
                context,
                behaviorScoreClickedRoute,
                arguments: {
                  'user': user,
                },
              )
            : Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: !clicked
              ? BorderRadius.circular(10)
              : const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Row(
          // Use Column to allow multiple children
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BEHAVIOR SCORE',
                  style: TextStyle(fontSize: 18.0),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.credit_score_outlined),
                    const SizedBox(width: 10), // Add spacing between widgets
                    Text(
                      "${user.behaviorScore.toString()} Points",
                      style: const TextStyle(fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            Icon(
                !clicked
                    ? Icons.keyboard_arrow_down_outlined
                    : Icons.keyboard_arrow_up_outlined,
                size: 50,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
