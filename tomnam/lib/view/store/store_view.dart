import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store view'),
      ),
      body: const Center(
        child: Text('Details about the store.'),
      ),
    );
  }
}
