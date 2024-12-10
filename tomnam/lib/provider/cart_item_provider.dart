import 'package:flutter/foundation.dart';
import 'package:tomnam/models/cart_item.dart';

class CartItemProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void setCartItems(List<CartItem> cartItems) {
    _cartItems = cartItems;
    notifyListeners();
  }
}