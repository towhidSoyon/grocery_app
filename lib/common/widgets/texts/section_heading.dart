import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class USectionHeading extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final void Function()? onPressed;

  const USectionHeading({
    super.key,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
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
        TextButton(
          onPressed: onPressed,
          child: Text(buttonTitle, style: TextStyle(color: UColors.primary)),
        ),
      ],
    );
  }
}
