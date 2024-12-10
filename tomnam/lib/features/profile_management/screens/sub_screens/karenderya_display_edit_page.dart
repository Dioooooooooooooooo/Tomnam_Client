import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/food_list_edit_item.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/foods_controller.dart';
import 'package:tomnam/models/food.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class KarenderyaDisplayEditPage extends StatefulWidget {
  const KarenderyaDisplayEditPage({super.key});

  @override
  State<KarenderyaDisplayEditPage> createState() =>
      _KarenderyaDisplayEditPageState();
}

class _KarenderyaDisplayEditPageState extends State<KarenderyaDisplayEditPage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  late Karenderya _karenderya;
  late List<Food> _food;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _karenderya = arguments['karenderya'] as Karenderya;
      _logger.d('Received store data: $_karenderya');
      _fetchFood();
    } else {
      _logger.e('No user data found in arguments');
    }
  }

  Future<void> _pressedAddFood() async {
    Navigator.pushNamed(context, addFoodRoute,
        arguments: {'karenderyaName': _karenderya.name, 'isUpdating': false});
  }

  Future<void> _fetchFood() async {
    try {
      final foods = await FoodsController.read(
          null, // foodId
          null, // foodName
          _karenderya.Id);
      _logger.d('Foods: $foods');
      setState(() {
        _food = foods;
        _isLoading = false;
      });
    } catch (e) {
      _logger.e('Error fetching Foods: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const UpperNavBar(),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loader while fetching
            : ListView(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Banner Image
                      Container(
                        height: 201,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _karenderya.logoPhoto != null
                                ? NetworkImage(
                                    '${ApiService.baseURL}/${_karenderya.coverPhoto}')
                                : const AssetImage(
                                        'assets/images/placeholder_cover.webp')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),

                      // Profile Section
                      Positioned(
                        bottom:
                            -43.5, // Adjust to overlap by half the profile size
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
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: _karenderya.logoPhoto != null
                                            ? NetworkImage(
                                                '${ApiService.baseURL}/${_karenderya.logoPhoto}')
                                            : const AssetImage(
                                                    'assets/images/placeholder_logo.png')
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Upload Cover Button
                            // Positioned(
                            //     right: MediaQuery.of(context).size.width * 0.35,
                            //     top: 40,
                            //     child: IconButton(
                            //       icon: const Icon(Icons.camera_alt_sharp,
                            //           size: 18, color: Colors.black54),
                            //       onPressed:
                            //           () {}, // Supposed to be upload an image file
                            //       style: const ButtonStyle(
                            //           padding:
                            //               WidgetStatePropertyAll(EdgeInsets.all(2.0)),
                            //           backgroundColor: WidgetStatePropertyAll(
                            //               AppColors.whiteColor),
                            //           shadowColor:
                            //               WidgetStatePropertyAll(Colors.black)),
                            //     )),

                            // Store Edit Button
                            Positioned(
                              top: 45,
                              right: MediaQuery.of(context).size.width * 0.01,
                              child: IconButton(
                                  iconSize: 30.0,
                                  icon: const Icon(Icons.edit_outlined),
                                  onPressed: () {}),
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
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _karenderya.name,
                            style: const TextStyle(
                              color: Color(0xFF272827),
                              fontSize: 26,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on,
                                  color: AppColors.mainGreenColor, size: 15),
                              const SizedBox(width: 10),
                              Text(
                                '${_karenderya.locationStreet}, ${_karenderya.locationBarangay}, ${_karenderya.locationCity}, ${_karenderya.locationProvince}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 87, 87, 87),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  // About Section
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      _karenderya.description ?? '',
                      style: const TextStyle(
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
                  const SizedBox(height: 10),
                  // Food List
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(color: AppColors.grayColor),
                    child: // Add Food Button
                        Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: _food.length,
                            itemBuilder: (context, index) {
                              return FoodListEditItem(
                                  _food[index], _karenderya.name);
                            },
                          ),
                        ),
                        // Add More Food Button
                        const SizedBox(height: 10),
                        const Text(
                          'ADD MORE FOOD',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 24,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: _pressedAddFood,
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  AppColors.mainGreenColor)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _pressedAddFood,
      //   label: const Text(
      //     'Add food',
      //     style: TextStyle(color: AppColors.whiteColor, fontSize: 24),
      //     softWrap: true,
      //   ),
      //   icon: const Icon(
      //     Icons.add,
      //     size: 25,
      //     color: AppColors.whiteColor,
      //   ),
      //   backgroundColor: AppColors.mainGreenColor,
      //   elevation: 0, // To remove shadow
      // ),
    );
  }
}
