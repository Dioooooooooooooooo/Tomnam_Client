import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/features/calendar/screens/calendar_page.dart';
import 'package:tomnam/features/home/screens/home_page.dart';
import 'package:tomnam/features/profile_management/screens/profile_page.dart';
import 'package:tomnam/commons/widgets/custom_navbar.dart';

import '../../../commons/widgets/custom_searchbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainPage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const CalendarPage(),
    const HomePage(),
    const ProfilePage(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomSearchBar(
          hintText: "Search here...",
          onChanged: (value) {
            logger.i('Search text: $value');
          },
          onSearchPressed: () {
            logger.i('Search button pressed');
          },
          onClearPressed: () {
            logger.i('Clear button pressed');
          },
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
