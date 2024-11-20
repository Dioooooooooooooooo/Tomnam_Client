import 'package:flutter/material.dart';
import 'package:tomnam/commons/widgets/custom_elevated_button.dart';
import 'package:tomnam/commons/widgets/headline_large.dart';
import 'package:tomnam/commons/widgets/headline_medium.dart';
import 'package:tomnam/commons/widgets/headline_small.dart';
import 'package:tomnam/commons/widgets/title_large.dart';
import '../../../utils/constants/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background for tomnam.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFF006A60),
              BlendMode.overlay,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    CustomHeadlineLarge(text: "Welcome to\nTOMNAM"),
                    SizedBox(
                      height: 8,
                    ),
                    CustomHeadlineSmall(text: "Gutom naman!"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CustomTitleLarge(
                        text: 'SIGN UP AS', textAlign: TextAlign.left),
                    const SizedBox(
                        height: 16), // for space between 2 buttons below
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            text: 'CUSTOMER',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                customerRegisterRoute,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomElevatedButton(
                            text: 'OWNER',
                            onPressed: () => Navigator.pushNamed(
                              context,
                              ownerRegisterRoute,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // use bodyLarge maybe
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, loginRoute);
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
