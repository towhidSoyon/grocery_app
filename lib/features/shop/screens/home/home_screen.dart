import 'package:flutter/material.dart';
import 'package:grocery_app/features/shop/screens/home/widgets/primary_header_container.dart';
import '../../../../common/widgets/appbar/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UPrimaryHeaderContainer(child: Column(children: [UAppBar()])),
    );
  }
}


