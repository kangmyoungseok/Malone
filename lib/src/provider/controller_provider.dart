import 'package:flutter/material.dart';
import '../interface/controller.dart';
import '../model/item.dart';

class ControllerProvider extends ChangeNotifier{
  late Controller _controller;

  init(context){
    print("init controllerProvider");
    _controller = Controller();
    _controller.initController(context);
  }

  insertItem(Item item){
    _controller.insertItem(item);
  }
}