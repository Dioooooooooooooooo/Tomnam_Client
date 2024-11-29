import 'package:flutter/material.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
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
            icon: Icons.calendar_month_outlined,
            label: "Calendar",
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.home,
            label: "Home",
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
