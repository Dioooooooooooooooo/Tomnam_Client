import 'package:flutter/material.dart';
import 'food_item.dart';

// list of food items

class FoodList extends StatelessWidget {
  final List<String> productTitles;
  final List<String> imageList;
  final List<String> prices;
  final bool isVertical;

  const FoodList({
    super.key,
    required this.productTitles,
    required this.imageList,
    required this.prices,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: productTitles.length,
            itemBuilder: (context, index) {
              return FoodItem(
                imageUrl: imageList[index % imageList.length],
                title: productTitles[index],
                price: prices[index],
                isVertical: true,
              );
            },
          )
        : SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productTitles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FoodItem(
                    imageUrl: imageList[index % imageList.length],
                    title: productTitles[index],
                    price: prices[index],
                  ),
                );
              },
            ),
          );
  }
}
