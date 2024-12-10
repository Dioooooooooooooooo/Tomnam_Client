import 'package:flutter/material.dart';
import 'package:tomnam/commons/widgets/title_text.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final Color? color;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.mainGreenColor,
          minimumSize: const Size(double.infinity, 48),
        ),
        child: isLoading
            ? const SizedBox(
                height: 50,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : TitleText(
                text: text,
                size: TitleSize.medium,
              ),
      ),
    );
  }
}
