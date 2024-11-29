import 'package:flutter/material.dart';
import 'package:tomnam/commons/widgets/food_list.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<String> foodNames = [
    "Adobo",
    "BBQ Pork",
    "Giniling Guisado",
    "Pancit"
  ];

  final List<String> foodPrices = ["300", "650", "50", "100"];

  final List<String> foodImages = [
    "assets/images/adobo.jpg",
    "assets/images/bbq-pork.jpg",
    "assets/images/giniling-guisado.jpg",
    "assets/images/pancit.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const UpperNavBar(),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner Image
                Container(
                  height: 201,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/karenderya_3.jpg"),
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
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
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
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/danny-photo.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Review Karenderya Stars
                      Positioned(
                        right: 18,
                        top: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Store Description Section
            const SizedBox(height: 50),
            Container(
              color: AppColors.whiteColor,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
            ),

            // About Section
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
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
            const SizedBox(height: 16),
            // Divider
            Container(
              height: 0.5,
              color: AppColors.grayColor,
            ),
            const SizedBox(height: 25),

            // Food List Section
            FoodList(
              productTitles: foodNames,
              imageList: foodImages,
              prices: foodPrices,
            ),
          ],
        ),
      ),
    );
  }
}
