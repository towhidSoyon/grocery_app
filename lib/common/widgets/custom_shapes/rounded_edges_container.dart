import 'package:flutter/material.dart';

import 'clipper/custom_rounded_clipper.dart';

class URoundedEdges extends StatelessWidget {
  final Widget child;
  const URoundedEdges({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: UCustomRoundedEdges(),
        child: child,
    );
  }
}
