import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/behavior_score.dart';
import 'package:tomnam/commons/widgets/profile_settings_profile.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/models/user.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class BehaviorScorePage extends StatefulWidget {
  const BehaviorScorePage({super.key});

  @override
  State<BehaviorScorePage> createState() => _BehaviorScorePageState();
}

class _BehaviorScorePageState extends State<BehaviorScorePage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  late User _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _user = arguments['user'] as User;
      _logger.d('Received store data: $_user');
    } else {
      _logger.e('No user data found in arguments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const UpperNavBar(),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Profile Section
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.9,
              ),
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
                  ProfileSettingsProfile(_user.firstName),
                  const SizedBox(height: 10),
                  BehaviorScore(_user, true),
                  const SizedBox(height: 2),
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            'Thank you for maintaining great behaviour!\nHere are your available vouchers.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildVoucherItem(
                            freeItem: 'RICE',
                            text: 'Free Rice at Any Karenderya',
                            score: 100),
                        _buildVoucherItem(
                            freeItem: 'sabaw',
                            text: 'Free Sabaw at Any Karenderya',
                            score: 100),
                        _buildVoucherItem(
                            freeItem: 'fruit',
                            text: 'Free Any Fruit at Selected Karenderyas',
                            score: 150),
                        _buildVoucherItem(
                            freeItem: 'snack',
                            text: 'Free Any Snack at Selected Karenderyas',
                            score: 150)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherItem({required freeItem, required text, required score}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF9F3),
        boxShadow: [
          BoxShadow(
            color: Color(0x33F6A747),
            blurRadius: 5,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFF6A747),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33F6A747),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'FREE\n$freeItem'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Requires $score Behaviour Score',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.mainOrangeColor),
                  child: const Text(
                    'Avail',
                    style: TextStyle(color: AppColors.whiteColor),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
