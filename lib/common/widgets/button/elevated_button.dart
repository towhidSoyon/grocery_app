import 'package:flutter/material.dart';
import 'package:grocery_app/utils/helpers/device_helpers.dart';

class UElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const UElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UDeviceHelper.getScreenWidth(context),
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}
