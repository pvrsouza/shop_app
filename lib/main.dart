import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import './screens/product_detail_screen.dart';
import './screens/products_overwiew_screen.dart';

import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /**
     * Caso o Provider ( Products ) dependa do contexto, temos que usar o 'builder'
     * caso contrario é possível usar só o construtor .value
     */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>.value(value: Products()),
      ],
      //Registra o provider
      //value: Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        //home: ProductsOverviewScreen(),
        routes: {
          "/": (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
