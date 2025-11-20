import 'package:flutter/material.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/button/elevated_button.dart';
import 'package:grocery_app/common/widgets/images/circular_image.dart';
import 'package:grocery_app/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:grocery_app/common/widgets/texts/product_price_text.dart';
import 'package:grocery_app/common/widgets/texts/product_title_text.dart';
import 'package:grocery_app/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:grocery_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:grocery_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:grocery_app/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: UBottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProductThumbnailAndSlider(),
            Padding(
              padding: const EdgeInsets.only(
                left: USizes.defaultSpace,
                right: USizes.defaultSpace,
                bottom: USizes.defaultSpace,
              ),
              child: Column(
                children: [
                  UProductMetaData(),

                  UProductAttributes(product: product),

                  /// Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: UElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwSections),

                  /// Description
                  USectionHeading(title: 'Description'),
                  SizedBox(height: USizes.spaceBtwItems),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: ReadMoreText(
                      "product.description" ?? '',
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Less',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwItems),
                  Divider(),
                  SizedBox(height: USizes.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
