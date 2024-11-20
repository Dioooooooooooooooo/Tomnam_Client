import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final TextAlign textAlign;
  final BodyTextSize size;

  const BodyText({
    super.key,
    required this.text,
    this.isDisabled = false,
    this.textAlign = TextAlign.center,
    this.size = BodyTextSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? baseStyle;
    switch (size) {
      case BodyTextSize.large:
        baseStyle = Theme.of(context).textTheme.bodyLarge;
        break;
      case BodyTextSize.medium:
        baseStyle = Theme.of(context).textTheme.bodyMedium;
        break;
      case BodyTextSize.small:
        baseStyle = Theme.of(context).textTheme.bodySmall;
        break;
    }

    return Text(
      text,
      style: baseStyle,
      textAlign: textAlign,
    );
  }
}

enum BodyTextSize { large, medium, small }
