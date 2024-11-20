import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

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
