import 'package:flutter/material.dart';

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
    print(productId);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Text('The product details!'),
      ),
    );
  }
}
