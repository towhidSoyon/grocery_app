import 'package:flutter/material.dart';
import 'package:grocery_app/common/widgets/images/circular_image.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import '../../../utils/constants/sizes.dart';

class UVerticalImageText extends StatelessWidget {
  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const UVerticalImageText({
    super.key,
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          UCircularImage(
            height: 56,
            width: 56,
            image: image,
            isNetworkImage: true,
          ),
          SizedBox(height: USizes.spaceBtwItems / 2),
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                color: textColor,
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
