import 'package:flutter/material.dart';
import 'package:grocery_app/features/shop/models/brand_model.dart';

import '../../../utils/constants/enum.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/rounded_container.dart';
import '../images/rounded_image.dart';
import '../texts/brand_title_with_verify_icon.dart';

class UBrandCard extends StatelessWidget {
  final bool showBorder;
  final BrandModel brand;
  final VoidCallback onTap;

  const UBrandCard({
    super.key,
    this.showBorder = true,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return URoundedContainer(
      height: USizes.brandCardHeight,
      showBorder: showBorder,
      padding: EdgeInsets.all(USizes.sm),
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          Flexible(
            child: URoundedImage(
              imageUrl: brand.image,
              isNetworkImage: true,
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: USizes.spaceBtwItems / 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                UBrandTitleWithVerifyIcon(
                  title: brand.name,
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  '${brand.productsCount} products',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
