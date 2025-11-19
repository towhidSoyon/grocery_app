import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/user_profile_logo.dart';

class UserProfileWithEditIcon extends StatelessWidget {
  const UserProfileWithEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: UserProfileLogo()),

        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 0,
          child: Center(child: UCircularIcon(icon: Iconsax.edit)),
        ),
      ],
    );
  }
}
