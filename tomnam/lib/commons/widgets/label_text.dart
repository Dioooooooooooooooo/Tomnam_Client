import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final TextAlign textAlign;
  final LabelSize size;

  const LabelText({
    super.key,
    required this.text,
    this.isDisabled = false,
    this.textAlign = TextAlign.center,
    this.size = LabelSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? baseStyle;
    switch (size) {
      case LabelSize.large:
        baseStyle = Theme.of(context).textTheme.labelLarge;
        break;
      case LabelSize.medium:
        baseStyle = Theme.of(context).textTheme.labelMedium;
        break;
      case LabelSize.small:
        baseStyle = Theme.of(context).textTheme.labelSmall;
        break;
    }

    return Text(
      text,
      style: baseStyle,
      textAlign: textAlign,
    );
  }
}

enum LabelSize { large, medium, small }
