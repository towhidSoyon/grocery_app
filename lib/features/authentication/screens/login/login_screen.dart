import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/button/elevated_button.dart';
import 'package:grocery_app/features/authentication/screens/forgot_password/forgot_password.dart';
import 'package:grocery_app/features/authentication/screens/signup/sign_up.dart';
import 'package:grocery_app/navigation_menu.dart';
import 'package:grocery_app/utils/constants/colors.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:grocery_app/utils/constants/texts.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: USizes.sm),
                  Text(
                    UTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: USizes.spaceBtwSections),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: UTexts.email,
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
                  SizedBox(height: USizes.spaceBtwInputFields / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text(UTexts.rememberMe),
                        ],
                      ),
                      TextButton(
                        onPressed: () => Get.to( () => ForgotPassword( )),
                        child: Text(UTexts.forgetPassword),
                      ),
                    ],
                  ),
                  SizedBox(height: USizes.spaceBtwSections),

                  UElevatedButton(onPressed: () => Get.to(() => NavigationMenu()), child: Text(UTexts.signIn)),
                  SizedBox(height: USizes.spaceBtwItems / 2),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Get.to(() => SignUp()),
                      child: Text(UTexts.createAccount),
                    ),
                  ),
                ],
              ),
              SizedBox(height: USizes.spaceBtwSections),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Divider(indent: 60, endIndent: 5, thickness: 0.5, color: dark? UColors.darkerGrey : UColors.grey),
                  ),
                  Text(
                    UTexts.orSignInWith,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Expanded(
                    child: Divider(indent: 5, endIndent: 60, thickness: 0.5, color: dark? UColors.darkerGrey : UColors.grey),
                  ),
                ],
              ),

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
        ),
      ),
    );
  }
}
