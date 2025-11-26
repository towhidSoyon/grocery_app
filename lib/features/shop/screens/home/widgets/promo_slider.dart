import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:grocery_app/common/widgets/shimmer/shimmer_effect.dart';
import 'package:grocery_app/features/shop/controllers/banner/banner_controller.dart';
import 'package:grocery_app/features/shop/controllers/home/home_controller.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';
import 'banners_dot_navigation.dart';

class UPromoSlider extends StatelessWidget {
  const UPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final bannerController = Get.put(BannerController());
    return Obx(() {

      if(bannerController.isLoading.value){
        return UShimmerEffect(width: double.infinity, height: 190);
      }

      if(bannerController.banners.isEmpty){
        return Text('Banners not found');
      }

      return Column(
        children: [
          CarouselSlider(
            items: bannerController.banners
                .map(
                  (banner) => URoundedImage(
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                    onTap: () => Get.toNamed(banner.targetScreen),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, reason) => controller.onPageChanged(index),
            ),
            carouselController: controller.carouselController,
          ),

          SizedBox(height: USizes.spaceBtwItems),

          BannerDotNavigation(),
        ],
      );
    });
  }
}
