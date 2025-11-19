import 'package:flutter/material.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../../utils/constants/sizes.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  const UProductThumbnailAndSlider({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    return Container(
      color: dark ? UColors.darkerGrey : UColors.light,
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(
                child: Image(
                  image: AssetImage(UImages.accountCreatedImage),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            right: 0,
            left: USizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                shrinkWrap: true,
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => URoundedImage(
                  width: 80,
                  backgroundColor: dark
                      ? UColors.darkGrey
                      : UColors.white,
                  padding: EdgeInsets.all(USizes.sm),
                  border: Border.all(color: UColors.primary),
                  imageUrl: UImages.accountCreatedImage,
                ),
              ),
            ),
          ),

          UAppBar(
            showBackArrow: true,
            actions: [
              UCircularIcon(icon: Iconsax.heart5, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}