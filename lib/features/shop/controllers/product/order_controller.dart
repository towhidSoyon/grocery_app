import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grocery_app/features/authentication/screens/forgot_password/account_created.dart';

import '../../../../navigation_menu.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/enum.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalization/controllers/address_controller.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async{
    try{

      final userOrders = await orderRepository.fetchUserOrders();

      return userOrders;
    }catch(e){
      print(e);
      UHelperFunctions.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(double totalAmount) async{
    try {
      // Start Loader
      UFullScreenLoader.openLoadingDialog('Processing your order...', UImages.pencilAnimation);

      // Get user authentication id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        // Generate the unique id for the order
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          // Set date as needed
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList()
      );

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);

      // update the cart status
      cartController.clearCart();

      // Show Success Screen
      Get.off(() =>
          AccountCreatedScreen(
            image: UImages.successfulPaymentIcon,
            title: 'Payment Success!',
            subtitle: 'Your item will be shipped soon!',
            onTap: () => Get.offAll(() => const NavigationMenu()),));
    }catch(e){
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}