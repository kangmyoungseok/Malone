import 'package:flutter/material.dart';
import 'package:term_proj2/src/model/item.dart';

// 냉장 품목
class NormalProvider extends ChangeNotifier {
  Map<String, List<Item>> itemList = {};
  int total = 0;

  initList(List<dynamic> datas){
    for(var data in datas){
      itemList[data["name"]] = [];
    }
  }

  insertItem(Item item) {
    print('insertItem : ${item.name}');
    itemList[item.itemCategory]!.add(item);
    total++;
    notifyListeners();
  }

  removeItem(Item item){
    itemList[item.itemCategory]?.removeWhere((element) => element.name == item.name && element.count == item.count);
    notifyListeners();
  }

}
