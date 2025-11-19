import 'package:flutter/material.dart';
import 'package:grocery_app/common/widgets/appbar/appbar.dart';
import 'package:grocery_app/common/widgets/icons/circular_icon.dart';
import 'package:grocery_app/common/widgets/layout/grid_layout.dart';
import 'package:grocery_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:grocery_app/navigation_menu.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          UCircularIcon(
            icon: Iconsax.add,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: UGridLayout(
            itemCount: 10,
            itemBuilder: (context, index) => UProductCardVertical(product: null)
          ),
        ),
      ),
    );
  }
}
