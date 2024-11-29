import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/custom_searchbar.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/store_list_vertical.dart';
import 'package:tomnam/commons/widgets/food_list.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> stores = [
    "Danny's Karenderya",
    "Aleng Neneng's Food",
    "Mang Thomas BBQ",
    "Paresan sa Labangon",
  ];

  final List<String> storeImageList = [
    "assets/images/karenderya_3.jpg",
    "assets/images/karenderya_4.jpg",
    "assets/images/karenderya_1.jpg",
    "assets/images/karenderya_2.jpg",
  ];

  final List<String> storeReviews = ["54", "104", "120", "34"];

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

  String query = "";
  bool isFoodSelected = false;
  bool isStoreSelected = false;
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomSearchBar(
          hintText: "Search for stores or food...",
          onChanged: (value) {
            setState(() {
              query = value;
              isFoodSelected = false;
              isStoreSelected = false;
            });
            logger.i('Search text: $value');
          },
          onSearchPressed: () {
            logger.i('Search button pressed');
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadlineText(
                    text: "Search Results",
                    size: HeadlineSize.small,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),

                  // Conditional display based on the search query
                  query.isEmpty
                      ? const Text(
                          "Your query will be displayed here",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      : Column(
                          children: [
                            Text('Results for: "$query"'),
                            const SizedBox(height: 10),

                            if (query.isNotEmpty) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.grayColor,
                                        foregroundColor: AppColors.blackColor,
                                        shape: null,
                                        side: BorderSide(
                                          color: isFoodSelected
                                              ? Colors.black
                                              : Colors
                                                  .transparent, // Border when selected
                                          width: 2, // Thickness of the border
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isFoodSelected = true;
                                          isStoreSelected = false;
                                        });
                                      },
                                      child: const Text("Food"),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.grayColor,
                                        foregroundColor: AppColors.blackColor,
                                        shape: null,
                                        side: BorderSide(
                                          color: isStoreSelected
                                              ? Colors.black
                                              : Colors
                                                  .transparent, // Border when selected
                                          width: 2, // Thickness of the border
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isStoreSelected = true;
                                          isFoodSelected = false;
                                        });
                                      },
                                      child: const Text("Store"),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],

                            // Show food results based on query if the 'Food' button is selected
                            if (isFoodSelected) ...[
                              FoodList(
                                productTitles: foodNames
                                    .where((food) => food
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                    .toList(),
                                imageList: foodImages
                                    .where((image) =>
                                        foodNames[foodImages.indexOf(image)]
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                    .toList(),
                                prices: foodPrices
                                    .where((price) =>
                                        foodNames[foodPrices.indexOf(price)]
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                    .toList(),
                                isVertical: true,
                              ),

                              // message if no food was found
                              if (foodNames
                                  .where((food) => food
                                      .toLowerCase()
                                      .contains(query.toLowerCase()))
                                  .isEmpty) ...[
                                const SizedBox(height: 10),
                                Text(
                                  "No food results found for '$query'",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ],

                            // Show store results based on query if the 'Store' button is selected
                            if (isStoreSelected) ...[
                              StoreListVertical(
                                stores: stores
                                    .where((store) => store
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                    .toList(),
                                imageList: storeImageList
                                    .where((image) =>
                                        stores[storeImageList.indexOf(image)]
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                    .toList(),
                                reviews: storeReviews
                                    .where((review) =>
                                        stores[storeReviews.indexOf(review)]
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                    .toList(),
                              ),

                              // message if no store results found
                              if (stores
                                  .where((store) => store
                                      .toLowerCase()
                                      .contains(query.toLowerCase()))
                                  .isEmpty) ...[
                                const SizedBox(height: 10),
                                Text(
                                  "No stores found for '$query'",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ],
                          ],
                        ),

                  const SizedBox(height: 40),

                  const HeadlineText(
                    text: "Nearby Stores",
                    size: HeadlineSize.small,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  StoreListVertical(
                    stores: stores,
                    imageList: storeImageList,
                    reviews: storeReviews,
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
