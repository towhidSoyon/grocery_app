import 'package:flutter/material.dart';

class SettingMenuTile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const SettingMenuTile({
    super.key, required this.title, required this.subtitle, required this.icon, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: Theme
            .of(context)
            .textTheme
            .titleMedium),
        subtitle: Text(subtitle, style: Theme
            .of(context)
            .textTheme
            .labelMedium),
      ),
    );
  }
}