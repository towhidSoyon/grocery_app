import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:grocery_app/features/shop/controllers/product/cart_controller.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class UCartCounterIcon extends StatelessWidget {
  const UCartCounterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Iconsax.shopping_bag),
          color: UColors.dark,
        ),

        Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            color: dark ? UColors.dark : UColors.light,
            shape: BoxShape.circle,
          ),
          child: Positioned(
            right: 6.0,
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItem.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                    fontSizeFactor: 0.8,
                    color: dark ? UColors.light : UColors.dark,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
