import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  OrderItem({
    @required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm:ss').format(order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.expand_more),
            ),
          ),
        ],
      ),
    );
  }
}
