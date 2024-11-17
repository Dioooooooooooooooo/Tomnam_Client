import 'package:flutter/material.dart';
import 'package:tomnam/utils/theme/theme.dart';
import 'features/authentication/screens/welcome_page.dart';

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
      home: const WelcomePage(),
    );
  }
}
