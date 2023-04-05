import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String prodId, double price, String title) {
    if (_items.containsKey(prodId)) {
      _items.update(prodId, (existedCardItem) =>
          CartItem(id: existedCardItem.id,
              title: existedCardItem.title,
              quantity: existedCardItem.quantity + 1,
              price: existedCardItem.price));
    } else {
      _items.putIfAbsent(prodId, () =>
          CartItem(id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (!_items.containsKey(prodId)) {
      return;
    }
    if ((_items[prodId]?.quantity ?? 0) > 1) {
      _items.update(prodId, (existingCardItem) =>
          CartItem(id: existingCardItem.id,
              title: existingCardItem.title,
              quantity: existingCardItem.quantity - 1,
              price: existingCardItem.price));
    } else{
      _items.remove(prodId);
    }
    notifyListeners();
  }
}
