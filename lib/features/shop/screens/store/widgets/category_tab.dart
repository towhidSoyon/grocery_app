import 'package:flutter/cupertino.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../../utils/constants/sizes.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              UBrandShowcase(
                image: [
                  UImages.accountCreatedImage,
                  UImages.accountCreatedImage,
                  UImages.accountCreatedImage,
                ],
              ),
              UBrandShowcase(
                image: [
                  UImages.accountCreatedImage,
                  UImages.accountCreatedImage,
                  UImages.accountCreatedImage,
                ],
              ),
              UBrandShowcase(
                image: [
                  UImages.accountCreatedImage,
                  UImages.accountCreatedImage,
                  UImages.accountCreatedImage,
                ],
              ),
              SizedBox(height: USizes.spaceBtwItems),

              USectionHeading(title: 'You might like', onPressed: () {}),
              UGridLayout(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return UProductCardVertical(product: null);
                },
              ),
              SizedBox(height: USizes.spaceBtwSections)
            ],
          ),
        ),
      ],
    );
  }
}
