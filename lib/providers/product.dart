import 'package:flutter/foundation.dart';
import '../providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  void _setFavValue(bool favVal) {
    isFavourite = favVal;
    notifyListeners();
  }

  Future<void> toggleFavStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =  Uri.parse(
        "https://flutterdemo-53bf5-default-rtdb.firebaseio.com/add_products/$id.json");
    try {
      final response = await http.patch(url,body: json.encode({
      'isFavourite' : isFavourite,
      }));
      if(response.statusCode >= 400) {
        print(response.statusCode);
        _setFavValue(oldStatus);
      }
    }
    catch(error) {
      print('$error errorsss');
      _setFavValue(oldStatus);
    }
  }

}

