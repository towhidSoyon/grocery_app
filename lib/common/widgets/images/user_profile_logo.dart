import 'package:flutter/cupertino.dart';
import 'package:grocery_app/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/constants.dart';
import 'circular_image.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    bool isProfileAvailable = controller.user.value.profilePicture.isNotEmpty;
    return UCircularImage(
      borderWidth: 5,
      padding: 0,
      height: 120,
      width: 120,
      image: isProfileAvailable? controller.user.value.profilePicture : UImages.profileLogo,
      isNetworkImage: isProfileAvailable,
    );
  }
}