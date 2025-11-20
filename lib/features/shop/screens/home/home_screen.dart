import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/widgets/layout/grid_layout.dart';
import 'package:grocery_app/features/shop/controllers/home/home_controller.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:grocery_app/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:grocery_app/utils/constants/texts.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/text_fields/search_bar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final dark = UHelperFunctions.isDarkMode(context);
    //final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(height: USizes.homePrimaryHeaderHeight + 10),

                UPrimaryHeaderContainer(
                  height: USizes.homePrimaryHeaderHeight,
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
              child: Column(
                children: [
                  UPromoSlider(
                    images: [
                      UImages.accountCreatedImage,
                      UImages.accountCreatedImage,
                      UImages.accountCreatedImage,
                      UImages.accountCreatedImage,
                      UImages.accountCreatedImage,
                    ],
                  ),

                  SizedBox(height: USizes.spaceBtwSections),

                  USectionHeading(
                    title: UTexts.popularCategories,
                    onPressed: () {},
                  ),

                  SizedBox(height: USizes.spaceBtwSections),

                  UGridLayout(itemCount: 6, itemBuilder: (context, index){
                    return UProductCardVertical(product: controller.featuredProducts[index]);
                  })

                  //UProductCardVertical()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
