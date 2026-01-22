import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/appbar/appbar.dart';
import 'package:grocery_app/common/widgets/images/rounded_image.dart';
import 'package:grocery_app/common/widgets/layout/grid_layout.dart';
import 'package:grocery_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:grocery_app/common/widgets/texts/section_heading.dart';
import 'package:grocery_app/features/shop/controllers/product/product_controller.dart';
import 'package:grocery_app/features/shop/screens/search_store/widgets/search_store_brands.dart';
import 'package:grocery_app/features/shop/screens/search_store/widgets/search_store_categories.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:grocery_app/utils/helpers/cloud_helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxString searchText = "".obs;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          "Search",
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              Hero(
                tag: 'search_animation',
                child: Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    onChanged: (value) => searchText.value = value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal1),
                      helperText: "Search in store",
                    ),
                  ),
                ),
              ),
              SizedBox(height: USizes.spaceBtwSections),

              Obx(() {
                if (searchText.value.isEmpty) {
                  return Column(
                    children: [
                      SearchStoreBrands(),

                      SizedBox(height: USizes.spaceBtwSections),

                      SearchStoreCategories(),
                    ],
                  );
                }

                return FutureBuilder(
                    future: ProductController.instance.getAllProducts(),
                    builder: (context, snapshot) {

                      final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                      if(widget != null){
                        return widget;
                      }


                      final products = snapshot.data!;
                      
                      final filteredProducts = products.where((product) => product.title.toLowerCase().contains(searchText.value.toLowerCase())).toList();

                      if(filteredProducts.isEmpty) return Text('No Products Found');

                      return UGridLayout(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return UProductCardVertical(product: product);
                        },
                      );
                    },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
