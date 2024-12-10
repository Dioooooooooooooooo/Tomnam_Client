import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/reservation_details.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/cart_item_controller.dart';
import 'package:tomnam/models/food.dart';

class ReserveFoodPage extends StatefulWidget {
  const ReserveFoodPage({super.key});

  @override
  _ReserveFoodPageState createState() => _ReserveFoodPageState();
}

class _ReserveFoodPageState extends State<ReserveFoodPage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  TimeOfDay _selectedTime = const TimeOfDay(hour: 12, minute: 0);
  DateTime _selectedDate = DateTime.now();
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
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
        flexibleSpace: const UpperNavBar(),
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
                      time: _selectedTime.format(context),
                      date: _selectedDate.toLocal().toString().split(' ')[0],
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

                CartItemController.create({
                  'foodId': food.Id,
                  'quantity': _quantity
                }).then((data) {
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
              onPressed: () {},
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
