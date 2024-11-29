import 'package:flutter/material.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/models/food.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  final bool isVertical;

  const FoodItem(this.food, this.isVertical, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, reserveFoodRoute, arguments: {
            'food': food,
          });
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
                      child: Image.network(
                        '${ApiService.baseURL}/${food.foodPhoto}',
                        height: 140,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Incase the image fails to load or null or whatever, show a placeholder image
                          return Image.asset(
                            'assets/images/pancit.jpg',
                            height: 140,
                            width: 150,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.foodName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_money,
                              color: AppColors.mainOrangeColor,
                              size: 18,
                            ),
                            Text(
                              food.unitPrice.toString(),
                              style: const TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${ApiService.baseURL}/${food.foodPhoto}',
                              height: 140,
                              width: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Incase the image fails to load or null or whatever, show a placeholder image
                                return Image.asset(
                                  'assets/images/pancit.jpg',
                                  height: 140,
                                  width: 150,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: -5,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, reserveFoodRoute);
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: AppColors.mainGreenColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              food.foodName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Icons.attach_money,
                            color: AppColors.mainOrangeColor,
                            size: 18,
                          ),
                          Text(
                            food.unitPrice.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mainOrangeColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ));
  }
}
