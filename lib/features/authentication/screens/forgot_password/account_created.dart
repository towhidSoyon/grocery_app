import 'package:flutter/material.dart';

import '../../../../common/style/padding.dart';
import '../../../../common/widgets/button/elevated_button.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/device_helpers.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              Image.asset(
                UImages.accountCreatedImage,
                height: UDeviceHelper.getScreenWidth(context) * 0.6,
              ),
              SizedBox(height: USizes.spaceBtwItems),
              Text(
                UTexts.accountCreatedTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),
              Text(
                UTexts.accountCreatedSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwSections),

              UElevatedButton(onPressed: () {}, child: Text(UTexts.uContinue)),
            ],
          ),
        ),
      ),
    );
  }
}
