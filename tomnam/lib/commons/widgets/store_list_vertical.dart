import 'package:flutter/material.dart';
import 'package:tomnam/models/karenderya.dart';
import 'store_item.dart';

// list of store items

class StoreListVertical extends StatelessWidget {
  final List<Karenderya> stores;

  const StoreListVertical(
    this.stores,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return StoreItem(
          stores[index],
        );
      },
    );
  }
}