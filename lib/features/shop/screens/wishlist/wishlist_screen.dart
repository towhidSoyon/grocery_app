import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery_app/common/widgets/appbar/appbar.dart';
import 'package:grocery_app/common/widgets/icons/circular_icon.dart';
import 'package:grocery_app/common/widgets/layout/grid_layout.dart';
import 'package:grocery_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:grocery_app/navigation_menu.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/product/favourite_controller.dart';
import '../home/home_screen.dart';

/*class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
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
            itemBuilder: (context, index) => UProductCardVertical(product: products[index])
          ),
        ),
      ),
    );
  }
}*/

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Scaffold(
      appBar: UAppBar(
        title: Text('WishList', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          UCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(() => const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),

          /// Product Grid
          child: Obx(
                () => FutureBuilder(
                future: controller.favouriteProducts(),
                builder: (context, snapshot) {
                  /// Nothing found widget
                  final emptyWidget = UAnimationLoader(
                    text: 'Whoops! Wishlist is Empty...',
                    animation: UImages.pencilAnimation,
                    showAction: true,
                    actionText: "Let's add some",
                    onActionPressed: () => Get.off(() => const NavigationMenu()),
                  );

                  /// Loading Widget
                  const loader = UVerticalProductShimmer(
                    itemCount: 6,
                  );

                  final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                  if (widget != null) return widget;

                  final products = snapshot.data!;
                  return UGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return UProductCardVertical(
                        product: products[index],
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}
