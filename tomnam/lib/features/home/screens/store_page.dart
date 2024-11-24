import 'package:flutter/material.dart';
import '../../../commons/widgets/search_bar.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomSearchBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner with Profile Overlap
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Banner Image
                  Container(
                    height: 201,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/cover-photo.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                  ),

                  // Profile Section
                  Positioned(
                    bottom: -43.5, // Adjust to overlap by half the profile size
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Container(
                          width: 87,
                          height: 87,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x4CFFC529),
                                blurRadius: 36.23,
                                offset: Offset(0, 13.58),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 69,
                              height: 69,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFC529),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person,
                                  size: 36, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Spacing below Profile Section
              // Store Description Section
              const SizedBox(height: 50),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Aligns the Column's children to the center
                    children: [
                      Text(
                        'Karenderya ni Danny',
                        style: TextStyle(
                          color: Color(0xFF272827),
                          fontSize: 26,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Brngy Labangon, Near CIT Backgate',
                        style: TextStyle(
                          color: Color(0xFF9796A1),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // About Section
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: Text(
                  'Hello. I’m Danny! A chef graduate at CIT. We give free munchkins as a general snack and free takoyaki to our frequent users.',
                  style: TextStyle(
                    color: Color(0xFF272827),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // Bottom Card
              const SizedBox(height: 30),
              Container(
                height: 86,
                color: Colors.white,
                child: const Center(
                  child: Text(
                    "Additional Information Here",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),

              // Divider
              Container(
                height: 0.5,
                color: const Color(0xFFD7D7D7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
