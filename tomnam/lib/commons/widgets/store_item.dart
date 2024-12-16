import 'package:flutter/material.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/models/karenderya.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class StoreItem extends StatelessWidget {
  final Karenderya store;

  const StoreItem(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          storeRoute,
          arguments: {
            'store': store,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${ApiService.baseURL}/${store.coverPhoto}',
                height: 140,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Incase the image fails to load or null or whatever, show a placeholder image
                  return Image.asset(
                    'assets/images/cover-photo.png',
                    height: 140,
                    width: 150,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3, // Limits the text to two lines
                    overflow:
                        TextOverflow.ellipsis, // Adds "..." if text is too long
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: AppColors.mainOrangeColor, size: 18),
                      Text(
                        "${store.rating}", // Show the reviews
                        style: const TextStyle(color: AppColors.blackColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
