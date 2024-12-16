import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/Exceptions/response_exception.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/reservation_controller.dart';
import 'package:tomnam/models/cart_item.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late List<CartItem> selectedItems;
  bool _isLoading = true;
  String time = TimeOfDay.fromDateTime(DateTime.now()).toString();
  String date = DateTime.now().toString();

  DateTime _selectedDate = DateTime.now().toUtc().add(const Duration(hours: 8));
  late TimeOfDay _selectedTime = TimeOfDay.fromDateTime(_selectedDate);

  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  get selectAll => null;

  // To calculate the total price of selected items
  double get totalPrice {
    double total = 0;
    for (int storeIndex = 0; storeIndex < selectedItems.length; storeIndex++) {
      for (int foodIndex = 0; foodIndex < selectedItems.length; foodIndex++) {
        if (selectedItems[foodIndex].isChecked) {
          total += selectedItems[foodIndex].food.unitPrice *
              selectedItems[foodIndex].quantity;
        }
      }
    }
    return total;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      selectedItems = arguments['selectedItems'] as List<CartItem>;
      _logger.d('Received selected items: $selectedItems');

      _isLoading = false;
    } else {
      _logger.e('No cart items found in arguments');
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

  Future<void> _confirmReservation() async {
    List<String> cartItemIds = [];

    for (var item in selectedItems) {
      cartItemIds.add(item.Id);
    }

    _logger.d('cart ids: $cartItemIds');

    // Combine selected time and date
    DateTime combinedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    ).toUtc().add(const Duration(hours: 8));

    final reservationData = <String, dynamic>{};

    _logger.d(combinedDateTime.toString());
    reservationData['CartItemIds'] = cartItemIds;
    reservationData['ReserveDateTime'] = combinedDateTime.toIso8601String();
    reservationData['ModeOfPayment'] = 'Over-the-counter';

    try {
      final message = await ReservationController.create(reservationData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      Navigator.of(context)
          .pushNamedAndRemoveUntil(mainPageRoute, (route) => false);
    } catch (e, stackTrace) {
      if (!context.mounted) return;
      String? message;
      if (e is ResponseException) {
        message = e.error;
      } else {
        message = 'An error occurred during reservation';
      }
      _logger.d(stackTrace);
      _logger.e('An error occurred during reservation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedItems = <String, List<CartItem>>{};
    for (var item in selectedItems) {
      groupedItems.putIfAbsent(item.food.karenderya!.name, () => []).add(item);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loader while fetching
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: groupedItems.length,
                        itemBuilder: (context, storeIndex) {
                          final storeName =
                              groupedItems.keys.elementAt(storeIndex);
                          final storeItems = groupedItems[storeName]!;

                          return _buildReservedItems(storeName, storeItems);
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTimeDateSection(_selectedTime.format(context),
                          _selectedDate.toLocal().toString().split(' ')[0]),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }

  // This is to build the reserved items section of the page
  Widget _buildReservedItems(String storeName, storeItems) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(storeName,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...storeItems.map(
            (item) => Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image with padding between image and text
                    Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${ApiService.baseURL}/${item.food.foodPhoto}'),
                                  fit: BoxFit.cover)),
                        )),
                    // Column with foodName and price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.food.foodName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("Php ${item.food.unitPrice}"),
                        ],
                      ),
                    ),
                    // Quantity display at the right
                    Text("x${item.quantity}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
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
          _buildFooterItem('Php $totalPrice', textColor: Colors.red),
          _buildFooterItem('Confirm',
              isButton: true,
              onTap: _confirmReservation,
              textColor: Colors.white),
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

  Widget _buildTimeDateSection(String time, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            _selectTime(context);
          },
          child: _buildTimeDateInput('Time', time),
        ),
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: _buildTimeDateInput('Date', date),
        ),
      ],
    );
  }

  Widget _buildTimeDateInput(String label, String value) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD7D7D7)),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
