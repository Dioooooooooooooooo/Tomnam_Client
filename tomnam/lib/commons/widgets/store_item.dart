import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class StoreItem extends StatelessWidget {
  final String storeName;
  final String imageUrl;
  final String reviews;

  const StoreItem({
    super.key,
    required this.storeName,
    required this.imageUrl,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, storeRoute);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                height: 90,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star,
                        color: AppColors.mainOrangeColor, size: 18),
                    Text(
                      " $reviews reviews",
                      style: const TextStyle(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
