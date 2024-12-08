import 'package:flutter/material.dart';
import 'package:tomnam/utils/constants/routes.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import 'package:tomnam/models/karenderya.dart';

class KarenderyaDisplay extends StatelessWidget {
  final Karenderya? karenderya;
  const KarenderyaDisplay(this.karenderya, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          editKarenderyaDisplayRoute,
          arguments: {
            'karenderya': karenderya,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // Use Column to allow multiple children
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KARENDERYA DISPLAY',
                      style: TextStyle(fontSize: 18.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.storefront,
                            color: AppColors.blackColor),
                        const SizedBox(width: 5), // Add spacing between widgets
                        Text(
                          karenderya!.name,
                          style: const TextStyle(fontSize: 16.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_right,
                    size: 50, color: Colors.grey)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
