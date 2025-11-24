import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery_app/common/widgets/texts/section_heading.dart';
import 'package:grocery_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:grocery_app/features/shop/screens/store/widgets/store_primary_header_container.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_counter_icon.dart';
import '../../../../common/widgets/shimmer/brands_shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/category/category_controller.dart';
import '../../controllers/product/brand_controller.dart';
import '../brand/brand_products.dart';
import '../brand/all_brands.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = UHelperFunctions.isDarkMode(context);
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: UAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: const [
            UCartCounterIcon(),
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    floating: true,
                    pinned: true,
                    backgroundColor: dark ? UColors.black : UColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                        padding: const EdgeInsets.all(USizes.defaultSpace),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            /// Search Appbar
                            const SizedBox(
                              height: USizes.spaceBtwItems,
                            ),
                            const USearchContainer(
                              text: 'Search in Store',
                              showBorder: true,
                              showBackground: false,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(
                              height: USizes.spaceBtwSections,
                            ),

                            /// Featured Brands
                            USectionHeading(
                              title: 'Featured Brands',
                              showActionButton: true,
                              onPressed: () => Get.to(() => const AllBrandsScreen()),
                            ),
                            const SizedBox(
                              height: USizes.spaceBtwItems / 1.5,
                            ),

                            /// Brand GridView
                            Obx(
                                    (){
                                  if(brandController.isLoading.value) return const UBrandsShimmer();

                                  if(brandController.featuredBrands.isEmpty){
                                    return Center(
                                      child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),
                                    );
                                  }

                                  return UGridLayout(
                                    itemCount: brandController.featuredBrands.length,
                                    mainAxisExtent: 80,
                                    itemBuilder: (context, index) {
                                      final brand = brandController.featuredBrands[index];
                                      return UBrandCard(
                                        showBorder: true,
                                        brand: brand,
                                        onTap: () => Get.to(() => BrandProducts(brand: brand)),
                                      );
                                    },
                                  );
                                }
                            ),
                          ],
                        )),
                    bottom: UTabBar(
                        tabs: categories
                            .map((category) => Tab(
                          child: Text(category.name),
                        ))
                            .toList())),
              ];
            },
            body: TabBarView(
              children: categories.map((category) => UCategoryTab(category: category)).toList(),
            )),
      ),
    );
  }
}