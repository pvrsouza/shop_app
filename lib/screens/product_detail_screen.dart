import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static String routeName = '/product-detail';

  /*  final String title;
  final double price;

  ProductDetailScreen({
    @required this.title,
    @required this.price,
  }); */

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    final productsData = Provider.of<Products>(
      context,
      //com este argumento False ele não fica escutando as alterações no provider.
      listen: false,
    );
    final Product product = productsData.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Text(product.description),
      ),
    );
  }
}
