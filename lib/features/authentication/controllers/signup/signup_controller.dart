import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/user/user_repository.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../models/user_model.dart';
import '../../screens/forgot_password/verify_email.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // observing for hiding/showing password
  final privacyPolicy = true.obs; // observing for hiding/showing privacyPolicy checkbox
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  Future<void> signup() async{
    try{
      // Start Loading
      UFullScreenLoader.openLoadingDialog('We are processing your information...', UImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        UFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!signupFormKey.currentState!.validate()){
        UFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if(!privacyPolicy.value){
        UFullScreenLoader.stopLoading();
        UHelperFunctions.warningSnackBar(
            title: 'Accept privacy Policy',
            message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.'
        );
        return;
      }

      // Register user in the Firebase Authentication & Save user data in Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase FireStore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: ''
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show Success Message
      UHelperFunctions.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue');

      // Stop Loading
      UFullScreenLoader.stopLoading();

      // Move to Verify Email Screen
      Get.to(()=> VerifyEmailScreen(email: email.text.trim(),));
    }catch(e){
      // Stop Loading
      UFullScreenLoader.stopLoading();

      // Show some Generic error to user
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }
}