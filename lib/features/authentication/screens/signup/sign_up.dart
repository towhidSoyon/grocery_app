import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/button/elevated_button.dart';
import 'package:grocery_app/features/authentication/screens/forgot_password/verify_email.dart';
import 'package:grocery_app/utils/constants/colors.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                UTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: USizes.spaceBtwSections),

              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: UTexts.firstName,
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ),
                      SizedBox(width: USizes.spaceBtwInputFields),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: UTexts.lastName,
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: USizes.spaceBtwInputFields),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: UTexts.email,
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwInputFields),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.call),
                      labelText: UTexts.phoneNumber,
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwInputFields),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: UTexts.password,
                      suffixIcon: Icon(Iconsax.eye),
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwInputFields / 2 ),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(text: '${UTexts.iAgreeTo} '),
                            TextSpan(
                              text: UTexts.privacyPolicy,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: UColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                            TextSpan(text: ' ${UTexts.and} '),
                            TextSpan(
                              text: '${UTexts.termsOfUse} ',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: UColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: USizes.spaceBtwItems),

                  UElevatedButton(onPressed: () => Get.to(() => VerifyEmailScreen()), child: Text(UTexts.createAccount)),
                  SizedBox(height: USizes.spaceBtwSections),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Divider(indent: 60, endIndent: 5, thickness: 0.5, color: dark? UColors.darkerGrey : UColors.grey),
                      ),
                      Text(
                        UTexts.orSignupWith,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Expanded(
                        child: Divider(indent: 5, endIndent: 60, thickness: 0.5, color: dark? UColors.darkerGrey : UColors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: USizes.spaceBtwSections),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: UColors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            UImages.googleIcon,
                            height: USizes.iconMd,
                            width: USizes.iconMd,
                          ),
                        ),
                      ),
                      SizedBox(width: USizes.spaceBtwItems),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: UColors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            UImages.facebookIcon,
                            height: USizes.iconMd,
                            width: USizes.iconMd,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
