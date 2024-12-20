import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/food_list.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/foods_controller.dart';
import 'package:tomnam/features/controllers/profile_controller.dart';
import 'package:tomnam/models/food.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  bool? _isOwner;
  bool _isLoading = true;
  late Karenderya _store;
  List<Food> _foods = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _store = arguments['store'] as Karenderya;
      _logger.d('Received store data: $_store');

      final user = await ProfileController.getUser();
      _isOwner = (user.role == 'Owner');

      _fetchFoods();
    } else {
      _logger.e('No store data found in arguments');
    }
  }

  Future<void> _fetchFoods() async {
    try {
      final foods = await FoodsController.read(
          null, // foodId
          null, // foodName
          _store.Id);
      _logger.d('Foods: $foods');
      setState(() {
        _foods = foods;
        _isLoading = false;
      });
    } catch (e) {
      _logger.e('Error fetching Foods: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              flexibleSpace: UpperNavBar(_isOwner!),
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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _store.logoPhoto != null
                                ? NetworkImage(
                                    '${ApiService.baseURL}/${_store.coverPhoto}')
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
                                        image: _store.logoPhoto != null
                                            ? NetworkImage(
                                                '${ApiService.baseURL}/${_store.logoPhoto}')
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

                            // Review Karenderya Stars
                            Positioned(
                                right: 18,
                                top: 50,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _store.rating.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            5), // Space between stars and text
                                    // Generate the stars based on a dynamic rating
                                    ...List.generate(
                                      5,
                                      (index) => const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                )),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _store.name,
                              style: const TextStyle(
                                color: Color(0xFF272827),
                                fontSize: 26,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                '${_store.locationStreet}, ${_store.locationBarangay}, ${_store.locationCity}, ${_store.locationProvince}',
                                style: const TextStyle(
                                  color: Color(0xFF9796A1),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // About Section
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      _store.description ?? '',
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
                  const SizedBox(height: 25),

                  // Food List Section
                  FoodList(_foods, true, _isOwner!),
                ],
              ),
            ),
          );
  }
}
