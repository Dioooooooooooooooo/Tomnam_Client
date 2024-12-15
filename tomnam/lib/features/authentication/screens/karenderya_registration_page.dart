import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/utils/constants/routes.dart';
import '../../../Exceptions/response_exception.dart';
import '../../controllers/karenderyas_controller.dart';

class KarenderyaRegistrationPage extends StatefulWidget {
  const KarenderyaRegistrationPage({super.key});

  @override
  State<KarenderyaRegistrationPage> createState() =>
      _KarenderyaRegistrationPageState();
}

class _KarenderyaRegistrationPageState
    extends State<KarenderyaRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _karenderyaNameController = TextEditingController();
  final _karenderyaStreetController = TextEditingController();
  final _karenderyaBarangayController = TextEditingController();
  final _karenderyaCityController = TextEditingController();
  final _karenderyaProvinceController = TextEditingController();
  final _karenderyaDateFoundedController = TextEditingController();
  final _karenderyaDescriptionController = TextEditingController();
  final _logger = Logger();

  void _karenderyaSignup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final name = _karenderyaNameController.text.trim();
      final city = _karenderyaCityController.text.trim();
      final street = _karenderyaStreetController.text.trim();
      final barangay = _karenderyaBarangayController.text.trim();
      final province = _karenderyaProvinceController.text.trim();
      final dateFounded = _karenderyaDateFoundedController.text.trim();
      final description = _karenderyaDescriptionController.text.trim();

      try {
        final Karenderya = await KarenderyasController.create({
          "Name": name,
          "LocationCity": city,
          "LocationStreet": street,
          "LocationBarangay": barangay,
          "LocationProvince": province,
          "DateFounded": dateFounded,
          "Description": description,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Karenderya Created Successfully")),
        );

        Navigator.of(context).popAndPushNamed(proofOfBusinessRoute,
            arguments: {"Karenderya": Karenderya});
      } catch (e, stackTrace) {
        if (!context.mounted) return;
        String? message;
        if (e is ResponseException) {
          message = e.error;
        } else {
          message = 'An error occurred during registration';
        }
        _logger.d(stackTrace);
        _logger.e('An error occurred during registration: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Owner',
                  style: TextStyle(
                    color: Color(0xFF006A60),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Karenderya Details',
                  style: TextStyle(
                    color: Color(0xFF006A60),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: _karenderyaNameController,
                  label: 'Karenderya Name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _karenderyaBarangayController,
                  label: 'Barangay',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: _karenderyaCityController,
                  label: 'City',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: _karenderyaProvinceController,
                  label: 'Province',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: _karenderyaStreetController,
                  label: 'Street',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _karenderyaDateFoundedController,
                  label: 'Date Founded',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _karenderyaDescriptionController,
                  label: 'Description',
                  icon: Icons.key_outlined,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _karenderyaSignup(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA62B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
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
        return null;
      },
    );
  }
}
