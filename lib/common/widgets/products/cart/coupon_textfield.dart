import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/rounded_container.dart';

class UCouponCode extends StatelessWidget {
  const UCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return URoundedContainer(
      showBorder: true,
      backgroundColor: dark ? UColors.dark : UColors.light,
      padding: const EdgeInsets.only(left: USizes.md, top: USizes.sm, right: USizes.sm, bottom: USizes.sm),
      child: Row(
        children: [
          /// TextField
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Have a promo code? Enter Here',
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  border: InputBorder.none
              ),
            ),
          ),

          /// Apply Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: dark ? UColors.white.withOpacity(0.5) : UColors.dark.withOpacity(0.5),
                  backgroundColor: UColors.grey.withOpacity(0.2),
                  side: BorderSide(color: UColors.grey.withOpacity(0.1))
              ),
              onPressed: (){},
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}