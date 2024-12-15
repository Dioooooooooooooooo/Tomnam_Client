import 'package:tomnam/models/food.dart';

class ReservedItem {
  final String id;
  final String foodName;
  final double unitPrice;
  final int quantity;

  ReservedItem({
    required this.id,
    required this.foodName,
    required this.unitPrice,
    required this.quantity,
  });

  factory ReservedItem.fromJson(Map<String, dynamic> json) {
    return ReservedItem(
      id: json['id'],
      foodName: json['food']['foodName'],
      unitPrice: json['food']['unitPrice'].toDouble(),
      quantity: json['quantity'],
    );
  }
}
