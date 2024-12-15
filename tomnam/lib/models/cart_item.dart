import 'package:tomnam/models/food.dart';

class CartItem{
  final String Id;
  final Food food;
  int quantity;
  bool isChecked;

  CartItem({
    required this.Id,
    required this.food,
    required this.quantity,
    required this.isChecked,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      Id: json['id'] as String,
      food: Food.fromJson(json['food'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      isChecked: json['isChecked'] as bool,
    );
  }
}