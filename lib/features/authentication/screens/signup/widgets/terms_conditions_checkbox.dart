import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class UTermsAndConditionCheckbox extends StatelessWidget {
  const UTermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = UHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value,
            ))),
        const SizedBox(
          width: USizes.spaceBtwItems,
        ),
        Expanded(
          child: Text.rich(TextSpan(children: [
            TextSpan(text: '${UTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: UTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: dark ? UColors.white : UColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? UColors.white : UColors.primary)),
            TextSpan(text: ' ${UTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: UTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? UColors.white : UColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? UColors.white : UColors.primary))
          ])),
        )
      ],
    );
  }
}