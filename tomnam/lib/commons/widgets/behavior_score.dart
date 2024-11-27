import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';

class BehaviorScore extends StatelessWidget {
  const BehaviorScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 80,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: AppColors.blackColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column( // Use Column to allow multiple children
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BEHAVIOR SCORE',
                overflow: TextOverflow.ellipsis,
              ),
              Icon(Icons.arrow_drop_down_circle_outlined),
            ],
          ),
          Row(
            children: [
              Icon(Icons.credit_score_outlined),
              SizedBox(width: 5), // Add spacing between widgets
              Text(
                '600 Points',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
