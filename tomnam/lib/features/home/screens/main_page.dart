import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/features/calendar/screens/calendar_page.dart';
import 'package:tomnam/features/home/screens/home_page.dart';
import 'package:tomnam/features/profile_management/screens/profile_page.dart';
import 'package:tomnam/commons/widgets/bottom_navbar.dart';

import '../../../commons/widgets/upper_navbar.dart';

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
        flexibleSpace: const UpperNavBar(),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
