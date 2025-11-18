import 'package:flutter/material.dart';
import 'package:grocery_app/common/widgets/appbar/appbar.dart';
import 'package:grocery_app/common/widgets/custom_shapes/rounded_container.dart';
import 'package:grocery_app/common/widgets/images/rounded_image.dart';
import 'package:grocery_app/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:grocery_app/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:grocery_app/common/widgets/texts/section_heading.dart';
import 'package:grocery_app/features/shop/screens/store/widgets/store_primary_header_container.dart';
import 'package:grocery_app/utils/constants/colors.dart';
import 'package:grocery_app/utils/constants/constants.dart';
import 'package:grocery_app/utils/constants/enum.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/text_fields/search_bar.dart';
import '../../../../utils/constants/sizes.dart';
import '../home/widgets/home_appbar.dart';
import '../home/widgets/home_categories.dart';
import '../home/widgets/primary_header_container.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 300,
              pinned: true,
              floating: true,
              flexibleSpace: Column(
                children: [
                  UStorePrimaryHeader(),
                  SizedBox(height: USizes.spaceBtwItems),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
                    child: Column(
                      children: [
                        USectionHeading(title: 'Brands', onPressed: () {}),

                        SizedBox(
                          height: USizes.brandCardHeight,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(width: USizes.spaceBtwItems),
                            shrinkWrap: true,
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => UBrandCard(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}
