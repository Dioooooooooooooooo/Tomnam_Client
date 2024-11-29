import 'package:flutter/material.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSearchPressed;

  const CustomSearchBar({
    required this.hintText,
    required this.onChanged,
    this.onSearchPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainGreenColor,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            color: AppColors.whiteColor,
            onPressed: onSearchPressed,
          ),
          SizedBox(
            width: 200,
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.whiteColor.withOpacity(0.7),
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
