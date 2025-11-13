import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../utils/helpers/device_helpers.dart';

class OnBoarding extends StatelessWidget {
  final String animation;
  final String title;
  final String subTitle;

  const OnBoarding({
    super.key,
    required this.animation,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: UDeviceHelper.getAppBarHeight(),
      ),
      child: Column(
        children: [
          Lottie.asset(animation),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(subTitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
