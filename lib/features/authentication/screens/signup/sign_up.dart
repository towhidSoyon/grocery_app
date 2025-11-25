import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/button/elevated_button.dart';
import 'package:grocery_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:grocery_app/features/authentication/screens/forgot_password/verify_email.dart';
import 'package:grocery_app/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:grocery_app/utils/constants/colors.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(UTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: USizes.spaceBtwSections,),

              /// Form
              const USignUpForm(),

              /// Divider
              UFormDivider(dividerText: UTexts.orSignupWith.capitalize!),
              const SizedBox(height: USizes.spaceBtwSections,),

              /// Social Buttons
              const USocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
