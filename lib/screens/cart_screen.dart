import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Dentro de cart.dart tem uma classe CartItem que conflita com o widgets/cart_item.dart
///Usamos o 'show' para informar ao Dart que só precisamos do Cart e não do CartItem
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      '\$${cartProvider.totalAmount}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color,
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Text('ORDER NOW'),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          ///Sempre que for usar um ListView, usar um Expanded para não dar erro
          ///porque ele ocupa o maior espaco possível da tela
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => CartItem(
                id: cartProvider.items.values.toList()[index].id,
                price: cartProvider.items.values.toList()[index].price,
                quantity: cartProvider.items.values.toList()[index].quantity,
                title: cartProvider.items.values.toList()[index].title,
              ),
              itemCount: cartProvider.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
