import 'package:flutter/cupertino.dart';

import '../../../utils/constants/constants.dart';
import 'circular_image.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UCircularImage(
      borderWidth: 5,
      padding: 0,
      height: 120,
      width: 120,
      image: UImages.accountCreatedImage,
    );
  }
}