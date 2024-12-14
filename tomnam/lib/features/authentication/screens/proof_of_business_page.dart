import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/Exceptions/response_exception.dart';
import 'package:tomnam/features/controllers/proof_of_business.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/utils/constants/routes.dart';

class ProofOfBusinessPage extends StatefulWidget {
  const ProofOfBusinessPage({super.key});

  @override
  State<ProofOfBusinessPage> createState() => _ProofOfBusinessPageState();
}

class _ProofOfBusinessPageState extends State<ProofOfBusinessPage> {
  final _logger = Logger(printer: PrettyPrinter());
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final List<File?> _images = List<File?>.filled(4, null, growable: false);
  late Karenderya _karenderya;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _karenderya = arguments['Karenderya'] as Karenderya;
    }
  }

  void _handleCreateProofOfBusines() async {
    try {
      await ProofOfBusinessController.create(
          _karenderya, _images[0]!, _images[1]!, _images[2]!, _images[3]!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Proof of business created")),
      );

      Navigator.of(context).popAndPushNamed(loginRoute);
    } catch (e, stackTrace) {
      if (!context.mounted) return;
      String? message;
      if (e is ResponseException) {
        message = e.error;
      } else {
        message = 'An error occurred during proof of business creation';
      }
      _logger.d(stackTrace);
      _logger.e('An error occurred during  proof of business creation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> _pickImage(int index) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Save picked image
        _images[index] = _image!; // Replace image in list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            // key: _formKey,
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
                  'Proof of Business',
                  style: TextStyle(
                    color: Color(0xFF006A60),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(0),
                        label: const Text('Karenderya Owner Valid ID 1'),
                        icon: const Icon(Icons.add_a_photo),
                        style: const ButtonStyle(
                            padding:
                                WidgetStatePropertyAll(EdgeInsets.all(12))),
                        iconAlignment: IconAlignment.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(1),
                        label: const Text('Karenderya Owner Valid ID 2'),
                        icon: const Icon(Icons.add_a_photo),
                        style: const ButtonStyle(
                            padding:
                                WidgetStatePropertyAll(EdgeInsets.all(12))),
                        iconAlignment: IconAlignment.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(2),
                        label: const Text('Mayor\'\s or Business Permit'),
                        icon: const Icon(Icons.add_a_photo),
                        style: const ButtonStyle(
                            padding:
                                WidgetStatePropertyAll(EdgeInsets.all(12))),
                        iconAlignment: IconAlignment.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton.icon(
                        onPressed: () => _pickImage(3),
                        label: const Text('BIR Registration'),
                        icon: const Icon(Icons.add_a_photo),
                        style: const ButtonStyle(
                            padding:
                                WidgetStatePropertyAll(EdgeInsets.all(12))),
                        iconAlignment: IconAlignment.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleCreateProofOfBusines,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA62B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'SUBMIT',
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
    // required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      // controller: controller,
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
