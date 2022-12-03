import 'package:flutter/material.dart';

class ShoppingProvider extends ChangeNotifier{

  // ['롤빵','상그리아','맥주','감','당근'] 이런식으로 장바구니 데이터들이 들어감
  List<String> productList = [];

  // ShoppingProvider.add('롤빵');
  add(String product){
    productList.add(product);
    notifyListeners();
  }

  // ShoppingProvider.remove(3) // 3번째 인덱스에 존재하는 자료 삭제
  remove(int idx){
    productList.removeAt(idx);
    notifyListeners();
  }
}