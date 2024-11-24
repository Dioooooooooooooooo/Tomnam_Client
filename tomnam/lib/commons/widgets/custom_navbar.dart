import 'package:flutter/material.dart';
import 'package:tomnam/features/home/screens/home_page.dart';
import 'package:tomnam/features/karenderya_search/screens/search_page.dart';
import 'package:tomnam/features/profile_management/screens/profile_page.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => _pages[index],
        ),
      );
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Navbar Example")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
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
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
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
