import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class FoodItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final bool isVertical;

  const FoodItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, foodOverviewRoute);
      },
      child: isVertical
          ? Container(
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
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              width: 150,
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imageUrl,
                      height: 140,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
