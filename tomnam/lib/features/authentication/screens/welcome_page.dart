import 'package:flutter/material.dart';
import 'package:tomnam/commons/widgets/body_text.dart';
import 'package:tomnam/commons/widgets/custom_elevated_button.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/title_text.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';
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
              Color.fromARGB(190, 70, 106, 96),
              BlendMode.multiply,
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
                    Text(
                      "Welcome to\nTOMNAM",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // backgroundColor: AppColors.mainGreenColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Gutom naman!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        // backgroundColor: Colors.
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'SIGN UP AS',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                        height: 16), // for space between 2 buttons below
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            text: 'CUSTOMER',
                            color: AppColors.secondMainGreenColor,
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
                            color: AppColors.secondMainGreenColor,
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
                        // const BodyText(
                        //   text: 'Already have an account?',
                        //   size: BodyTextSize.medium,
                        // ),
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, loginRoute);
                          },
                          child: const Text('Log In',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              )),
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
