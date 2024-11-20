import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomePage> {
  final List<String> tabs = ["All", "Nearby Store", "Top Food"];
  final List<String> imageList = [
    "assets/image/adobo.jpg",
    "assets/image/bbq-pork.jpg",
    "assets/image/giniling-guisado.jpg",
    "assets/image/pancit.jpg",
  ];
  final List<String> stores = [
    "Danny's Karenderya",
    "Aleng Neneng's Food",
    "Mang Thomas BBQ",
    "Paresan sa Labangon",
  ];
  final List<String> productTitles = [
    "Adobo",
    "BBQ Pork",
    "Giniling Guisado",
    "Pancit",
  ];
  final List<String> prices = ["\$300", "\$650", "\$50", "\$100"];
  final List<String> reviews = ["54", "104", "120", "34"];

  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search and Notification Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: AppColors.blackColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search,
                              color: AppColors.mainGreenColor),
                          border: InputBorder.none,
                          labelText: "Find your product",
                          labelStyle: TextStyle(color: AppColors.blackColor),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: AppColors.blackColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.notifications_none,
                          color: AppColors.mainGreenColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                announcementSection(context),
                const SizedBox(height: 20),

                // Tabs
                Container(
                  width: double.infinity, // Ensure tabs span the full width
                  height: 40,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTabIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: selectedTabIndex == index
                                  ? AppColors.mainGreenColor
                                  : AppColors.blackColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  color: selectedTabIndex == index
                                      ? Colors.white
                                      : AppColors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Dynamic Content Based on Selected Tab
                if (selectedTabIndex == 0) ...[
                  const Text(
                    "All Stores",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  buildStores(),
                  const SizedBox(height: 20),
                  const Text(
                    "Featured Foods",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  buildFood(),
                ] else if (selectedTabIndex == 1) ...[
                  const Text(
                    "Nearby Stores",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  buildStores(),
                ] else if (selectedTabIndex == 2) ...[
                  const Text(
                    "Featured Foods",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  buildFood(vertical: true),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget announcementSection(BuildContext context) {
    return Container(
      width: double
          .infinity, // This ensures the announcement section spans the full width
      height: 300,
      decoration: BoxDecoration(
        gradient: AppColors.gradientGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Announcement Text with Bold Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(text: "You have "),
                  TextSpan(
                    text: "2 orders",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(text: " reserved today."),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between text and buttons
          // Buttons for Each Order
          buildOrderButton("Karenderya ni Danny 12:00pm", context),
          const SizedBox(height: 10),
          buildOrderButton("Boarding House ni James 3:00pm", context),
        ],
      ),
    );
  }

  Widget buildOrderButton(String orderDetails, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, calendarRoute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          orderDetails,
          style: const TextStyle(
            color: AppColors.mainGreenColor,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget buildStores() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, storeRoute);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.blackColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageList[index % imageList.length],
                    height: 90,
                    width: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stores[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: AppColors.mainOrangeColor, size: 18),
                        Text(
                          " ${reviews[index]} reviews",
                          style: const TextStyle(color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFood({bool vertical = false}) {
    return vertical
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productTitles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, foodOverviewRoute);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          imageList[index % imageList.length],
                          height: 90,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productTitles[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            prices[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productTitles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, foodOverviewRoute);
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            imageList[index % imageList.length],
                            height: 140,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          productTitles[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          prices[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}


// extract and make a widget out of this