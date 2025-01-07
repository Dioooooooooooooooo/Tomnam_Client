import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/Exceptions/response_exception.dart';
import 'package:tomnam/commons/widgets/food_list_edit_item.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/foods_controller.dart';
import 'package:tomnam/features/controllers/karenderyas_controller.dart';
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

  late String _karenderyaId;
  Karenderya? _karenderya;
  late List<Food> _food;
  bool _isLoading = true;

  final _formKey = GlobalKey<FormState>();
  final _karenderyaNameController = TextEditingController();
  final _karenderyaStreetController = TextEditingController();
  final _karenderyaBarangayController = TextEditingController();
  final _karenderyaCityController = TextEditingController();
  final _karenderyaProvinceController = TextEditingController();
  final _karenderyaDescriptionController = TextEditingController();
  File? _logo;
  File? _cover;
  bool _uploadedLogoPhoto = false;
  bool _uploadedCoverPhoto = false;

  // Initialize ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Function to pick a cover image from gallery or camera
  Future<void> _updateCoverImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _cover = File(pickedFile.path); // Save picked image
        _uploadedCoverPhoto = true;
      });

      _updateKarenderya(null, null, null, null, null, null, null, _cover);
    }
  }

  // updATE
  Future<void> _updateKarenderya(
    String? karenderyaName,
    String? locationStreet,
    String? locationBarangay,
    String? locationCity,
    String? locationProvince,
    String? description,
    File? logoPhoto,
    File? coverPhoto,
  ) async {
    try {
      final message = await KarenderyasController.update(
          _karenderyaId,
          karenderyaName, // karenderyaName
          locationStreet, // locationStreet,
          locationBarangay, // locationBarangay,
          locationCity, // locationCity,
          locationProvince, // locationProvince,
          description, // description,
          logoPhoto, // logoPhoto,
          coverPhoto //coverPhoto
          );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e, stackTrace) {
      if (!context.mounted) return;
      String? message;
      if (e is ResponseException) {
        message = e.error;
      } else {
        message = 'An error occurred during karenderya update';
      }
      _logger.d(stackTrace);
      _logger.e('An error occurred during karenderya update: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> _fetchKarenderya() async {
    try {
      final karenderya = await KarenderyasController.read(
          _karenderyaId,
          null, // karenderyaName
          null, // locationStreet
          null, // locationBarangay
          null, // locationCity
          null // locationProvince
          );
      _logger.d('Karenderya: $karenderya');
      setState(() {
        _karenderya = karenderya[0];
        _fetchFood();
      });
    } catch (e) {
      _logger.e('Error fetching Karenderya: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to pick a logo image from gallery or camera
  Future<void> _updateLogoImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _logo = File(pickedFile.path); // Save picked image
        _uploadedLogoPhoto = true;
      });

      _updateKarenderya(null, null, null, null, null, null, _logo, null);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _karenderyaId = arguments['karenderyaId'] as String;
      _fetchKarenderya();
      _logger.d('Received store data: $_karenderya');
    } else {
      _logger.e('No user data found in arguments');
    }
  }

  Future<void> _pressedAddFood() async {
    Navigator.pushNamed(context, addFoodRoute,
        arguments: {'karenderyaName': _karenderya!.name, 'isUpdating': false});
  }

  Future<void> _fetchFood() async {
    try {
      final foods = await FoodsController.read(
          null, // foodId
          null, // foodName
          _karenderya!.Id);
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
        flexibleSpace: const UpperNavBar(true),
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
                            // Cover Photo
                            image: _karenderya!.coverPhoto != null &&
                                    !_uploadedCoverPhoto
                                ? NetworkImage(
                                    '${ApiService.baseURL}/${_karenderya!.coverPhoto}')
                                : _uploadedCoverPhoto
                                    ? FileImage(_cover!)
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
                                        // Logo Photo
                                        image: _karenderya!.logoPhoto != null &&
                                                !_uploadedLogoPhoto
                                            ? NetworkImage(
                                                '${ApiService.baseURL}/${_karenderya!.logoPhoto}')
                                            : _uploadedLogoPhoto
                                                ? FileImage(_logo!)
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

                            // // Upload Logo Button
                            // Positioned(
                            //     right: MediaQuery.of(context).size.width * 0.35,
                            //     top: 40,
                            //     child: IconButton(
                            //       icon: const Icon(Icons.camera_alt_sharp,
                            //           size: 24, color: Colors.black54),
                            //       onPressed: () {
                            //         _logger.d('pressed');
                            //       }, // Supposed to be upload an image file
                            //       style: const ButtonStyle(
                            //           padding: WidgetStatePropertyAll(
                            //               EdgeInsets.all(2.0)),
                            //           backgroundColor: WidgetStatePropertyAll(
                            //               AppColors.whiteColor),
                            //           shadowColor:
                            //               WidgetStatePropertyAll(Colors.black)),
                            //     )),
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
                            _karenderya!.name,
                            style: const TextStyle(
                              color: Color(0xFF272827),
                              fontSize: 26,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              '${_karenderya!.locationStreet}, ${_karenderya!.locationBarangay}, ${_karenderya!.locationCity}, ${_karenderya!.locationProvince}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 87, 87, 87),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // About Section
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'About',
                          style: TextStyle(
                            color: Color(0xFF272827),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          _karenderya!.description ?? 'No description yet.',
                          style: const TextStyle(
                            color: Color(0xFF272827),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Divider
                  Container(
                    height: 0.5,
                    color: AppColors.grayColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: _updateCoverImage,
                            child: const Text(
                              'Update Cover',
                            )),
                        TextButton(
                            onPressed: _updateLogoImage,
                            child: const Text(
                              'Update Logo',
                            ))
                      ],
                    ),
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
                                  _food[index], _karenderya!.name);
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
