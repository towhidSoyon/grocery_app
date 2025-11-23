import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:grocery_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:grocery_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:grocery_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../common/widgets/products/cart/coupon_textfield.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final subTotal = cartController.totalCartPrice.value;
    final totalAmount = UPricingCalculator.calculateTotalPrice(subTotal, 'US');

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Order Review', style: Theme
            .of(context)
            .textTheme
            .headlineSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            children: [
              const UCartItems(showAddRemoveButtons: false,),
              const SizedBox(height: USizes.spaceBtwSections,),

              /// Coupon TextField
              const UCouponCode(),
              const SizedBox(height: USizes.spaceBtwSections,),

              /// Billing Section
              URoundedContainer(
                padding: const EdgeInsets.all(USizes.md),
                showBorder: true,
                backgroundColor: dark ? UColors.black : UColors.white,
                child: const Column(
                  children: [

                    /// Pricing
                    UBillingAmountSection(),
                    SizedBox(height: USizes.spaceBtwItems,),

                    /// Divider
                    Divider(),
                    SizedBox(height: USizes.spaceBtwItems,),

                    /// payment Methods
                    UBillingPaymentSection(),
                    SizedBox(height: USizes.spaceBtwItems,),

                    /// Address
                    UBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => UHelperFunctions.errorSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed'),
          child: Text('Checkout \$$totalAmount'),),
      ),
    );
  }
}