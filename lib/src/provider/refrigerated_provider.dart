import 'package:flutter/material.dart';

import '../model/item.dart';

// 냉장 품목
class RefrigeratedProvider extends ChangeNotifier{
  Map<String,List<dynamic>> itemList = {};
  int total = 0;

  initList(List<dynamic> datas){
    for(var data in datas){
      itemList[data["name"]] = [];
    }
  }


  insertItem(Item item){
    print('insertItem : ${item.name}');
    itemList[item.itemCategory]!.add(item);
    total++;
    notifyListeners();
  }
}