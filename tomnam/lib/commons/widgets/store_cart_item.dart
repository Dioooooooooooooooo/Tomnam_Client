import 'package:flutter/material.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/models/cart_item.dart';
import 'package:tomnam/models/karenderya.dart';

class StoreCartItem extends StatelessWidget {
  final CartItem cartItem;
  final Karenderya karenderya;
  final Function(bool?) onCheckChanged;
  final Function(int) onQuantityChanged;

  const StoreCartItem({
    super.key,
    required this.cartItem,
    required this.karenderya,
    required this.onCheckChanged,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: cartItem.isChecked,
                onChanged: onCheckChanged,
              ),
              Image.network(
                '${ApiService.baseURL}/${cartItem.food.foodPhoto}',
                height: 140,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Incase the image fails to load or null or whatever, show a placeholder image
                  return Image.asset(
                    'assets/images/cover-photo.png',
                    height: 140,
                    width: 150,
                    fit: BoxFit.cover,
                  );
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.food.foodName, style: const TextStyle(fontSize: 16)),
                      Text("Php ${cartItem.food.unitPrice}.00",
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed:
                    cartItem.quantity > 1 ? () => onQuantityChanged(cartItem.quantity - 1) : null,
              ),
              Text(cartItem.quantity.toString(), style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => onQuantityChanged(cartItem.quantity + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
