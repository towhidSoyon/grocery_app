import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/features/shop/controllers/home/home_controller.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';
import 'banners_dot_navigation.dart';

class UPromoSlider extends StatelessWidget {
  final List<String> images;
  const UPromoSlider({
    super.key, required this.images,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Column(
      children: [
        CarouselSlider(
          items: images.map((banner) => URoundedImage(imageUrl: banner)).toList(),
          options: CarouselOptions(viewportFraction: 1.0, onPageChanged: (index, reason) => controller.onPageChanged(index)),
          carouselController: controller.carouselController,
        ),

        SizedBox(height: USizes.spaceBtwItems),

        BannerDotNavigation(),
      ],
    );
  }
}