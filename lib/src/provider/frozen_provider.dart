import 'package:flutter/material.dart';
import 'package:term_proj2/src/model/item.dart';

// 냉장 품목
class FrozenProvider extends ChangeNotifier{
  Map<String,List<dynamic>> itemList = {};


  // 각각의 카테고리별로 빈 배열을 만든다.
  // itemList['빵류'] = [], itemList['조미료'] = [] ..
  initList(List<dynamic> datas){
    for(var data in datas){
      itemList[data["name"]] = [];
    }
  }

  insertItem(Item item){
    print('insertItem : ${item.name}');
    itemList[item.itemCategory]!.add(item);
    notifyListeners();
  }
}