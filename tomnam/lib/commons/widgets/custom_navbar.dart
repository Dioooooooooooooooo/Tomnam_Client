import 'package:flutter/material.dart';
import 'package:tomnam/features/home/screens/home_page.dart';
import 'package:tomnam/features/karenderya_search/screens/search_page.dart';
import 'package:tomnam/features/profile_management/screens/profile_page.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class CustomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: "Home",
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.calendar_month_outlined,
            label: "Calendar",
            index: 1,
          ),
          _buildNavItem(
            icon: Icons.person,
            label: "Profile",
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = widget.currentIndex == index;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.mainGreenColor : AppColors.grayColor,
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? AppColors.mainGreenColor : AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
