import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:grocery_app/features/shop/screens/sub_category/sub_category.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../common/widgets/shimmer/category_shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/category/category_controller.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(() {
      if(controller.isLoading.value) return const UCategoryShimmer();

      if(controller.featuredCategories.isEmpty){
        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
      }else{
        return SizedBox(
          height: 90,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: controller.featuredCategories.length,
            separatorBuilder: (_, __) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = controller.featuredCategories[index];
              return UVerticalImageText(
                image: category.image,
                title: category.name,
                textColor: UColors.white,
                onTap: () =>
                    Get.to(() => SubCategoriesScreen(category: category)),
              );
            },
          ),
        );

      }

    });
  }
}
