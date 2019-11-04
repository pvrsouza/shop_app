import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => OrderItem(
          order: orderProvider.orders[index],
        ),
        itemCount: orderProvider.orders.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
