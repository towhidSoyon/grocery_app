import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/widgets/shimmer/shimmer_effect.dart';
import 'package:grocery_app/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/constants.dart';
import 'circular_image.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() {
      bool isProfileAvailable = controller.user.value.profilePicture.isNotEmpty;
      if(controller.imageUploading.value){
        return UShimmerEffect(width: 120, height: 120, radius: 120);
      }
      return UCircularImage(
        borderWidth: 5,
        padding: 0,
        height: 120,
        width: 120,
        image: isProfileAvailable
            ? controller.user.value.profilePicture
            : UImages.profileLogo,
        isNetworkImage: isProfileAvailable,
      );
    });
  }
}
