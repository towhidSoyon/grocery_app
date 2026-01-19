import 'package:flutter/material.dart';
import 'package:grocery_app/features/shop/controllers/product/product_controller.dart';
import 'package:grocery_app/features/shop/models/product_model.dart';
import 'package:grocery_app/utils/constants/enum.dart';
import 'package:grocery_app/utils/constants/texts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UProductMetaData extends StatelessWidget {
  final ProductModel productModel;

  const UProductMetaData({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercentage(
      productModel.price,
      productModel.salePrice,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (salePercentage != null) ...[
              URoundedContainer(
                radius: USizes.sm,
                backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: USizes.sm,
                  vertical: USizes.xs,
                ),
                child: Text(
                  "$salePercentage%",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: UColors.black),
                ),
              ),

              SizedBox(width: USizes.spaceBtwItems),
            ],

            if (productModel.productType == ProductType.single.toString() &&
                productModel.salePrice > 0) ...[
              Text(
                '${UTexts.currency}${productModel.price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: USizes.spaceBtwItems),
            ],

            UProductPriceText(
              price: controller.getProductPrice(productModel),
              isLarge: true,
            ),

            Spacer(),

            IconButton(onPressed: () {}, icon: Icon(Iconsax.share)),
          ],
        ),

        SizedBox(width: USizes.spaceBtwItems / 1.5),

        UProductTitleText(title: productModel.title),

        SizedBox(width: USizes.spaceBtwItems / 1.5),

        Row(
          children: [
            UProductTitleText(title: 'Apple Iphone 11'),
            SizedBox(width: USizes.spaceBtwItems),
            Text(controller.getProductStockStatus(productModel.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        SizedBox(width: USizes.spaceBtwItems / 1.5),

        Row(
          children: [
            UCircularImage(
              padding: 0,
              isNetworkImage: true,
              image: productModel.brand!= null ? productModel.brand!.image : '',
              width: 32.0,
              height: 32.0,
            ),
            SizedBox(width: USizes.spaceBtwItems),
            UBrandTitleWithVerifyIcon(title:  productModel.brand!= null ? productModel.brand!.name : ''),
          ],
        ),
      ],
    );
  }
}
