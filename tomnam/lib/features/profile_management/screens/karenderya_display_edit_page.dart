import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/behavior_score.dart';
import 'package:tomnam/commons/widgets/profile_settings_profile.dart';
import 'package:tomnam/commons/widgets/upper_navbar.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/models/user.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch route arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _karenderya = arguments['karenderya'] as Karenderya;
      _logger.d('Received store data: $_karenderya');
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
                  bottom: -43.5, // Adjust to overlap by half the profile size
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

                      // Review Karenderya Stars
                      Positioned(
                          right: 18,
                          top: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _karenderya.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                  width: 5), // Space between stars and text
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
                  padding: EdgeInsets.symmetric(horizontal: 21),
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
                      Text(
                        '${_karenderya.locationStreet}, ${_karenderya.locationBarangay}, ${_karenderya.locationCity}, ${_karenderya.locationProvince}',
                        style: const TextStyle(
                          color: Color(0xFF9796A1),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // About Section
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
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
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
