import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class UFullScreenLoader{

  static void openLoadingDialog(String text, String animation){
    showDialog(

        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: UHelperFunctions.isDarkMode(Get.context!) ? UColors.dark : UColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250,),

                  UAnimationLoader(text: text, animation: animation)
                ],
              ),
            )
        )
    );
  }

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}