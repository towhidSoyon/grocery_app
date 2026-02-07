import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/favourite_controller.dart';
import '../../icons/circular_icon.dart';

class UFavouriteIcon extends StatelessWidget {
  const UFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {

    final controller = FavouriteController.instance;
    return Obx(
          () => UCircularIcon(
          icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
          color: controller.isFavourite(productId) ? Colors.red : null,
          onPressed: () => controller.toggleFavouriteProduct(productId)),
    );
  }
}