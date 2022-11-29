import 'package:flutter/material.dart';
import 'dart:core';

class Item {
  String
      itemCategory; // item.json 파일에 있는 datas['name'] 부분을 입력 가능(빵류,조미료,유제품, .. )
  String name; // 해당 제품의 이름
  String enrollDate; // 등록일자
  String expireDate; // 유통기한 만료 일자
  String? notificationDate; // 며칠전에 알람 받을지
  int count; // 수량
  String memo; // 메모
  String storageCategory;   // 냉장냉동,실온
//  String? storageSubCategory; // 보관장소 -> 냉장,냉동,실온

  Item({
    required this.itemCategory,
    required this.name,
    required this.enrollDate,
    required this.expireDate,
    required this.count,
    required this.memo,
    /*required*/ this.notificationDate,
    required this.storageCategory,
//    this.storageSubCategory,
  });
}
