import 'package:flutter/material.dart';

class CustomHeadlineMedium extends StatelessWidget {
  final String text;
  final bool isDisabled;

  const CustomHeadlineMedium({
    super.key,
    required this.text,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }
}
