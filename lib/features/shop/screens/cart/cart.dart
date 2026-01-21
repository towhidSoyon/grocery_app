import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery_app/common/widgets/icons/circular_icon.dart';
import 'package:grocery_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/cart_controller.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          UCircularIcon(
            icon: Iconsax.box_remove,
            onPressed: () => controller.clearCart(),
          ),
        ],
      ),
      body: Obx(() {
        /// Nothing found widget
        final emptyWidget = UAnimationLoader(
          text: 'Whoops! Cart is empty',
          animation: UImages.cartEmptyAnimation,
          showAction: true,
          actionText: "Let's fill it",
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(USizes.defaultSpace),

              /// Items in Cart
              child: UCartItems(),
            ),
          );
        }
      }),

      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => CheckoutScreen()),
                child: Obx(
                  () => Text(
                    'Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}',
                  ),
                ),
              ),
            ),
    );
  }
}
