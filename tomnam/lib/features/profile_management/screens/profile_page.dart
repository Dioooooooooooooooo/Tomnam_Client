import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/karenderya_display_widget.dart';
import 'package:tomnam/commons/widgets/profile_settings_profile.dart';
import 'package:tomnam/features/controllers/auth_controller.dart';
import 'package:tomnam/features/controllers/profile_controller.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/models/user.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

import '../../../commons/widgets/behavior_score.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );
  bool _isLoading = true;
  User? _user;
  Karenderya? karenderya;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final user = await ProfileController.getUser();
      _logger.d('Fetched user: $user');
      setState(() {
        _user = user;
      });
      _isLoading = false;
    } catch (e) {
      _logger.e('Error fetching user: $e');
    }
  }

  Future<void> _handleLogOut() async {
    await AuthController.logout();

    Navigator.of(context).pushNamedAndRemoveUntil(
      welcomeRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loader while fetching
            : ListView(
                children: [
                  // Profile Section
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      gradient: AppColors.gradientGreenColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileSettingsProfile(_user!.firstName),
                        const SizedBox(height: 10),
                        _user!.role == 'Customer'
                            ? BehaviorScore(_user!.behaviorScore
                                .toString()) // Customer Profile
                            : const KarenderyaDisplay(""), // Owner
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildSettingsButton(
                          icon: Icons.location_on, label: "Your Address"),
                      _buildSettingsButton(
                          icon: Icons.person, label: "Account & Security"),
                      _buildSettingsButton(
                          icon: Icons.wallet,
                          label: _user!.role == 'Owner'
                              ? "Shop Wallet"
                              : 'Bank Account / Cards'),
                      _buildSettingsButton(
                          icon: Icons.settings, label: "Notification Settings"),
                      _buildSettingsButton(
                          icon: Icons.mail, label: "Contact Us"),
                      _buildSettingsButton(
                          icon: Icons.help, label: "Helps & FAQs"),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 10,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF015B55),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                        onPressed: () {
                          _handleLogOut();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.power_settings_new,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'LOG OUT',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSettingsButton({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
      decoration: const BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(
                  color: AppColors.accentGreenColor,
                  width: 0.5,
                  style: BorderStyle.solid))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.mainGreenColor),
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
