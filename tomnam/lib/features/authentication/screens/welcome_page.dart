import 'package:flutter/material.dart';
import 'package:tomnam/commons/widgets/body_text.dart';
import 'package:tomnam/commons/widgets/custom_elevated_button.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/title_text.dart';
import '../../../utils/constants/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background for tomnam.jpg'),
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
                    HeadlineText(
                      text: "Welcome to\nTOMNAM",
                      size: HeadlineSize.large,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    HeadlineText(
                      text: "Gutom naman!",
                      size: HeadlineSize.small,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TitleText(
                      text: 'SIGN UP AS',
                      textAlign: TextAlign.left,
                      size: TitleSize.medium,
                    ),
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
                        const BodyText(
                          text: 'Already have an account?',
                          size: BodyTextSize.medium,
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, loginRoute);
                          },
                          child: const BodyText(
                            text: 'Log In?',
                            size: BodyTextSize.medium,
                            decoration: TextDecoration.underline,
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
