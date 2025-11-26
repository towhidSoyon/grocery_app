import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery_app/utils/constants/colors.dart';

import 'data/repositories/authentication/authentication_repository.dart';
import 'data/services/branch_services.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoadingController());
    return Scaffold(
      backgroundColor: UColors.primary,
      body: Center(
        child: CircularProgressIndicator(color: UColors.white),
      ),
    );
  }
}

class LoadingController extends GetxController{
  static LoadingController get instance => Get.find();


  @override
  void onInit() {
    BranchServices.instance.trackLink((data){
      AuthenticationRepository.instance.screenRedirect();
    }, onError: () => AuthenticationRepository.instance.screenRedirect());
    super.onInit();
  }
}