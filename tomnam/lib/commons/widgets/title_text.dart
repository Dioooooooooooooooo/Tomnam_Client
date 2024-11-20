import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final TextAlign textAlign;
  final TitleSize size;

  const TitleText({
    super.key,
    required this.text,
    this.isDisabled = false,
    this.textAlign = TextAlign.center,
    this.size = TitleSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? baseStyle;
    switch (size) {
      case TitleSize.large:
        baseStyle = Theme.of(context).textTheme.titleLarge;
        break;
      case TitleSize.medium:
        baseStyle = Theme.of(context).textTheme.titleMedium;
        break;
      case TitleSize.small:
        baseStyle = Theme.of(context).textTheme.titleSmall;
        break;
    }

    return Text(
      text,
      style: baseStyle,
      textAlign: textAlign,
    );
  }
}

enum TitleSize { large, medium, small }
