import 'package:flutter/material.dart';
import 'store_item.dart';

// list of store items

class StoreListVertical extends StatelessWidget {
  final List<String> stores;
  final List<String> imageList;
  final List<String> reviews;

  const StoreListVertical({
    super.key,
    required this.stores,
    required this.imageList,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return StoreItem(
          storeName: stores[index],
          imageUrl: imageList[index % imageList.length],
          reviews: reviews[index],
        );
      },
    );
  }
}
