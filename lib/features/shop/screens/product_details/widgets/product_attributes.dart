import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery_app/utils/constants/texts.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/variation_controller.dart';
import '../../../models/product_model.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
          () => Column(
        children: [
          /// Selected Attribute Pricing & Description
          // Display variation price and stock when some variation is selected
          if(controller.selectedVariation.value.id.isNotEmpty)
            URoundedContainer(
              backgroundColor: dark ? UColors.darkerGrey : UColors.grey,
              padding: const EdgeInsets.all(USizes.md),

              /// Title, Price and Stock Status
              child: Column(
                children: [
                  Row(
                    children: [
                      const USectionHeading(title: 'Variation'),
                      const SizedBox(
                        width: USizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Price Row
                          Row(
                            children: [
                              const UProductTitleText(
                                title: 'Price : ',
                                smallSize: true,
                              ),

                              /// Actual Price
                              if(controller.selectedVariation.value.salePrice > 0)
                                Text(
                                  '${UTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                                  style: Theme.of(context).textTheme.titleSmall!.apply(overflow: TextOverflow.ellipsis,decoration: TextDecoration.lineThrough),
                                ),
                              const SizedBox(
                                width: USizes.spaceBtwItems,
                              ),

                              /// Sale Price
                              UProductPriceText(price: controller.getVariationPrice()),
                            ],
                          ),

                          /// Stock Row
                          Row(
                            children: [
                              const UProductTitleText(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),

                  /// Variation Description
                  UProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  )
                ],
              ),
            ),
          const SizedBox(
            height: USizes.spaceBtwItems,
          ),

          /// Attributes
          /// Multiple Colors Attributes & Multiple Sizes Attributes
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.productAttributes!.map((attribute) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    USectionHeading(title: attribute.name ?? ''),
                    const SizedBox(
                      height: USizes.spaceBtwItems / 2,
                    ),
                    Obx(
                          () => Wrap(
                          spacing: 8,
                          children: attribute.values!
                              .map(
                                  (attributeValue) {
                                final isSelected = controller.selectedAttributes[attribute.name] == attributeValue; // 'Green' == 'Green'
                                final available = controller.getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!)
                                    .contains(attributeValue);
                                return UChoiceChip(
                                  text: attributeValue,
                                  selected: isSelected,
                                  onSelected: available ? (selected){
                                    if(available && selected){
                                      controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                                    }
                                  } : null,
                                );
                              }
                          )
                              .toList()),
                    )
                  ],
                );
              }).toList())
        ],
      ),
    );
  }
}