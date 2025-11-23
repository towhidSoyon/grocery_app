import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../authentication/models/address_model.dart';
import '../../../controllers/address_controller.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    final controller = AddressController.instance;

    return Obx(
            () {
          final selectedAddressId = controller.selectedAddress.value.id;
          final selectedAddress = selectedAddressId == address.id;
          return InkWell(
            borderRadius: BorderRadius.circular(USizes.cardRadiusLg),
            onTap: onTap,
            child: URoundedContainer(
              padding: const EdgeInsets.all(USizes.md),
              width: double.infinity,
              showBorder: true,
              backgroundColor: selectedAddress ? UColors.primary.withOpacity(0.5) : Colors.transparent,
              borderColor: selectedAddress ? Colors.transparent :
              dark ? UColors.darkerGrey : UColors.grey,
              margin: const EdgeInsets.only(bottom: USizes.spaceBtwItems),
              child: Stack(
                children: [
                  Positioned(
                    right: 5,
                    top: 0,
                    child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                      color: selectedAddress ?
                      dark ? UColors.light : UColors.dark
                          : null,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: USizes.sm / 2,),
                      Text(address.phoneNumber, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: USizes.sm / 2,),
                      Text(address.toString(), softWrap: true,)
                    ],
                  )

                ],
              ),
            ),
          );
        }
    );
  }
}