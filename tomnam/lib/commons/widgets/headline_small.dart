import 'package:flutter/material.dart';

class CustomHeadlineSmall extends StatelessWidget {
  final String text;
  final bool isDisabled;

  const CustomHeadlineSmall({
    super.key,
    required this.text,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }
}
