import 'package:flutter/material.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/models/food.dart';
import 'package:tomnam/utils/constants/routes.dart';
import '../../../utils/constants/tomnam_pallete.dart';

class FoodListEditItem extends StatelessWidget {
  final String karenderyaName;
  final Food food;
  const FoodListEditItem(this.food, this.karenderyaName, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, editFoodRoute, arguments: {
          'karenderyaName': karenderyaName,
          'food': food,
          'isUpdating': true
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 100,
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F23C89A),
              blurRadius: 5,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          // Use Column to allow multiple children
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: food.foodPhoto != null
                          ? NetworkImage(
                              '${ApiService.baseURL}/${food.foodPhoto}')
                          : const AssetImage(
                                  'assets/images/placeholder_food.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.foodName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Php ${food.unitPrice.toString()}',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ],
            ),
            const Icon(Icons.edit_outlined, size: 30, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
