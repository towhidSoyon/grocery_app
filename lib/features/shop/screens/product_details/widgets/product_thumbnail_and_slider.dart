import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/features/shop/controllers/product/images_controller.dart';
import 'package:grocery_app/features/shop/models/product_model.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  final ProductModel productModel;

  const UProductThumbnailAndSlider({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    List<String> images = controller.getAllProductImages(productModel);
    return Container(
      color: dark ? UColors.darkerGrey : UColors.light,
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(
                child: Obx(() {
                  return GestureDetector(
                    onTap: () => controller.showEnlargeImage(
                      controller.selectedProductImage.value,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: controller.selectedProductImage.value,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(
                            color: UColors.primary,
                            value: progress.progress,
                          ),
                    ),
                  );
                }),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            right: 0,
            left: USizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                shrinkWrap: true,
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Obx(() {
                  bool isImageSelected = controller.selectedProductImage.value == images[index];
                  return URoundedImage(
                    width: 80,
                    onTap: () =>
                        controller.selectedProductImage.value = images[index],
                    isNetworkImage: true,
                    backgroundColor: dark ? UColors.darkGrey : UColors.white,
                    padding: EdgeInsets.all(USizes.sm),
                    border: Border.all(color: isImageSelected? UColors.primary: Colors.transparent),
                    imageUrl: images[index],
                  );
                }),
              ),
            ),
          ),

          UAppBar(
            showBackArrow: true,
            actions: [UCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
          ),
        ],
      ),
    );
  }
}
