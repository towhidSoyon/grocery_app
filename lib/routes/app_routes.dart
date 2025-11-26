import 'package:get/get.dart';
import 'package:grocery_app/features/authentication/screens/forgot_password/verify_email.dart';
import 'package:grocery_app/features/authentication/screens/signup/sign_up.dart';
import 'package:grocery_app/features/personalization/screens/address/add_new_address.dart';
import 'package:grocery_app/features/personalization/screens/edit_profile/edit_profile.dart';
import 'package:grocery_app/features/shop/screens/brand/brand_products.dart';
import 'package:grocery_app/features/shop/screens/order/order.dart';
import 'package:grocery_app/features/shop/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/routes/routes.dart';

import '../features/authentication/screens/forgot_password/forgot_password.dart';
import '../features/authentication/screens/login/login_screen.dart';
import '../features/authentication/screens/onboarding/onboarding_screen.dart';
import '../features/personalization/screens/profile/profile_screen.dart';
import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/store/store_screen.dart';
import '../loading.dart';

class UAppRoutes{

  static final screens = [
    GetPage(name: URoutes.home, page: () => const LoadingScreen()),
    GetPage(name: URoutes.store, page: () => const StoreScreen(),),
    GetPage(name: URoutes.wishlist, page: () => const FavouriteScreen()),
    GetPage(name: URoutes.profile, page: () => const ProfileScreen(),),
    GetPage(name: URoutes.order, page: () => const OrdersScreen(),),
    GetPage(name: URoutes.checkout, page: () => const CheckoutScreen(),),
    GetPage(name: URoutes.cart, page: () => const CartScreen(),),
    GetPage(name: URoutes.editProfile, page: () => const EditProfile(),),
    GetPage(name: URoutes.userAddress, page: () => const AddNewAddressScreen(),),
    GetPage(name: URoutes.signup, page: () => const SignUpScreen(),),
    GetPage(name: URoutes.verifyEmail, page: () => const VerifyEmailScreen(email: 'email'),),
    GetPage(name: URoutes.signIn, page: () => const LoginScreen(),),
    GetPage(name: URoutes.forgetPassword, page: () => const ForgotPassword(),),
    GetPage(name: URoutes.onBoarding, page: () => const OnboardingScreen(),),
  ];
}

