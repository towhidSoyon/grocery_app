import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../screens/forgot_password/reset_password.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async{
    try{

      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing your request...', UImages.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        UFullScreenLoader.stopLoading();
        return ;
      }

      // FormValidation
      if(!forgetPasswordFormKey.currentState!.validate()){
        UFullScreenLoader.stopLoading();
        return ;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      UFullScreenLoader.stopLoading();

      // Show Success Message
      UHelperFunctions.successSnackBar(title: 'Email Sent',message: 'Email Link Sent to Reset your Password'.tr);

      // Redirect
      Get.to(()=> ResetPassword(email: email.text.trim(),));
    }catch(e){
      // Remove Loader
      UFullScreenLoader.stopLoading();
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async{
    try{

      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing your request...', UImages.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        UFullScreenLoader.stopLoading();
        return ;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      UFullScreenLoader.stopLoading();

      // Show Success Message
      UHelperFunctions.successSnackBar(title: 'Email Sent',message: 'Email Link Sent to Reset your Password'.tr);

    }catch(e){
      // Remove Loader
      UFullScreenLoader.stopLoading();
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}