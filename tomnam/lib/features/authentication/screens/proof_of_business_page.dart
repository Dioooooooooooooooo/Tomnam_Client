import 'package:flutter/material.dart';

class ProofOfBusinessPage extends StatefulWidget {
  const ProofOfBusinessPage({super.key});

  @override
  State<ProofOfBusinessPage> createState() => _ProofOfBusinessPageState();
}

class _ProofOfBusinessPageState extends State<ProofOfBusinessPage> {
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
                _buildTextField(
                  // controller: _firstNameController,
                  label: 'Karenderya Owner Valid ID 1',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  // controller: _lastNameController,
                  label: 'Karenderya Owner Valid ID 2',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  // controller: _emailController,
                  label: 'Mayor\'\s or Business Permit',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  // controller: _passwordController,
                  label: 'BIR Registration',
                  icon: Icons.key_outlined,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    // onPressed: Navigator.of(context).popAndPushNamed();
                    onPressed: null,
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
