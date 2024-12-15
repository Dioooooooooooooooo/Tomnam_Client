import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tomnam/commons/widgets/reservation_details.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/cart_item_controller.dart';
import 'package:tomnam/models/food.dart';
import 'package:tomnam/provider/cart_item_provider.dart';
import 'package:tomnam/utils/constants/routes.dart';

class ReserveFoodPage extends StatefulWidget {
  const ReserveFoodPage({super.key});

  @override
  _ReserveFoodPageState createState() => _ReserveFoodPageState();
}

class _ReserveFoodPageState extends State<ReserveFoodPage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  int _quantity = 1; // Initial quantity
  late Food food;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      food = arguments['food'] as Food;
    } else {
      _logger.e('No store data found in arguments');
    }
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const UpperNavBar(false),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Banner image without padding
              Container(
                height: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      '${ApiService.baseURL}/${food.foodPhoto}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 360,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food name and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          food.foodName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          food.unitPrice.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      food.foodDescription,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(color: Color(0xFFD7D7D7)),
                    const SizedBox(height: 16),
                    // Use the ReservationDetailsContainer widget
                    ReservationDetailsContainer(
                      quantity: _quantity,
                      incrementQuantity: _incrementQuantity,
                      decrementQuantity: _decrementQuantity,
                    ),
                    const SizedBox(height: 20),
                    // Buttons (Add to Cart and Reserve)
                    _buildActionButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final CartItemProvider _cartItemProvider =
        Provider.of<CartItemProvider>(context, listen: false);
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF6A747),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                CartItemController.create(
                    {'foodId': food.Id, 'quantity': _quantity}).then((data) {
                  _logger.i('Added to cart');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                });
              },
              child: const Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFF6A747),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () async {
                final item = await CartItemController.create(
                    {'foodId': food.Id, 'quantity': _quantity});
                _logger.d('done');
                if (item != null) {
                  Navigator.pushNamed(context, checkoutPageRoute, arguments: {
                    'selectedItems': [item]
                  });
                }
              },
              child: const Text(
                'Reserve',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
