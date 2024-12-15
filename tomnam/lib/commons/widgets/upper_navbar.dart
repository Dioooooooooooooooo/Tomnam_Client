import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tomnam/provider/cart_item_provider.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class UpperNavBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isOwner;
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  const UpperNavBar(this.isOwner, {super.key});

  @override
  Widget build(BuildContext context) {
    final cartItemProvider =
        Provider.of<CartItemProvider>(context, listen: false);

    return AppBar(
      backgroundColor: AppColors.mainGreenColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, searchPageRoute),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
          Center(
            child: badges.Badge(
              badgeContent: Text(
                cartItemProvider.cartItems.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: AppColors.accentRedOrangeColor,
              ),
              badgeAnimation: const badges.BadgeAnimation.slide(
                animationDuration: Duration(milliseconds: 300),
              ),
              position: badges.BadgePosition.topEnd(top: -5, end: -5),
              child: !isOwner
                  ? IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, addToCartRoute),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.qr_code_scanner_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, scanQrCodePageRoute),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
