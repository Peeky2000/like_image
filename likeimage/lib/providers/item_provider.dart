import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:likeimage/model/item_model.dart';

class ItemProvider extends ChangeNotifier {
   List<Item> _items = [];
   int _countItemFavorite = 0;

  List<Item> get items {
    //copy
    return [..._items];
  }

  int get countItemFavorite{
    return _countItemFavorite;
  }

  List<Item> showItemFavorite () {
    List<Item> data = _items.where((element) => element.isFavorite).toList();
    return data.isEmpty ? [] : data;
  }

  void handleCountItem(){
    _countItemFavorite = _items.where((element) => element.isFavorite).length;
    notifyListeners();
  }

  void readJson() async {
    final String response = await rootBundle.loadString('assets/json/items.json');
    final parsedData = await json.decode(response);
    List<Item> listData = List<Item>.from(
        parsedData.map((data) => Item.fromJson(jsonEncode(data))));
    _items = listData;
    notifyListeners();
  }
}
