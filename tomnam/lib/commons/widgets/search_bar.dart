import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';

class CustomSearchBar1 extends StatelessWidget {
  const CustomSearchBar1({super.key});
// FAKE NI
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: AppColors.blackColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: AppColors.mainGreenColor),
          border: InputBorder.none,
          labelText: "Find your product",
          labelStyle: TextStyle(color: AppColors.blackColor),
        ),
      ),
    );
  }
}
