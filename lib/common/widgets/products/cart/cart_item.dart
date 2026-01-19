import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_with_verify_icon.dart';
import '../../texts/product_title_text.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({
    super.key, required this.cartItem,
  });

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// Image
        URoundedImage(
          imageUrl: cartItem.image ?? '',
          height: 60,
          width: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        ),
        const SizedBox(width: USizes.spaceBtwItems,),

        /// Title, Price & Size
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UBrandTitleWithVerifyIcon(title: cartItem.brandName ?? ''),
              UProductTitleText(title: cartItem.title , maxLines: 1,),

              /// Attributes
              Text.rich(
                  TextSpan(
                      children: (cartItem.selectedVariation ?? {}).entries.map((e) => TextSpan(
                          children: [
                            TextSpan(text: ' ${e.key} ', style: Theme.of(context).textTheme.bodySmall,),
                            TextSpan(text: '${e.value} ', style: Theme.of(context).textTheme.bodyLarge,),
                          ]
                      ),).toList()
                  )
              )


            ],
          ),
        )
      ],
    );
  }
}