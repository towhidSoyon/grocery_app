import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class USearchContainer extends StatelessWidget {
  const USearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: USizes.defaultSpace)
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
            width: UHelperFunctions.screenWidth(),
            padding: const EdgeInsets.all(USizes.md),
            decoration: BoxDecoration(
                color: showBackground ? dark ? UColors.dark : UColors.light : Colors.transparent ,
                borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
                border: showBorder ? Border.all(color: UColors.grey) : null
            ),
            child: Row(
              children: [
                Icon(icon,color: UColors.darkerGrey,),
                const SizedBox(width: USizes.spaceBtwItems,),
                Text(text, style: Theme.of(context).textTheme.bodySmall,)

              ],
            )
        ),
      ),
    );
  }
}