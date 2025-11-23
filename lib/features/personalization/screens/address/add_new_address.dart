import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Add new Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                /// Name
                TextFormField(
                  controller: controller.name,
                  validator: (value) => UValidator.validateEmptyText("Name", value),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                ),
                const SizedBox(
                  height: USizes.spaceBtwInputFields,
                ),

                /// Phone
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => UValidator.validateEmptyText("Phone", value),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number'),
                ),
                const SizedBox(
                  height: USizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      /// Street
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => UValidator.validateEmptyText("Street", value),
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street'),
                      ),
                    ),
                    const SizedBox(
                      width: USizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      /// Postal Code
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => UValidator.validateEmptyText("Postal Code", value),
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: USizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(

                      /// City
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) => UValidator.validateEmptyText("City", value),
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City'),
                      ),
                    ),
                    const SizedBox(
                      width: USizes.spaceBtwInputFields,
                    ),
                    Expanded(

                      /// State
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) => UValidator.validateEmptyText("State", value),
                        decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: USizes.spaceBtwInputFields,
                ),

                /// Country
                TextFormField(
                  controller: controller.country,
                  validator: (value) => UValidator.validateEmptyText("Country", value),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                ),
                const SizedBox(
                  height: USizes.spaceBtwInputFields * 2,
                ),

                /// Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.addNewAddress(), child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}