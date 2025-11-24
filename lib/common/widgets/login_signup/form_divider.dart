import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class UFormDivider extends StatelessWidget {
  final String dividerText;

  const UFormDivider({
    super.key,
    required this.dividerText
  });


  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        Expanded(child: Divider(thickness: 0.5,color: dark ? UColors.darkGrey : UColors.grey,indent: 60,endIndent: 5,)),
        Text(dividerText, style: Theme.of(context).textTheme.labelMedium,),
        Expanded(child: Divider(thickness: 0.5,color: dark ? UColors.darkGrey : UColors.grey,indent: 5,endIndent: 60,))
      ],
    );
  }
}