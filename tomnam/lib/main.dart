import 'package:flutter/material.dart';
import 'package:tomnam/commons/widgets/karenderya_display_widget.dart';
import 'package:tomnam/features/authentication/screens/customer_registration_page.dart';
import 'package:tomnam/features/authentication/screens/login_page.dart';
import 'package:tomnam/features/authentication/screens/owner_registration_page.dart';
import 'package:tomnam/features/authentication/screens/proof_of_business_page.dart';
import 'package:tomnam/features/calendar/screens/calendar_page.dart';
import 'package:tomnam/features/karenderya_search/screens/search_page.dart';
import 'package:tomnam/features/profile_management/screens/behavior_score_page.dart';
import 'package:tomnam/features/profile_management/screens/karenderya_display_edit_page.dart';
import 'package:tomnam/features/reserve/add_to_cart_page.dart';
import 'package:tomnam/features/reserve/reserve_food_page.dart';
import 'package:tomnam/features/home/screens/home_page.dart';
import 'package:tomnam/features/home/screens/main_page.dart';
import 'package:tomnam/features/home/screens/store_page.dart';
import 'package:tomnam/features/profile_management/screens/profile_page.dart';
import 'package:tomnam/utils/theme/theme.dart';
import 'features/authentication/screens/karenderya_registration_page.dart';
import 'features/authentication/screens/welcome_page.dart';
import '/utils/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: TApptheme.lightTheme,
      darkTheme: TApptheme.darkTheme,
      title: 'Tomnam',
      debugShowCheckedModeBanner: false,
      initialRoute: welcomeRoute,
      routes: {
        welcomeRoute: (context) => const WelcomePage(),
        loginRoute: (context) => const LoginPage(),
        customerRegisterRoute: (context) => const CustomerRegistrationPage(),
        ownerRegisterRoute: (context) => const OwnerRegistrationPage(),
        karenderyaRegisterRoute: (context) =>
            const KarenderyaRegistrationPage(),
        proofOfBusinessRoute: (context) => const ProofOfBusinessPage(),
        homeRoute: (context) => const HomePage(),
        storeRoute: (context) => const StorePage(),
        reserveFoodRoute: (context) => const ReserveFoodPage(),
        calendarRoute: (context) => const CalendarPage(),
        profilePageRoute: (context) => const ProfilePage(),
        addToCartRoute: (context) => const AddToCartPage(),
        searchPageRoute: (context) => const SearchPage(),
        mainPageRoute: (context) => const MainPage(),
        behaviorScoreClickedRoute: (context) => const BehaviorScorePage(),
        editKarenderyaDisplayRoute: (context) =>
            const KarenderyaDisplayEditPage(),
      },
    );
  }
}

// styles/app color/ && /app dimensions/ && /app text style/ -> theme ->  widget