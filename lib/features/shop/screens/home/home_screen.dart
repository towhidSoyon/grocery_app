import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/features/shop/controllers/home/home_controller.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/primary_header_container.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import '../../../../common/widgets/text_fields/search_bar.dart';
import '../../../../utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(height: USizes.homePrimaryHeaderHeight + 10),

              UPrimaryHeaderContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UHomeAppBar(),
                    SizedBox(height: USizes.spaceBtwSections),
                    UHomeCategories(),
                  ],
                ),
              ),

              USearchBar(),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(USizes.defaultSpace),
            child: UPromoSlider(
              images: [
                UImages.accountCreatedImage,
                UImages.accountCreatedImage,
                UImages.accountCreatedImage,
                UImages.accountCreatedImage,
                UImages.accountCreatedImage,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
