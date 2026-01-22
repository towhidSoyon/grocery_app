import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../personalization/controllers/address_controller.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        USectionHeading(
          title: 'Shipping Address',
          showActionButton: true,
          buttonTitle: 'Change',
          onPressed: () => controller.selectNewAddressPopup(context),
        ),

        Obx(() {
          if (controller.selectedAddress.value.id.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.selectedAddress.value.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: USizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 16, color: Colors.grey),
                    const SizedBox(width: USizes.spaceBtwItems),
                    Text(
                      controller.selectedAddress.value.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: USizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_history,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: USizes.spaceBtwItems),
                    Text(
                      controller.selectedAddress.value.toString().toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Text(
              'Select Address',
              style: Theme.of(context).textTheme.bodyMedium,
            );
          }
        }),
      ],
    );
  }
}
