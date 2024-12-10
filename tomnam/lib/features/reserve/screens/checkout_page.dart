import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CheckoutPage({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    final groupedItems = <String, List<Map<String, dynamic>>>{};
    for (var item in selectedItems) {
      groupedItems.putIfAbsent(item['storeName'], () => []).add(item);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: ListView.builder(
        itemCount: groupedItems.length,
        itemBuilder: (context, storeIndex) {
          final storeName = groupedItems.keys.elementAt(storeIndex);
          final storeItems = groupedItems[storeName]!;

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
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                ...storeItems.map((item) => Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image with padding between image and text
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(item['foodImage'],
                                  height: 80, width: 80, fit: BoxFit.cover),
                            ),
                            // Column with foodName and price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['foodName'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Php ${item['foodPrice']}"),
                                ],
                              ),
                            ),
                            // Quantity display at the right
                            Text("x${item['quantity']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
