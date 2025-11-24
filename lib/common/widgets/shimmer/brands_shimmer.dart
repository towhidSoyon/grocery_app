import 'package:flutter/material.dart';
import 'package:grocery_app/common/widgets/shimmer/shimmer_effect.dart';

import '../layout/grid_layout.dart';

class UBrandsShimmer extends StatelessWidget {
  const UBrandsShimmer({super.key,this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return UGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (context, index) => const UShimmerEffect(width: 300, height: 80),
    );
  }
}