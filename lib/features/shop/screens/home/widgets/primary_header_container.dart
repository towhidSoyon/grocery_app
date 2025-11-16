import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/clipper/custom_rounded_clipper.dart';
import '../../../../../common/widgets/custom_shapes/rounded_edges_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/device_helpers.dart';

class UPrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const UPrimaryHeaderContainer({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return URoundedEdges(
      child: Container(
          height: UDeviceHelper.getScreenHeight(context) * 0.4,
          color: UColors.primary,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -160,
                child: Container(
                  height: UDeviceHelper.getScreenHeight(context) * 0.4,
                  width: UDeviceHelper.getScreenHeight(context) * 0.4,
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
                  height: UDeviceHelper.getScreenHeight(context) * 0.4,
                  width: UDeviceHelper.getScreenHeight(context) * 0.4,
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

