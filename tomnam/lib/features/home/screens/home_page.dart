import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/custom_searchbar.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import '../../../commons/widgets/announcement_section.dart';
import '../../../commons/widgets/tab_bar.dart';
import '../../../commons/widgets/store_list.dart';
import '../../../commons/widgets/food_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tabs = ["All", "Nearby Store", "Top Food"];
  final List<String> imageList = [
    "assets/images/adobo.jpg",
    "assets/images/bbq-pork.jpg",
    "assets/images/giniling-guisado.jpg",
    "assets/images/pancit.jpg",
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
  final logger = Logger();

  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            CustomSearchBar(
              hintText: "Search here...",
              onChanged: (value) {
                logger.i('Search text: $value');
              },
              onSearchPressed: () {
                logger.i(
                    'Search button pressed'); // to retrieve foods/stores that resembles the search
              },
              onClearPressed: () {
                logger.i('Clear button pressed'); // to clear the search area
              },
            ),
            const SizedBox(height: 20),
            const AnnouncementSection(),
            const SizedBox(height: 20),
            CustomTabBar(
              tabs: tabs,
              selectedTabIndex: selectedTabIndex,
              onTabTapped: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
            ),
            const SizedBox(height: 20),
            if (selectedTabIndex == 0) ...[
              // sa tanang text makita nnyo gamita nani na widget, could be headline title body or label nawa sa widgets folder
              const HeadlineText(
                text: "All stores",
                size: HeadlineSize.small,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              StoreList(stores: stores, imageList: imageList, reviews: reviews),
              const SizedBox(height: 20),

              const Text(
                "Featured Foods",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // mao nani shanley e pass ra nato ang parameter nya si foodlist widget nay bahalag render
              FoodList(
                  productTitles: productTitles,
                  imageList: imageList,
                  prices: prices),
            ] else if (selectedTabIndex == 1) ...[
              const Text(
                "Nearby Stores",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // same sa storelist
              StoreList(stores: stores, imageList: imageList, reviews: reviews),
            ] else if (selectedTabIndex == 2) ...[
              const Text(
                "Featured Foods",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FoodList(
                  productTitles: productTitles,
                  imageList: imageList,
                  prices: prices,
                  isVertical: true),
            ],
          ],
        ),
      ),
      // bottomNavigationBar: const CustomNavBar(),
    );
  }
}
