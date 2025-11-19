import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class USectionHeading extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final void Function()? onPressed;
  final bool showActionButton;

  const USectionHeading({
    super.key,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed, this.showActionButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if(showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle, style: TextStyle(color: UColors.primary))),
      ],
    );
  }
}
