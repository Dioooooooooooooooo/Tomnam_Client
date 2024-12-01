import 'package:flutter/material.dart';
import 'package:tomnam/commons/widgets/store_cart_item.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  final List<String> storeNames = [
    "Danny's Karenderya",
    "Aleng Neneng's Food",
    "Mang Thomas BBQ",
    "Paresan sa Labangon",
  ];

  final List<List<String>> foodNames = [
    ["Adobo", "BBQ Pork", "Giniling Guisado"], // Danny's Karenderya
    ["Pancit", "Sinigang na Baboy"], // Aleng Neneng's Food
    ["BBQ Pork", "Spareribs", "Grilled Chicken"], // Mang Thomas BBQ
    ["Pares", "Sizzling Pares"], // Paresan sa Labangon
  ];

  final List<List<int>> foodPrices = [
    [300, 350, 200], // Danny's Karenderya
    [100, 150], // Aleng Neneng's Food
    [250, 300, 150], // Mang Thomas BBQ
    [120, 180], // Paresan sa Labangon
  ];

  final List<List<String>> foodImages = [
    [
      "assets/images/adobo.jpg",
      "assets/images/bbq-pork.jpg",
      "assets/images/giniling-guisado.jpg"
    ],
    ["assets/images/pancit.jpg", "assets/images/sinigang.jpg"],
    [
      "assets/images/bbq-pork.jpg",
      "assets/images/spareribs.jpg",
      "assets/images/grilled-chicken.jpg"
    ],
    ["assets/images/pares.jpg", "assets/images/sizzling-pares.jpg"],
  ];

  List<List<bool>> isChecked = [
    [false, false, false],
    [false, false],
    [false, false, false],
    [false, false],
  ];

  List<List<int>> quantities = [
    [1, 1, 1],
    [1, 1],
    [1, 1, 1],
    [1, 1],
  ];

  bool selectAll = false;

  // To calculate the total price of selected items
  int get totalPrice {
    int total = 0;
    for (int storeIndex = 0; storeIndex < storeNames.length; storeIndex++) {
      for (int foodIndex = 0;
          foodIndex < foodNames[storeIndex].length;
          foodIndex++) {
        if (isChecked[storeIndex][foodIndex]) {
          total += foodPrices[storeIndex][foodIndex] *
              quantities[storeIndex][foodIndex];
        }
      }
    }
    return total;
  }

  // To toggle select all functionality for checkboxes
  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (int storeIndex = 0; storeIndex < storeNames.length; storeIndex++) {
        for (int foodIndex = 0;
            foodIndex < foodNames[storeIndex].length;
            foodIndex++) {
          isChecked[storeIndex][foodIndex] = selectAll;
        }
      }
    });
  }

  // Passing the selected items to the checkout page
  void goToCheckout() {
    final selectedItems = List.generate(
      storeNames.length,
      (storeIndex) => List.generate(
        foodNames[storeIndex].length,
        (foodIndex) => isChecked[storeIndex][foodIndex]
            ? {
                'storeName': storeNames[storeIndex],
                'foodName': foodNames[storeIndex][foodIndex],
                'foodPrice': foodPrices[storeIndex][foodIndex],
                'quantity': quantities[storeIndex][foodIndex],
                'foodImage': foodImages[storeIndex][foodIndex],
              }
            : null,
      ).whereType<Map<String, dynamic>>().toList(),
    ).expand((element) => element).toList();

    if (selectedItems.isNotEmpty) {
      Navigator.pushNamed(context, checkoutPageRoute, arguments: selectedItems);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please select some items before reserving.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(flexibleSpace: const UpperNavBar()),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: storeNames.length,
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
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          storeNames[storeIndex], // Display store name
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
                        itemCount: foodNames[storeIndex].length,
                        itemBuilder: (context, foodIndex) {
                          return StoreCartItem(
                            storeName: storeNames[storeIndex],
                            foodName: foodNames[storeIndex][foodIndex],
                            foodPrice: foodPrices[storeIndex][foodIndex],
                            foodImage: foodImages[storeIndex][foodIndex],
                            isChecked: isChecked[storeIndex][foodIndex],
                            quantity: quantities[storeIndex][foodIndex],
                            onCheckChanged: (value) {
                              setState(() {
                                isChecked[storeIndex][foodIndex] = value!;
                              });
                            },
                            onQuantityChanged: (newQuantity) {
                              setState(() {
                                quantities[storeIndex][foodIndex] = newQuantity;
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
          _buildFooterItem('All', selectAll: true, onChanged: toggleSelectAll),
          _buildFooterItem('Php $totalPrice.00', textColor: Colors.red),
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
