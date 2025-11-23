import 'package:flutter/material.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enum.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../button/add_to_cart_button.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../favourite/favourite_icon.dart';

class UProductCardHorizontal extends StatelessWidget {
  const UProductCardHorizontal({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = UHelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark ? UColors.darkerGrey : UColors.light),
      child: Row(
        children: [
          /// Thumbnail Discount Tag & Fav Icon
          URoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(USizes.sm),
            backgroundColor: dark ? UColors.dark : UColors.light,
            child: Stack(
              children: [
                /// Thumbnail Image
                SizedBox(
                    width: 120,
                    height: 120,
                    child: URoundedImage(imageUrl: product.thumbnail,applyImageRadius: true,isNetworkImage: true,)
                ),

                /// Sale Tag
                if(salePercentage != null)
                  Positioned(
                    top: 12,
                    child: URoundedContainer(
                      radius: USizes.sm,
                      backgroundColor: UColors.primary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(horizontal: USizes.sm, vertical: USizes.xs),
                      child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: UColors.black),),
                    ),
                  ),

                /// Favourite Icon Button
                Positioned(
                    right: 0,
                    top: 0,
                    child: UFavouriteIcon(productId: product.id)
                )
              ],
            ),
          ),

          ///  Details, Add to cart & Pricing
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: USizes.sm,left: USizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UProductTitleText(title: product.title,smallSize: true),
                  const SizedBox(height: USizes.spaceBtwItems / 2,),
                  UBrandTitleWithVerifyIcon(title: product.brand!.name),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// Price
                      Flexible(
                        child: Column(
                          children: [
                            /// if There is Sale then show sale actual price with line-through
                            if(product.productType == ProductType.single.toString() && product.salePrice > 0.0)
                              Padding(
                                padding: const EdgeInsets.only(left: USizes.sm),
                                child: Text(
                                  product.price.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium!.apply(decoration: TextDecoration.lineThrough),
                                ),
                              ),

                            /// Price, show sale price as main price if sale exist
                            Padding(
                              padding: const EdgeInsets.only(left: USizes.sm),
                              child: UProductPriceText(price: controller.getProductPrice(product)),
                            ),
                          ],
                        ),
                      ),

                      /// Add to Cart
                      ProductAddToCartButton(product: product)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}