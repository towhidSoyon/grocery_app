import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/widgets/button/elevated_button.dart';
import 'package:grocery_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:grocery_app/features/authentication/screens/onboarding/widget/onboarding.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/constants/texts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/device_helpers.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
        child: Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoarding(
                  animation: UImages.onboarding1Animation,
                  title: UTexts.onBoardingTitle1,
                  subTitle: UTexts.onBoardingSubTitle1,
                ),
                OnBoarding(
                  animation: UImages.onboarding2Animation,
                  title: UTexts.onBoardingTitle2,
                  subTitle: UTexts.onBoardingSubTitle2,
                ),
                OnBoarding(
                  animation: UImages.onboarding3Animation,
                  title: UTexts.onBoardingTitle3,
                  subTitle: UTexts.onBoardingSubTitle3,
                ),
              ],
            ),

            Positioned(
              bottom: UDeviceHelper.getBottomNavigationBarHeight() * 4,
              left: UDeviceHelper.getScreenWidth(context) * 3,
              right: UDeviceHelper.getScreenWidth(context) * 3,
              child: SmoothPageIndicator(
                controller: controller.pageController,
                onDotClicked: controller.dotNavigationClick,
                count: 3,
                effect: ExpandingDotsEffect(dotHeight: 6.0),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: USizes.spaceBtwItems / 2,
              child: UElevatedButton(
                onPressed: () {
                  controller.nextPage();
                },
                child: Obx(
                  () => Text(
                    controller.currentIndex.value == 2 ? 'Get Started' : 'Next',
                  ),
                ),
              ),
            ),

            Obx(
              () => controller.currentIndex.value == 2
                  ? SizedBox()
                  : Positioned(
                      top: UDeviceHelper.getAppBarHeight(),
                      right: 0,
                      child: TextButton(
                        onPressed: () {
                          controller.skipPage();
                        },
                        child: Text("Skip"),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
