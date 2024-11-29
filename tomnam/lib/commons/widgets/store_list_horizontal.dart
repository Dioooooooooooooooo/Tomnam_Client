import 'package:flutter/material.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/models/karenderya.dart';
import '../../../utils/constants/tomnam_pallete.dart';
import '../../../utils/constants/routes.dart';

class StoreListHorizontal extends StatelessWidget {
  final List<Karenderya> stores;

  const StoreListHorizontal(
    this.stores,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  storeRoute,
                  arguments: {
                    'store': stores[index],
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        '${ApiService.baseURL}/${stores[index].coverPhoto}',
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
                    const SizedBox(height: 10),
                    Text(
                      stores[index].name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: AppColors.mainOrangeColor, size: 18),
                        Text(
                          "${stores[index].rating}", // Show the reviews
                          style: const TextStyle(color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
