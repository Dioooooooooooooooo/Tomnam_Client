import 'package:flutter/material.dart';

class StoreCartItem extends StatelessWidget {
  final String storeName;
  final String foodName;
  final int foodPrice;
  final String foodImage;
  final bool isChecked;
  final int quantity;
  final Function(bool?) onCheckChanged;
  final Function(int) onQuantityChanged;

  const StoreCartItem({
    Key? key,
    required this.storeName,
    required this.foodName,
    required this.foodPrice,
    required this.foodImage,
    required this.isChecked,
    required this.quantity,
    required this.onCheckChanged,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: onCheckChanged,
              ),
              Image.asset(
                foodImage,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(foodName, style: const TextStyle(fontSize: 16)),
                      Text("Php $foodPrice.00",
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed:
                    quantity > 1 ? () => onQuantityChanged(quantity - 1) : null,
              ),
              Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => onQuantityChanged(quantity + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
