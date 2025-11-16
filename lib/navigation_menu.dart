import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/utils/constants/colors.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import 'features/shop/screens/store/store_screen.dart';
import 'features/shop/screens/profile/profile_screen.dart';
import 'features/shop/screens/home/home_screen.dart';
import 'features/shop/screens/wishlist/wishlist_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    bool dark = UHelperFunctions.isDarkMode(context);

    return Scaffold(

      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      /// -----[Navigation Menu]-----
      bottomNavigationBar: Obx(
            () => NavigationBar(
            elevation: 0,
            backgroundColor: dark ? UColors.dark : UColors.light,
            indicatorColor: dark ? UColors.light.withValues(alpha: 0.1) : UColors.dark.withValues(alpha: 0.1),
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) {
              controller.selectedIndex.value = index;
            },
            destinations: [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
              NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ]),
      ),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  RxInt selectedIndex = 0.obs;


  List<Widget> screens = [HomeScreen(), HomeScreen(), WishlistScreen(), ProfileScreen()];
}