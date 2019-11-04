import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get orders {
    return [..._items];
  }

  void addOrder(List<CartItem> products, double total) {
    var dateTime = DateTime.now();
    _items.insert(
        0,
        OrderItem(
          id: dateTime.toString(),
          amount: total,
          dateTime: dateTime,
          products: products,
        ));

        notifyListeners();
  }
}
