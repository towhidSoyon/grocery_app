import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery_app/features/authentication/screens/forgot_password/account_created.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/helper_functions.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();


  /// Send Email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }


  /// Send Email Verification Link
  sendEmailVerification() async{
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      UHelperFunctions.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    }catch(e){
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }
  }
  /// Timer to automatically redirect on Email verification
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), (timer) async{
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(() => AccountCreatedScreen(
            image: UImages.successfulPaymentIcon,
            title: UTexts.accountCreatedTitle,
            subtitle: UTexts.accountCreatedSubTitle,
            onTap: () => AuthenticationRepository.instance.screenRedirect()
        ));
      }
    });
  }


  /// Manually Check if email Verified
  checkEmailVerificationStatus() async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(() => AccountCreatedScreen(
          image: UImages.successfulPaymentIcon,
          title: UTexts.accountCreatedTitle,
          subtitle: UTexts.accountCreatedSubTitle,
          onTap: () => AuthenticationRepository.instance.screenRedirect(),
      ));
    }
  }
}
