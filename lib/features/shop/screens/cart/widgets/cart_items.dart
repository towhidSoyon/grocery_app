import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
          () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(
          height: USizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final cartItem = controller.cartItems[index];
            return Column(
              children: [
                UCartItem(
                  cartItem: cartItem,
                ),
                if (showAddRemoveButtons) ...[
                  const SizedBox(
                    height: USizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /// extra Space
                          const SizedBox(
                            width: 70,
                          ),

                          /// Add & Remove Button
                          UProductQuantityWithAddRemoveButton(
                            quantity: cartItem.quantity,
                            add: () => controller.addOneToCart(cartItem),
                            remove: () => controller.removeOneFromCart(cartItem),
                          ),
                        ],
                      ),
                      UProductPriceText(price: (cartItem.price * cartItem.quantity).toStringAsFixed(0))
                    ],
                  )
                ]

                /// Add & Remove Buttons
              ],
            );
          });
        },
      ),
    );
  }
}