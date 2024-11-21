import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final int selectedTabIndex;
  final Function(int) onTabTapped;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedTabIndex,
    required this.onTabTapped,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.tabs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                widget.onTabTapped(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: widget.selectedTabIndex == index
                      ? AppColors.mainGreenColor
                      : AppColors.blackColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    widget.tabs[index],
                    style: TextStyle(
                      color: widget.selectedTabIndex == index
                          ? Colors.white
                          : AppColors.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
