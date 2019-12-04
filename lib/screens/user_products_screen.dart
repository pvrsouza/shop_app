import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProdutcsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: ListView.builder(
            itemCount: productsProvider.items.length,
            itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                UserProductItem(
                  id: productsProvider.items[index].id,
                  title: productsProvider.items[index].title,
                  imageUrl: productsProvider.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
