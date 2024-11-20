import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final TextAlign textAlign;
  final HeadlineSize size;

  const HeadlineText({
    super.key,
    required this.text,
    this.isDisabled = false,
    this.textAlign = TextAlign.center,
    this.size = HeadlineSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? baseStyle;
    switch (size) {
      case HeadlineSize.large:
        baseStyle = Theme.of(context).textTheme.headlineLarge;
        break;
      case HeadlineSize.medium:
        baseStyle = Theme.of(context).textTheme.headlineMedium;
        break;
      case HeadlineSize.small:
        baseStyle = Theme.of(context).textTheme.headlineSmall;
        break;
    }

    return Text(
      text,
      style: baseStyle,
      textAlign: textAlign,
    );
  }
}

enum HeadlineSize { large, medium, small }
