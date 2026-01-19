import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Obx(
                () => FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context, snapshot) {
                  /// Handle loader, no record, error message
                  const emptyWidget = UAnimationLoader(
                    text: 'Whoops! Address is not available...',
                    animation: UImages.pencilAnimation,
                    showAction: false,
                  );
                  final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,nothingFound: emptyWidget);
                  if (widget != null) return widget;

                  /// Record Found
                  final addresses = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      itemBuilder: (context, index) => USingleAddress(
                        address: addresses[index],
                        onTap: () => controller.selectAddress(addresses[index]),
                      ));
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: UColors.primary,
        child: const Icon(
          Iconsax.add,
          color: UColors.white,
        ),
      ),
    );
  }
}