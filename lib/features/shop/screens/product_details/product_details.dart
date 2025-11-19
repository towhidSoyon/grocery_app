import 'package:flutter/material.dart';
import 'package:grocery_app/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:grocery_app/utils/helpers/helper_functions.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = UHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProductThumbnailAndSlider(),
          ],
        ),
      ),
    );
  }
}


