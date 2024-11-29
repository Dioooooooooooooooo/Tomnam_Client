import 'package:flutter/material.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 360,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                // Divider Line
                Positioned(
                  left: -18,
                  top: 253,
                  child: Container(
                    width: 397,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFD7D7D7),
                        ),
                      ),
                    ),
                  ),
                ),

                // Restaurant Name Section
                Positioned(
                  left: 21,
                  top: 91,
                  child: SizedBox(
                    width: 318,
                    height: 22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 20.13,
                          height: 20,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFD7D7D7)),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 8), // Added spacing between icon and text
                        const Text(
                          'Karenderya ni Danny',
                          style: TextStyle(
                            color: Color(0xFF272827),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Add additional content here as necessary.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
