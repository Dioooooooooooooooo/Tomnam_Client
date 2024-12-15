import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/custom_searchbar.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/store_list_vertical.dart';
import 'package:tomnam/commons/widgets/food_list.dart';
import 'package:tomnam/features/controllers/foods_controller.dart';
import 'package:tomnam/features/controllers/profile_controller.dart';
import 'package:tomnam/models/food.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/features/controllers/karenderyas_controller.dart';
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
  bool? isOwner;
  final logger = Logger();

  @override
  void initState() async {
    super.initState();

    final user = await ProfileController.getUser();
    isOwner = (user.role == "Owner");
  }

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
                              FutureBuilder<List<Food>>(
                                future: FoodsController.read(
                                    null, // foodId
                                    query, // foodName
                                    null), // Call your async function
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Show a loading indicator while waiting for the result
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    // Handle errors
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    // Render the fetched stores
                                    return FoodList(
                                        snapshot.data ?? [], true, isOwner!);
                                  } else {
                                    // Handle empty results
                                    return const Center(
                                        child: Text('No stores found.'));
                                  }
                                },
                              ),
                            ],

                            // Show store results based on query if the 'Store' button is selected
                            if (isStoreSelected) ...[
                              FutureBuilder<List<Karenderya>>(
                                future: KarenderyasController.read(
                                  null, // karenderyaId
                                  query, // name
                                  null, // locationStreet
                                  null, // locationBarangay
                                  null, // locationCity
                                  null, // locationProvince
                                ), // Call your async function
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Show a loading indicator while waiting for the result
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    // Handle errors
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else if (snapshot.hasData &&
                                      snapshot.data!.isNotEmpty) {
                                    // Render the fetched stores
                                    return StoreListVertical(
                                        snapshot.data ?? []);
                                  } else {
                                    // Handle empty results
                                    return const Center(
                                        child: Text('No stores found.'));
                                  }
                                },
                              ),
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
                  // StoreListVertical(
                  //   stores: stores,
                  //   imageList: storeImageList,
                  //   reviews: storeReviews,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
