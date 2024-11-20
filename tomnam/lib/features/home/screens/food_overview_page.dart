import 'package:flutter/material.dart';

class FoodOverviewPage extends StatelessWidget {
  const FoodOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Overview'),
      ),
      body: const Center(
        child: Text('Details about the selected food.'),
      ),
    );
  }
}
