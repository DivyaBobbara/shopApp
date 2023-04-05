import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';


class EditProductScreen extends StatefulWidget {
  static const routeName = "EditProductScreen";


  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  // const EditProductScreen({Key? key}) : super(key: key);
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlTextEditingController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: '',
      title: '',
      description: '',
      price: 0,
      imageUrl: '');
  var _isInit = true;
  var initVals = {
    'title': '',
    'description': '',
    'price' : '' ,
    'imageUrl': '',

  };

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlTextEditingController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final prodId = ModalRoute.of(context)?.settings.arguments as String?;
    if(_isInit) {
      if(prodId != null) {
        final product = Provider.of<Products>(context,listen: false).findById(prodId);
        _editedProduct = product;
        initVals = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
        };
        _imageUrlTextEditingController.text = _editedProduct.imageUrl;

      }

    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    // TODO: implement initState
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (
          (!_imageUrlTextEditingController.text.startsWith('http') && !_imageUrlTextEditingController.text.startsWith('https')) ||
          (!_imageUrlTextEditingController.text.endsWith('jpg')   && !_imageUrlTextEditingController.text.endsWith('png') && !_imageUrlTextEditingController.text.endsWith('jpeg'))) {
    return;
    }

    setState(() {

    });
  }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!(isValid!)) {
      return;
    }
    _form.currentState?.save();
    final prodId = ModalRoute.of(context)?.settings.arguments as String?;
    if ( prodId != null) {
      Provider.of<Products>(context,listen: false).updateProduct(_editedProduct.id,_editedProduct);
    } else {
      Provider.of<Products>(context,listen: false).addProduct(_editedProduct);
    }

   Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print(_imageUrlTextEditingController.text);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _form,
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(

            children: [
              TextFormField(
                initialValue: initVals['title'],
                decoration: InputDecoration(labelText: 'title'),
                // textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (val) {
                  _editedProduct = Product(id: _editedProduct.id,
                      title: val ?? '',
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                  isFavourite: _editedProduct.isFavourite);
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please provide val';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: initVals['price'],
                decoration: InputDecoration(labelText: 'price'),
                // textInputAction: TextInputAction.next,
                // keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                onSaved: (val) {
                  _editedProduct = Product(id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(val!),
                      imageUrl: _editedProduct.imageUrl,
                  isFavourite: _editedProduct.isFavourite);
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please provide price';
                  }
                  if (double.tryParse(val) == null) {
                    return 'Please provide valid num';
                  }
                  if (double.parse(val) <= 0) {
                    return 'Please provide  num greater 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: initVals['description'],
                decoration: InputDecoration(labelText: 'description'),
                // textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
                onFieldSubmitted: (_) {},
                onSaved: (val) {
                  _editedProduct = Product(id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: val as String,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                  isFavourite: _editedProduct.isFavourite);
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please provide desc';
                  }
                  if (val.length <= 10) {
                    return 'should be atleast 10 char';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                      child: _imageUrlTextEditingController.text.isEmpty
                          ? Text('Enter Url')
                          : FittedBox(

                        child: Image.network(
                            _imageUrlTextEditingController.text),
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                    child: TextFormField(
                      // initialValue: initVals['imageUrl'],
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlTextEditingController,
                      focusNode: _imageUrlFocusNode,
                      // onEditingComplete: () {
                      //   setState(() {
                      //
                      //   });
                      // },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (val) {
                        _editedProduct = Product(id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: val as String,
                        isFavourite: _editedProduct.isFavourite);
                      },
                      validator: (val) {
                        if(val!.isEmpty) {
                          return 'Please provide image url';
                        }
                        if (!val.startsWith('http')){
                          return 'enter valid url';
                        }
                        if(!val.endsWith('jpg') && !val.endsWith('png') && !val.endsWith('jpeg')) {
                          return 'provide valid image url';
                        }

                        return null;
                      },

                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
