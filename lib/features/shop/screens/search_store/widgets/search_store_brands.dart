import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:grocery_app/features/shop/controllers/product/brand_controller.dart';
import 'package:grocery_app/features/shop/models/brand_model.dart';
import 'package:grocery_app/features/shop/screens/brand/all_brands.dart';
import 'package:grocery_app/features/shop/screens/brand/brand_products.dart';
import 'package:grocery_app/utils/helpers/cloud_helper_functions.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../../utils/constants/sizes.dart';

class SearchStoreBrands extends StatelessWidget {
  const SearchStoreBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    bool dark = UHelperFunctions.isDarkMode(context);
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.allBrands.isEmpty) return Text("No Brands Found!");

      List<BrandModel> brands = controller.allBrands.take(10).toList();
      return Column(
        children: [
          USectionHeading(title: "Brands", onPressed: ()=> Get.to(() => AllBrandsScreen()),),

          SizedBox(height: USizes.spaceBtwItems),

          Wrap(
            spacing: USizes.spaceBtwItems,
            runSpacing: USizes.spaceBtwItems,
            children: brands
                .map(
                  (brand) => UVerticalImageText(
                    onTap: () => Get.to(() => BrandProducts(brand: brand)),
                    title: brand.name,
                    image: brand.image,
                    textColor: dark ? UColors.white : UColors.black,
                  ),
                )
                .toList(),
          ),
        ],
      );
    });
  }
}
