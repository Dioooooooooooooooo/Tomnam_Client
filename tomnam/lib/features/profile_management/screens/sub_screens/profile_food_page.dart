import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/Exceptions/response_exception.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/foods_controller.dart';
import 'package:tomnam/models/food.dart';

class ProfileFoodPage extends StatefulWidget {
  const ProfileFoodPage({super.key});

  @override
  State<ProfileFoodPage> createState() => _ProfileFoodPageState();
}

class _ProfileFoodPageState extends State<ProfileFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _foodDescriptionController = TextEditingController();
  final _foodUnitPriceController = TextEditingController();

  // Initialize ImagePicker
  final ImagePicker _picker = ImagePicker();

  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  late String _karenderyaName;
  File? _image;
  late Food? _food;
  bool _isLoading = true;
  bool _isUpdating = false;
  bool _uploadedPhoto = false;
  bool _fetchedArguments = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _karenderyaName = arguments['karenderyaName'] as String;
      _isUpdating = arguments['isUpdating'] as bool;
      _logger.d('Received store data: $_karenderyaName');

      if (_isUpdating && !_fetchedArguments) {
        _food = arguments['food'] as Food;
        _logger.d('Received food data: $_food');
        final foodPhotoPath = _food!.foodPhoto;
        _image = File(foodPhotoPath!);

        _foodNameController.text = _food!.foodName;
        _foodDescriptionController.text = _food!.foodDescription;
        _foodUnitPriceController.text = _food!.unitPrice.toString();
      }
      _isLoading = false;
    } else {
      _logger.e('No karenderya data found in arguments');
    }

    _fetchedArguments = true;
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _foodDescriptionController.dispose();
    _foodUnitPriceController.dispose();
    super.dispose();
  }

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Save picked image
        _uploadedPhoto = true;
      });
    }
  }

  // create food
  void _handleCreateFood() async {
    if (_formKey.currentState!.validate()) {
      final foodName = _foodNameController.text.trim();
      final foodUnitPrice = _foodUnitPriceController.text.trim();
      final foodDescription = _foodDescriptionController.text.trim();

      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload food photo')),
        );
        return;
      }

      try {
        final message = await FoodsController.create({
          'FoodName': foodName,
          'FoodDescription': foodDescription,
          'UnitPrice': foodUnitPrice
        }, _image!);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        // Navigate back to previous screen
      } catch (e, stackTrace) {
        if (!context.mounted) return;
        String? message;
        if (e is ResponseException) {
          message = e.error;
        } else {
          message = 'An error occurred during food creation';
        }
        _logger.d(stackTrace);
        _logger.e('An error occurred during food creation: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  // update food
  void _handleUpdateFood() async {
    if (_formKey.currentState!.validate()) {
      final foodName = _foodNameController.text.trim();
      final foodUnitPrice = _foodUnitPriceController.text.trim();
      final foodDescription = _foodDescriptionController.text.trim();

      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload food photo')),
        );
        return;
      }

      try {
        var message;
        if (_uploadedPhoto) {
          message = await FoodsController.update(
              _food!.Id,
              {
                'FoodName': foodName,
                'FoodDescription': foodDescription,
                'UnitPrice': foodUnitPrice
              },
              _image!);
        } else {
          message = await FoodsController.update(
              _food!.Id,
              {
                'FoodName': foodName,
                'FoodDescription': foodDescription,
                'UnitPrice': foodUnitPrice
              },
              null);
        }
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        // Navigate back to previous screen
      } catch (e, stackTrace) {
        if (!context.mounted) return;
        String? message;
        if (e is ResponseException) {
          message = e.error;
        } else {
          message = 'An error occurred during food update';
        }
        _logger.d(stackTrace);
        _logger.e('An error occurred during food update: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  // Delete Food
  void _handleDeleteFood() async {
    try {
      final message = await FoodsController.delete(_food!.Id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e, stackTrace) {
      if (!context.mounted) return;
      String? message;
      if (e is ResponseException) {
        message = e.error;
      } else {
        message = 'An error occurred during food deletion';
      }
      _logger.d(stackTrace);
      _logger.e('An error occurred during food deletion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
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
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _karenderyaName,
                        style: const TextStyle(
                          color: Color(0xFF006A60),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _isUpdating ? 'Update Food' : 'Add Food',
                        style: const TextStyle(
                          color: Color(0xFF006A60),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: _foodNameController,
                        label: 'Food Name',
                        icon: Icons.fastfood_outlined,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: _foodDescriptionController,
                        label: 'Food Description',
                        minLines: 3,
                        icon: Icons.text_fields_rounded,
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        controller: _foodUnitPriceController,
                        label: 'Unit Price',
                        isNumber: true,
                        icon: Icons.money,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                  image: _image != null
                                      ? (_isUpdating && !_uploadedPhoto)
                                          ? NetworkImage(
                                              '${ApiService.baseURL}/${_food!.foodPhoto}')
                                          : FileImage(_image!)
                                      : const AssetImage(
                                              'assets/images/placeholder_food.png')
                                          as ImageProvider,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton.icon(
                                  onPressed: _pickImage,
                                  label: const Text('Upload Food Image'),
                                  icon: const Icon(Icons.add_a_photo),
                                  style: const ButtonStyle(
                                      padding: WidgetStatePropertyAll(
                                          EdgeInsets.all(15))),
                                  iconAlignment: IconAlignment.start,
                                ),
                              ),
                              // const SizedBox(height: 10),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.5,
                              //   child: ElevatedButton.icon(
                              //     onPressed: _pickImage,
                              //     label: const Text('Delete Food'),
                              //     icon: const Icon(Icons.delete_outline),
                              //     style: const ButtonStyle(
                              //       padding: WidgetStatePropertyAll(
                              //           EdgeInsets.all(15)),
                              //       backgroundColor: WidgetStatePropertyAll(
                              //           Colors.redAccent),
                              //     ),
                              //     iconAlignment: IconAlignment.start,
                              //   ),
                              // )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: _isUpdating
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          _isUpdating
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ElevatedButton.icon(
                                    onPressed: _handleDeleteFood,
                                    label: const Text('Delete Food'),
                                    icon: const Icon(Icons.delete_outline),
                                    style: const ButtonStyle(
                                      padding: WidgetStatePropertyAll(
                                          EdgeInsets.all(15)),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.redAccent),
                                    ),
                                    iconAlignment: IconAlignment.start,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            // width: double.infinity,
                            width: MediaQuery.of(context).size.width *
                                (_isUpdating ? 0.4 : 0.85),
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isUpdating
                                  ? _handleUpdateFood
                                  : _handleCreateFood,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFA62B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                _isUpdating ? 'UPDATE FOOD' : 'ADD FOOD',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int minLines = 1,
    bool isPassword = false,
    bool isNumber = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      minLines: minLines,
      maxLines: 5,
      keyboardType: !isNumber
          ? keyboardType
          : const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF006A60)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }

        if (isNumber && !RegExp(r'^\d*\.?\d*$').hasMatch(value)) {
          return 'Please enter a valid number';
        }

        return null;
      },
    );
  }
}
