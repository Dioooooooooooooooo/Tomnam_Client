import 'package:flutter/material.dart';
import '../../../utils/constants/tomnam_pallete.dart';

class ProfileSettingsProfile extends StatelessWidget {
  final String firstName;
  const ProfileSettingsProfile(this.firstName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(5),
              child: const Icon(
                Icons.person_4,
                size: 36,
                color: AppColors.blackColor,
              )),
          const SizedBox(width: 10),
          Text(
            'HI, $firstName!',
            style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 30.0,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
