import 'package:flutter/material.dart';
import 'constants/routes.dart';
import 'view/store/food_overview.dart';
import 'view/store/store_view.dart';
import 'view/user_management/welcome_view.dart';
import 'view/home/home_view.dart';
import 'view/user_management/login_view.dart';
import 'view/user_management/customer_register_view.dart';
import 'view/user_management/owner_register_view.dart';
import 'view/calendar/calendar_view.dart';
import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomnam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mainGreenColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: welcomeRoute, // Default route
      routes: {
        welcomeRoute: (context) => const WelcomeView(),
        loginRoute: (context) => const LoginView(),
        customerRegisterRoute: (context) => const CustomerRegistrationView(),
        ownerRegisterRoute: (context) => const OwnerRegistrationView(),
        homeRoute: (context) => const HomeView(),
        storeRoute: (context) => const StoreView(),
        foodOverviewRoute: (context) => const FoodOverview(),
        calendarRoute: (context) => const CalendarView(),
      },
    );
  }
}
