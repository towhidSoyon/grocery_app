import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/button/elevated_button.dart';
import 'package:grocery_app/features/authentication/controllers/forgot_password/forgot_password_controller.dart';
import 'package:grocery_app/features/authentication/screens/login/login_screen.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:grocery_app/utils/constants/texts.dart';
import 'package:grocery_app/utils/helpers/device_helpers.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final controller = ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              Image.asset(
                UImages.mailSentImage,
                height: UDeviceHelper.getScreenWidth(context) * 0.6,
              ),
              SizedBox(height: USizes.spaceBtwItems),
              Text(
                UTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),
              Text(
                UTexts.resetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: USizes.spaceBtwSections),

              UElevatedButton(onPressed: () => Get.offAll(() => LoginScreen()), child: Text(UTexts.done)),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: controller.resendPasswordResetEmail(email),
                  child: Text(UTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
