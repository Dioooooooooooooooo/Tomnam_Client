import 'package:flutter/material.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class UpperNavBar extends StatelessWidget {
  const UpperNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainGreenColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Button
          TextButton(
            onPressed: () => Navigator.pushNamed(context, searchPageRoute),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                  // White icon color
                ),
                SizedBox(width: 8),
              ],
            ),
          ),

          // Cart Button
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white, // White icon color
            ),
            onPressed: () => Navigator.pushNamed(context, addToCartRoute),
          ),
        ],
      ),
    );
  }
}
