import 'package:flutter/material.dart';
import 'package:term_proj2/src/model/item.dart';

// 냉장 품목
class NormalProvider extends ChangeNotifier {
  Map<String, List<dynamic>> itemList = {};

  initList(List<dynamic> datas){
    for(var data in datas){
      itemList[data["name"]] = [];
    }
  }

  insertItem(Item item) {
    print('insertItem : ${item.name}');
    itemList[item.itemCategory]!.add(item);
    notifyListeners();
  }
}
