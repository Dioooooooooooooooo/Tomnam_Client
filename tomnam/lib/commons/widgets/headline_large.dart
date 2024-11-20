import 'package:flutter/material.dart';

class CustomHeadlineLarge extends StatelessWidget {
  final String text;
  final bool isDisabled;

  const CustomHeadlineLarge({
    super.key,
    required this.text,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge,
      textAlign: TextAlign.center,
    );
  }
}
