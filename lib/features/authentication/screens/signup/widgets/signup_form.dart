import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery_app/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class USignUpForm extends StatelessWidget {
  const USignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => UValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: UTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: USizes.spaceBtwInputFields,),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => UValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration:  const InputDecoration(labelText: UTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                ),
              )
            ],
          ),
          const SizedBox(height: USizes.spaceBtwInputFields,),

          /// Username
          TextFormField(
            validator: (value) => UValidator.validateEmptyText('Username', value),
            controller: controller.username,
            decoration: InputDecoration(labelText: UTexts.termsOfUse, prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: USizes.spaceBtwInputFields,),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: const InputDecoration(labelText: UTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: USizes.spaceBtwInputFields,),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => UValidator.validatePhoneNumber(value),
            decoration: InputDecoration(labelText: UTexts.phoneNumber, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: USizes.spaceBtwInputFields,),

          /// Password
          Obx(
                () => TextFormField(
              controller: controller.password,
              validator: (value) => UValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(labelText: UTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value ,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  )
              ),
            ),
          ),
          const SizedBox(height: USizes.spaceBtwSections,),

          /// Terms&Conditions Checkbox
          const UTermsAndConditionCheckbox(),
          const SizedBox(height: USizes.spaceBtwSections,),

          /// SignUp Button
          SizedBox(width:double.infinity,
              child: ElevatedButton(
                  onPressed: ()=> controller.signup(),
                  child: const Text(UTexts.createAccount))),
          const SizedBox(height: USizes.spaceBtwSections,),


        ],
      ),
    );
  }
}