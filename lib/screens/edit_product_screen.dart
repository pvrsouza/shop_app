import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static final routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formState = GlobalKey<FormState>();

  Product _product = new Product(
    id: null,
    description: '',
    title: '',
    imageUrl: '',
    price: 0,
    isFavorite: false,
  );

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();

    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void initState() {
    //para conseguir disparar a mudanca da imagem quando tirar o foco do ImageUrl
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    print('updateImage');
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  bool _validateUrl(value) {
    final validProtocol = value.startsWith('http') || value.startsWith('https');

    final validExtension = value.endsWith('.png') ||
        value.endsWith('.jpg') ||
        value.endsWith('.jpeg');

    return validExtension && validProtocol;
  }

  void _saveForm() {
    //faz a validação
    final _isValid = _formState.currentState.validate();
    if (!_isValid) {
      return;
    }

    _formState.currentState.save();

    /* print(_product.title);
    print(_product.price);
    print(_product.description);
    print(_product.imageUrl); */
  }

  @override
  Widget build(BuildContext context) {
    print('Edit product');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Product',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          ///O auto validate não funciona no OnBlur
          //autovalidate: true,
          key: _formState,

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
                onSaved: (value) {
                  _product.title = value;
                  /* _product = Product(
                    title: value,
                    price: _product.price,
                    description: _product.description,
                    id: null,
                    imageUrl: _product.imageUrl,
                    isFavorite: _product.isFavorite,
                  ); */
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }

                  //retornar null significa que está tudo ok!
                  return null;
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
                onSaved: (value) {
                  _product.price = double.parse(value);
                  /* _product = Product(
                    title: _product.title,
                    price: double.parse(value),
                    description: _product.description,
                    id: null,
                    imageUrl: _product.imageUrl,
                    isFavorite: _product.isFavorite,
                  ); */
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Please enter a valide number';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Please enter a value gratear then zero';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _product.description = value;
                  /* _product = Product(
                    title: _product.title,
                    price: _product.price,
                    description: value,
                    id: null,
                    imageUrl: _product.imageUrl,
                    isFavorite: _product.isFavorite,
                  ); */
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description.';
                  }

                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {
                        _product.imageUrl = value;
                        /* _product = Product(
                          title: _product.title,
                          price: _product.price,
                          description: _product.description,
                          id: null,
                          imageUrl: value,
                          isFavorite: _product.isFavorite,
                        ); */
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a image url.';
                        }

                        if (!_validateUrl(value)) {
                          return 'Please enter a valid URL';
                        }

                        return null;
                      },
                      //initialValue: 'teste',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
