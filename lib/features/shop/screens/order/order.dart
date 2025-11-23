import 'package:flutter/material.dart';
import 'package:grocery_app/features/shop/screens/order/widgets/orders_list.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// AppBar
        appBar: UAppBar(
            showBackArrow: true,
            title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall)
        ),
        body: const Padding(
            padding: EdgeInsets.all(USizes.defaultSpace),

            /// Orders
            child: UOrdersListItems()
        )
    );
  }
}