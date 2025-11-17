import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import '../../../../../common/widgets/custom_shapes/rounded_edges_container.dart';
import '../../../../../utils/constants/colors.dart';

class UPrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const UPrimaryHeaderContainer({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return URoundedEdges(
      child: Container(
          height: USizes.homePrimaryHeaderHeight,
          color: UColors.primary,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -160,
                child: Container(
                  height: USizes.homePrimaryHeaderHeight,
                  width: USizes.homePrimaryHeaderHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      color: UColors.white.withValues(alpha: 0.1)
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: -250,
                child: Container(
                  height: USizes.homePrimaryHeaderHeight,
                  width: USizes.homePrimaryHeaderHeight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      color: UColors.white.withValues(alpha: 0.1)
                  ),
                ),
              ),
      
              child
      
            ],
          ),
      ),
    );
  }
}

