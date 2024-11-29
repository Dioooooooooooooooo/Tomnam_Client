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
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: List.generate(productTitles.length, (index) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 10) / 2 - 10,
                  child: FoodItem(
                    imageUrl: imageList[index % imageList.length],
                    title: productTitles[index],
                    price: prices[index],
                  ),
                );
              }),
            ),
          );
  }
}
