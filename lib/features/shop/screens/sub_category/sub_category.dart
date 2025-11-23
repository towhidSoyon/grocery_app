import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widgets/shimmer/horizontal_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/constants.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/category/category_controller.dart';
import '../../models/category_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});


  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(category.name, style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
               URoundedImage(imageUrl: UImages.productImage1,width: double.infinity,applyImageRadius: true,),
              const SizedBox(height: USizes.spaceBtwSections,),

              /// Sub Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {

                    /// Handle Loader, No Message, Error
                    const loader = UHorizontalProductShimmer();
                    final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    if(widget != null) return widget;

                    /// Record Found
                    final subCategories = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {

                        final subCategory = subCategories[index];

                        return FutureBuilder(
                            future: controller.getCategoryProducts(categoryId: subCategory.id),
                            builder: (context, snapshot) {

                              /// Handle Loader, No Message, Error
                              final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                              if(widget != null) return widget;

                              /// Record Found
                              final products = snapshot.data!;

                              return Column(
                                children: [
                                  /// Heading
                                  USectionHeading(title: subCategory.name, showActionButton: true,
                                    onPressed: () => Get.to(() => AllProducts(
                                      title: subCategory.name,
                                      futureMethod: controller.getCategoryProducts(categoryId: subCategory.id,limit: -1),
                                    )),
                                  ),
                                  const SizedBox(height: USizes.spaceBtwItems / 2,),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) => const SizedBox(width: USizes.spaceBtwItems,),
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => UProductCardHorizontal(product: products[index])
                                    ),
                                  ),

                                  const SizedBox(height: USizes.spaceBtwSections,)

                                ],
                              );
                            }
                        );
                      },
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}