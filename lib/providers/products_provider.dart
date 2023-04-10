import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exceptions.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavOnly = false;

  List<Product> get items {
    // if(_showFavOnly) {
    //   return _items.where((prod) => prod.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((prod) => prod.isFavourite).toList();
  }
  final url = Uri.parse(
      "https://flutterdemo-53bf5-default-rtdb.firebaseio.com/add_products.json");
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(url);
      print('${json.decode(response.body)},responseeget');
      final List<Product> loadedPRoducts = [];
      final extractedData = json.decode(response.body) as Map<String,dynamic> ;
      if(extractedData == null ) {
        return;
      }
      extractedData.forEach((key, value) {
        loadedPRoducts.add(
          Product(id: key, title: value['title'], description: value['description'], price: value['price'], imageUrl: value['imageUrl'])
        );
      });
      _items = loadedPRoducts;
      notifyListeners();
    } catch(error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    // final String url =  "https://flutterdemo-53bf5-default-rtdb.firebaseio.com/add_products.json";

    try {
      final response = await http
          .post(url,
          body: json.encode({
            // 'id' : newProduct.id,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          }));
      print(json.decode(response.body));
      final newProduct = Product(
        // id: DateTime.now().toString(),
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print('$error,errorr');
      throw error;
    }




  }

  // void showFavOnly() {
  //   _showFavOnly = true;
  //   notifyListeners();
  // }
  // void showAll() {
  //   _showFavOnly = false;
  //   notifyListeners();
  // }
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> updateProduct(String id, Product newProd) async {
    final url =  Uri.parse(
        "https://flutterdemo-53bf5-default-rtdb.firebaseio.com/add_products/$id.json");
    final prodId = _items.indexWhere((prod) => prod.id == id);
    if (prodId >= 0) {
      await http.patch(url,body: json.encode({
        'title': newProd.title,
        'description': newProd.description,
        'imageUrl' : newProd.imageUrl,
        'price' : newProd.price,
        'isFavourite': newProd.isFavourite,
      }));
      _items[prodId] = newProd;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async{
    // final url =  Uri.parse(
        // "https://flutterdemo-53bf5-default-rtdb.firebaseio.com/add_products/$id");  to check custom exceptions
    final url =  Uri.parse(
        "https://flutterdemo-53bf5-default-rtdb.firebaseio.com/add_products/$id.json");
    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
     Product? existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();
    final res = await http.delete(url);
      print(res.statusCode);
      final statusCode = res.statusCode;
      if(statusCode >= 400) {
        _items.insert(existingProdIndex, existingProd ?? Product(id: '', title: '', description: '', price: 23.23, imageUrl: ''));
        notifyListeners();
        throw HttpException('could not del prod');
      }
      existingProd = null;

  }

}
