import 'package:flutter/material.dart';
import 'package:tomnam/models/food.dart';
import 'food_item.dart';

// list of food items

class FoodList extends StatelessWidget {
  final bool isVertical;
  final List<Food> foods;
  final bool isOwner;

  const FoodList(this.foods, this.isVertical, this.isOwner, {super.key});

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: foods.length,
            itemBuilder: (context, index) {
              return FoodItem(
                foods[index],
                true,
                isOwner
              );
            },
          )
        : SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: List.generate(foods.length, (index) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 10) / 2 - 10,
                  child: FoodItem(
                    foods[index],
                    true,
                    isOwner
                  ),
                );
              }),
            ),
          );
  }
}
