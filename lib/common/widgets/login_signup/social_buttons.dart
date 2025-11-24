import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/sizes.dart';

class USocialButtons extends StatelessWidget {
  const USocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: UColors.grey,),
              borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
                width: USizes.iconMd,
                height: USizes.iconMd,
                image: AssetImage(UImages.googleIcon)),
          ),
        ),
        const SizedBox(width: USizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: UColors.grey),
              borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(
            onPressed: (){},
            icon: const Image(
                width: USizes.iconMd,
                height: USizes.iconMd,
                image: AssetImage(UImages.facebookIcon)),
          ),
        )
      ],
    );
  }
}
