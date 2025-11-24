import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/category/category_controller.dart';
import '../../../models/category_model.dart';
import '../../all_products/all_products.dart';
import 'category_brands.dart';

class UCategoryTab extends StatelessWidget {
  final CategoryModel category;
  const UCategoryTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              CategoryBrands(category: category),
              const SizedBox(height: USizes.spaceBtwItems,),

              /// Products
              FutureBuilder(
                  future: controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {

                    /// Handle Error, Loader, Empty Data
                    const loader = UVerticalProductShimmer();
                    final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                    if(widget != null) return widget;

                    /// Data Found!
                    final products = snapshot.data!;
                    return Column(
                      children: [
                        USectionHeading(
                          title: 'You might like',
                          showActionButton: true,
                          onPressed: () => Get.to(() => AllProducts(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(categoryId: category.id,limit: -1),)),),
                        const SizedBox(height: USizes.spaceBtwItems,),

                        UGridLayout(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return UProductCardVertical(product: product);
                          },),
                        const SizedBox(height: USizes.spaceBtwSections,),
                      ],
                    );
                  }
              ),

            ],
          ),
        )
      ],
    );
  }
}
