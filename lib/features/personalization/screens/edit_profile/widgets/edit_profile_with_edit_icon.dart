import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery_app/features/personalization/controllers/user_controller.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/user_profile_logo.dart';

class UserProfileWithEditIcon extends StatelessWidget {
  const UserProfileWithEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Stack(
      children: [
        Center(child: UserProfileLogo()),

        Obx(() {
          if (controller.imageUploading.value) {
            return SizedBox();
          }
          return Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: UCircularIcon(
                icon: Iconsax.edit,
                onPressed: controller.updateUserProfilePicture,
              ),
            ),
          );
        }),
      ],
    );
  }
}
