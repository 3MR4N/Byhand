import 'package:flutter/foundation.dart';

class FavoriteItem {
  final String id;
  final String name;
  final String image;
  final double price;

  FavoriteItem({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.price,
  });
}

class Favorite with ChangeNotifier {
  Map<String, FavoriteItem> _items = {};

  Map<String, FavoriteItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid, String name, double price, String image) {
    if (_items.containsKey(pdtid)) {
      removeItem(pdtid);
    } else {
      _items.putIfAbsent(
          pdtid,
          () => FavoriteItem(
                name: name,
                id: DateTime.now().toString(),
                image: image,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  bool iconFav(String pdtid) {
    if (_items.containsKey(pdtid)) {
      return true;
    } else {
      return false;
    }
    notifyListeners();
  }
}
