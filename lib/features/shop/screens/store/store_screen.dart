import 'package:flutter/material.dart';
import 'package:grocery_app/common/widgets/texts/section_heading.dart';
import 'package:grocery_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:grocery_app/features/shop/screens/store/widgets/store_primary_header_container.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../utils/constants/sizes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      UStorePrimaryHeader(),
                      SizedBox(height: USizes.spaceBtwItems),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: USizes.defaultSpace,
                        ),
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
                                itemBuilder: (context, index) => SizedBox(
                                  width: USizes.brandCardWidth,
                                  child: UBrandCard(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: UTabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab()
            ],
          ),
        ),
      ),
    );
  }
}
