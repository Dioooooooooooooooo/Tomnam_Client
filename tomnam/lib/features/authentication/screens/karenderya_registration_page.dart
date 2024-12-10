import 'package:flutter/material.dart';
import 'package:tomnam/utils/constants/routes.dart';
import '../../../commons/widgets/register_inputfield_widget.dart';

class KarenderyaRegistrationPage extends StatefulWidget {
  const KarenderyaRegistrationPage({super.key});

  @override
  State<KarenderyaRegistrationPage> createState() =>
      _KarenderyaRegistrationPageState();
}

class _KarenderyaRegistrationPageState
    extends State<KarenderyaRegistrationPage> {
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
                  'Karenderya Details',
                  style: TextStyle(
                    color: Color(0xFF006A60),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  // controller: _firstNameController,
                  label: 'Karenderya Name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  // controller: _lastNameController,
                  label: 'Location',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  // controller: _emailController,
                  label: 'Date Founded',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  // controller: _passwordController,
                  label: 'Description',
                  icon: Icons.key_outlined,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    // onPressed: Navigator.of(context).popAndPushNamed(proofOfBusinessRoute);
                    onPressed: null,
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
