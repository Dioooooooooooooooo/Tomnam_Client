import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/store_list_vertical.dart';
import '../../../commons/widgets/announcement_section.dart';
import '../../../commons/widgets/tab_bar.dart';
import '../../../commons/widgets/store_list_horizontal.dart';
import '../../../commons/widgets/food_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tabs = ["All", "Nearby Store", "Top Food"];
  final List<String> foodImageList = [
    "assets/images/adobo.jpg",
    "assets/images/bbq-pork.jpg",
    "assets/images/giniling-guisado.jpg",
    "assets/images/pancit.jpg",
  ];
  final List<String> storeImageList = [
    "assets/images/karenderya_3.jpg",
    "assets/images/karenderya_4.jpg",
    "assets/images/karenderya_1.jpg",
    "assets/images/karenderya_2.jpg",
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
          children: [
            const AnnouncementSection(),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadlineText(
                    text: "Latest Reservations",
                    size: HeadlineSize.small,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  StoreListHorizontal(
                    stores: stores,
                    imageList: storeImageList,
                    reviews: reviews,
                  ),
                  const SizedBox(height: 20),
                  const HeadlineText(
                    text: "Reserve Now",
                    size: HeadlineSize.small,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  StoreListVertical(
                    stores: stores,
                    imageList: storeImageList,
                    reviews: reviews,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
