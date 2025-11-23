import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/features/shop/screens/checkout/widgets/payment_tile.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  /// Variables
  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Paypal', image: UImages.paypal);
    super.onInit();
  }

  ///
  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(USizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const USectionHeading(title: 'Select Payment Method',),
              const SizedBox(height: USizes.spaceBtwSections,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: UImages.paypal)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: UImages.googlePay)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: UImages.applePay)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: UImages.visa)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: UImages.masterCard)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm', image: UImages.paytm)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paystack', image: UImages.paystack)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: UImages.creditCard)),
              const SizedBox(height: USizes.spaceBtwItems / 2,),
              const SizedBox(height: USizes.spaceBtwSections,),
            ],
          ),
        ),
      ),
    );
  }
}