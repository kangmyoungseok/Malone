import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CategoryProvider extends ChangeNotifier{

  late List<dynamic> categoryList;

  loadCategory() async{
    String dataPath = 'lib/assets/item.json';
    print("parse json from $dataPath");
    rootBundle.loadString(dataPath).then(
        (jsonStr){
          var jsonData = jsonDecode(jsonStr);
          categoryList = jsonData['datas'];
        }
    );
  }

}