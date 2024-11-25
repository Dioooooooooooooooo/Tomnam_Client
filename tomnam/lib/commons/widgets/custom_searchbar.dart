import 'package:flutter/material.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onClearPressed;

  const CustomSearchBar({
    required this.hintText,
    required this.onChanged,
    this.onSearchPressed,
    this.onClearPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.mainGreenColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            color: AppColors.whiteColor,
            onPressed: onSearchPressed,
          ),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          if (onClearPressed != null)
            IconButton(
              icon: const Icon(Icons.close),
              color: AppColors.whiteColor,
              onPressed: onClearPressed,
            ),
        ],
      ),
    );
  }
}
