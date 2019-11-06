import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static final routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Product',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          ///O ideal seria usar um Column com SingleChildScrollView porque o ListView não garante o estado dos campos quando muda a orientação.
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),

                ///define a acao do botao ENTER do teclado
                ///Mas neste caso para funciona tem que fazer a configuração manualmente do FocusNode() + onFieldSubmitted: + focusNode:
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
