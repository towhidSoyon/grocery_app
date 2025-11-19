import 'package:flutter/material.dart';
import 'package:grocery_app/common/style/padding.dart';
import 'package:grocery_app/common/widgets/appbar/appbar.dart';
import 'package:grocery_app/common/widgets/texts/section_heading.dart';
import 'package:grocery_app/features/personalization/screens/edit_profile/widgets/edit_profile_with_edit_icon.dart';
import 'package:grocery_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              UserProfileWithEditIcon(),
              SizedBox(height: USizes.spaceBtwSections),
              Divider(),

              SizedBox(height: USizes.spaceBtwItems),

              USectionHeading(
                title: 'Account Settings',
                showActionButton: false,
              ),

              UserDetailRow(title: 'Name', value: 'Towhid Soyon', onTap: () {}),
              UserDetailRow(title: 'Name', value: 'Towhid Soyon', onTap: () {}),

              SizedBox(height: USizes.spaceBtwItems),
              Divider(),

              SizedBox(height: USizes.spaceBtwItems),

              USectionHeading(
                title: 'Profile Settings',
                showActionButton: false,
              ),

              UserDetailRow(title: 'Name', value: 'Towhid Soyon', onTap: () {}),
              UserDetailRow(title: 'Name', value: 'Towhid Soyon', onTap: () {}),
              UserDetailRow(title: 'Name', value: 'Towhid Soyon', onTap: () {}),
              UserDetailRow(title: 'Name', value: 'Towhid Soyon', onTap: () {}),

              SizedBox(height: USizes.spaceBtwItems),
              Divider(),

              SizedBox(height: USizes.spaceBtwItems),

              TextButton(onPressed: (){}, child: Text('Close Account', style: TextStyle(color: Colors.red)))
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailRow extends StatelessWidget {
  final String title, value;
  final IconData? iconData;
  final VoidCallback onTap;

  const UserDetailRow({
    super.key,
    required this.title,
    required this.value,
    this.iconData = Iconsax.arrow_right_34,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: USizes.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(child: Icon(iconData, size: USizes.iconSm)),
          ],
        ),
      ),
    );
  }
}
