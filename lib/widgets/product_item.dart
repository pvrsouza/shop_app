import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';

import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  /* final String id;
  final String title;
  final String imageUrl;

  ProductItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });
 */
  @override
  Widget build(BuildContext context) {
    /**
     * pega o valor só uma vez e não forca o rebuild de todo o Widget.
     * vamos implementar um Consumer onde sabemos que é o único valor que muda no Product.
     */
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    ///Como o GridTile não tem como controlar BorderRaduis, podemos usar o ClipRRect para isso
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,

          ///Aqui usamos o Consumer porque garantimos que só esse trecho será atualizado
          ///quando o listner perceber alterações.
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              onPressed: () {
                product.toogleFavorite();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);

              ///limpa os snackbar antes de exibir um novo
              Scaffold.of(context).hideCurrentSnackBar();

              ///O Scaffold.of(context) tenta encontrar na arvore de widget o Scaffold mais próximo para conseguir
              ///interagir como ele e exibir as coisas
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Item added to cart!',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
