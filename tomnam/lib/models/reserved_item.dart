import 'package:tomnam/models/food.dart';

class ReservedItem {
  final String id;
  final String foodName;
  final double unitPrice;
  final int quantity;
  final Food food;

  ReservedItem({
    required this.id,
    required this.foodName,
    required this.unitPrice,
    required this.quantity,
    required this.food,
  });

  factory ReservedItem.fromJson(Map<String, dynamic> json) {
    return ReservedItem(
      id: json['id'],
      foodName: json['food']['foodName'],
      food: Food.fromJson(json['food'] as Map<String, dynamic>),
      unitPrice: json['food']['unitPrice'].toDouble(),
      quantity: json['quantity'],
    );
  }
}
