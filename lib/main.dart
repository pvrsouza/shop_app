import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_detail_screen.dart';
import './screens/products_overwiew_screen.dart';
import './screens/cart_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';

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
        ChangeNotifierProvider<Products>.value(
          value: Products(),
        ),
        ChangeNotifierProvider<Cart>.value(
          value: Cart(),
        )
      ],
      //Registra o provider
      //value: Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
