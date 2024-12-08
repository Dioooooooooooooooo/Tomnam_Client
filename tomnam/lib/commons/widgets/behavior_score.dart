import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';

class BehaviorScore extends StatelessWidget {
  final String score;
  const BehaviorScore(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        // Use Column to allow multiple children
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BEHAVIOR SCORE',
                style: TextStyle(fontSize: 18.0),
                overflow: TextOverflow.ellipsis,
              ),
              Icon(Icons.arrow_drop_down_circle_outlined),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.credit_score_outlined),
              const SizedBox(width: 5), // Add spacing between widgets
              Text(
                "$score Points",
                style: const TextStyle(fontSize: 16.0),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
