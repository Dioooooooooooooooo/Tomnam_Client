import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tomnam/Exceptions/response_exception.dart';
import 'package:tomnam/commons/widgets/store_cart_item.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/features/controllers/cart_item_controller.dart';
import 'package:tomnam/models/cart_item.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/provider/cart_item_provider.dart';
import 'package:tomnam/provider/karenderya_provider.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = true;
  List<Karenderya> _stores = [];
  List<Karenderya> _currentStores = [];
  List<List<CartItem>> _cartItems = [];

  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void initState() {
    super.initState();
    final storeProvider =
        Provider.of<KarenderyaProvider>(context, listen: false);
    _stores = storeProvider.stores;

    final cartItemProvider =
        Provider.of<CartItemProvider>(context, listen: false);
    CartItemController.read().then((cartItems) {
      cartItemProvider.setCartItems(cartItems);
    });
    final cartItemsData = cartItemProvider.cartItems;

    for (var element in cartItemsData) {
      Karenderya k =
          _stores.firstWhere((store) => store.Id == element.food.karenderyaId);
      if (!_currentStores.contains(k)) {
        _currentStores.add(k);
        List<CartItem> karenderyaCartItems = cartItemsData
            .where((element) => element.food.karenderyaId == k.Id)
            .toList();
        _cartItems.add(karenderyaCartItems);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  bool selectAll = false;
  int numChecked = 0;

  get quantity => null;

  // To calculate the total price of selected items
  double get totalPrice {
    double total = 0;
    for (int storeIndex = 0; storeIndex < _currentStores.length; storeIndex++) {
      for (int foodIndex = 0;
          foodIndex < _cartItems[storeIndex].length;
          foodIndex++) {
        if (_cartItems[storeIndex][foodIndex].isChecked) {
          total += _cartItems[storeIndex][foodIndex].food.unitPrice *
              _cartItems[storeIndex][foodIndex].quantity;
        }
      }
    }
    return total;
  }

  // To toggle select all functionality for checkboxes
  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (int storeIndex = 0;
          storeIndex < _currentStores.length;
          storeIndex++) {
        for (int foodIndex = 0;
            foodIndex < _cartItems[storeIndex].length;
            foodIndex++) {
          try {
            _cartItems[storeIndex][foodIndex].isChecked = selectAll;
          } catch (e, stackTrace) {
            if (!context.mounted) return;
            String? message;
            if (e is ResponseException) {
              message = e.error;
            } else {
              message = 'An error occurred during food cart update';
            }
            _logger.d(stackTrace);
            _logger.e('An error occurred during food cart update: $e');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        }
      }
    });
  }

  // Passing the selected items to the checkout page
  void goToCheckout() {
    final selectedItems = List.generate(
      _currentStores.length,
      (storeIndex) => _cartItems[storeIndex]
          .where((cartItem) => cartItem.isChecked)
          .toList(),
    ).expand((element) => element).toList();

    if (selectedItems.isNotEmpty) {
      _logger.d("shanley");
      Navigator.pushNamed(context, checkoutPageRoute, arguments: {'selectedItems': selectedItems});
    } else {
      _logger.d("charlene");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select some items before reserving.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(flexibleSpace: const UpperNavBar(false)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _currentStores.length,
                    itemBuilder: (context, storeIndex) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                _currentStores[storeIndex]
                                    .name, // Display store name
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // List of food items for each store, the UI is handled by the StoreCartItem class
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _cartItems[storeIndex].length,
                              itemBuilder: (context, foodIndex) {
                                return StoreCartItem(
                                  cartItem: _cartItems[storeIndex][foodIndex],
                                  karenderya: _currentStores[storeIndex],
                                  onCheckChanged: (value) {
                                    CartItemController.update(
                                        _cartItems[storeIndex][foodIndex].Id,
                                        {'isChecked': value}).then((data) {
                                      setState(() {
                                        _cartItems[storeIndex][foodIndex]
                                            .isChecked = data.isChecked;
                                      });
                                    });
                                  },
                                  onQuantityChanged: (newQuantity) {
                                    _logger.d('quantity: $newQuantity');
                                    CartItemController.update(
                                        _cartItems[storeIndex][foodIndex].Id,
                                        {'quantity': newQuantity}).then((data) {
                                      setState(() {
                                        _cartItems[storeIndex][foodIndex]
                                            .quantity = data.quantity;
                                      });
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                _buildFooter(),
              ],
            ),
    );
  }

  // This is to build the footer section of the page
  Widget _buildFooter() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // bottom navbar for cart
          _buildFooterItem('All', selectAll: true, onChanged: toggleSelectAll),
          _buildFooterItem('Php $totalPrice', textColor: Colors.red),
          _buildFooterItem('Reserve',
              isButton: true, onTap: goToCheckout, textColor: Colors.white),
        ],
      ),
    );
  }

  Widget _buildFooterItem(
    String text, {
    bool selectAll = false,
    Function(bool?)? onChanged,
    Function()? onTap,
    Color textColor = Colors.black,
    bool isButton = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: isButton ? onTap : null, // Handle tap for reserve button
        child: Container(
          height: 60,
          color: isButton ? AppColors.secondMainGreenColor : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectAll)
                Checkbox(value: this.selectAll, onChanged: onChanged),
              Text(text, style: TextStyle(color: textColor, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
