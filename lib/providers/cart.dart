import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (oldCartItem) => CartItem(
          id: oldCartItem.id,
          price: oldCartItem.price,
          quantity: oldCartItem.quantity + 1,
          title: oldCartItem.title,
        ),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                price: price,
                quantity: 1,
                title: title,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (exsistingCartItem) => CartItem(
                id: exsistingCartItem.id,
                price: exsistingCartItem.price,
                quantity: exsistingCartItem.quantity - 1,
                title: exsistingCartItem.title,
              ));
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  void removeAllProductsItems(String id) {
    if (id != null) {
      _items.remove(id);
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
