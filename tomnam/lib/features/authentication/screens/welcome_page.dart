import 'package:flutter/material.dart';
import 'customer_registration_page.dart';
import 'owner_registration_page.dart';
import 'login_page.dart';

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
                    Text(
                      'Welcome to\nTOMNAM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Gutom naman!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'SIGN UP AS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildButton(
                            context,
                            'CUSTOMER',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CustomerRegistrationPage(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildButton(
                            context,
                            'OWNER',
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OwnerRegistrationPage(),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const LoginPage(),
                              ),
                            );
                          },
                          splashColor:
                              Colors.blueAccent, // Customize ripple color
                          highlightColor: Colors.blue
                              .withOpacity(0.2), // Highlight color when pressed
                          borderRadius: BorderRadius.circular(8),
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

  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return Material(
      color:
          Colors.transparent, // Ensure that the Material widget is transparent
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.blueAccent, // Customize the ripple color
        highlightColor:
            Colors.blue.withOpacity(0.2), // Highlight color when pressed
        borderRadius:
            BorderRadius.circular(16), // Match the button's border radius
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
