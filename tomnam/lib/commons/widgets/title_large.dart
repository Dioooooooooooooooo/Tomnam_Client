import 'package:flutter/material.dart';

class CustomTitleLarge extends StatelessWidget {
  final String text;
  final bool isDisabled;

  const CustomTitleLarge({
    super.key,
    required this.text,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }
}
