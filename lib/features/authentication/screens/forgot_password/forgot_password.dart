import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/button/elevated_button.dart';
import 'package:grocery_app/features/authentication/screens/forgot_password/reset_password.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import 'package:grocery_app/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/texts.dart';
import '../../controllers/forgot_password/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
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
                UTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems / 2),
              Text(
                UTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: USizes.spaceBtwSections*2),

              Column(
                children: [
                  Form(
                    key: controller.forgetPasswordFormKey,
                    child: TextFormField(
                      controller: controller.email,
                      validator: (value) => UValidator.validateEmail(value),
                      decoration: InputDecoration(
                        labelText: UTexts.email,
                        prefixIcon: Icon(Iconsax.direct_right)
                      ),
                    ),
                  ),
                  SizedBox(height: USizes.spaceBtwItems),
                  
                  UElevatedButton(onPressed: controller.sendPasswordResetEmail, child: Text(UTexts.submit ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
