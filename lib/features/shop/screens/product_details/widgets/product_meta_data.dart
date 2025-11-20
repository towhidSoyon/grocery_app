import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/style/padding.dart';
import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../common/widgets/images/circular_image.dart';
import '../../../../../common/widgets/texts/brand_title_with_verify_icon.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../../utils/constants/sizes.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            URoundedContainer(
              radius: USizes.sm,
              backgroundColor: UColors.yellow.withValues(alpha: 0.8),
              padding: const EdgeInsets.symmetric(
                horizontal: USizes.sm,
                vertical: USizes.xs,
              ),
              child: Text(
                '20%',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(color: UColors.black),
              ),
            ),

            SizedBox(width: USizes.spaceBtwItems),

            Text(
              '\$250',
              style: Theme.of(context).textTheme.titleSmall!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: USizes.spaceBtwItems),

            UProductPriceText(price: '150', isLarge: true),

            Spacer(),

            IconButton(onPressed: (){}, icon: Icon(Iconsax.share))
          ],
        ),

        SizedBox(width: USizes.spaceBtwItems/ 1.5),

        UProductTitleText(title: 'Apple Iphone 11'),

        SizedBox(width: USizes.spaceBtwItems/ 1.5),

        Row(
          children: [
            UProductTitleText(title: 'Apple Iphone 11'),
            SizedBox(width: USizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium)
          ],
        ),

        SizedBox(width: USizes.spaceBtwItems/ 1.5),

        Row(
          children: [
            UCircularImage(padding: 0 ,image: UImages.accountCreatedImage, width: 32.0, height: 32.0),
            SizedBox(width: USizes.spaceBtwItems),
            UBrandTitleWithVerifyIcon(title: 'Apple')
          ],
        )
      ],
    );
  }
}