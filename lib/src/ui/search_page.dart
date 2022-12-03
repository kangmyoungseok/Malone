import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/styles.dart';
import 'package:term_proj2/src/ui/item_info_page.dart';

import '../model/item.dart';
import '../provider/frozen_provider.dart';
import '../provider/normal_provider.dart';
import '../provider/refrigerated_provider.dart';
import 'dart:async';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();

  List<Item> totalItemList = [];
  List<Item> displayList = [];
  void updateList(String value) {
    // 검색 필터링을 수행할 함수.
    setState(() {
      displayList = totalItemList.where((element) => element.name!.contains(value)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, List<dynamic>> itemList1;
    totalItemList = [];
    itemList1 = context.read<RefrigeratedProvider>().itemList;
    for (var perCategoryItemList in itemList1.values) {
      for (var item in perCategoryItemList) {
        totalItemList.add(item);
      }
    }
    itemList1 = context.read<FrozenProvider>().itemList;
    for (var perCategoryItemList in itemList1.values) {
      for (var item in perCategoryItemList) {
        totalItemList.add(item);
      }
    }
    itemList1 = context.read<NormalProvider>().itemList;
    for (var perCategoryItemList in itemList1.values) {
      for (var item in perCategoryItemList) {
        totalItemList.add(item);
      }
    }
    displayList = List.from(totalItemList);
  }

  @override
  Widget build(BuildContext context) {
    // 화면에 표시할 리스트들을 저장
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(30)),
          Container(
            // color: AppColor.onPrimaryColor,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    onChanged: (value) {
                      updateList(value);
                    },
                    autofocus: true,
                    //controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.primaryColor,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                size: 20,
                                color: AppColor.onPrimaryColor,
                              ),
                              onPressed: () {
                              },
                            )
                          : Container(),
                      hintText: '검색',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context,index) => GestureDetector(
                  onTap: (){
                    Logger().d(displayList[index].name);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ItemInfoPage(item: displayList[index],),));
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: Image.asset(displayList[index].image),
                    title: Text(displayList[index].name),
                    trailing: Text(
                      displayList[index]
                          .notificationDate !=
                          null
                          ? 'D - ${int.parse(DateTime.parse(displayList[index].notificationDate!).difference(DateTime.now()).inDays.toString())}'
                          : 'D - ${int.parse(DateTime.parse(displayList[index].expireDate).difference(DateTime.now()).inDays.toString())}',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

          ),

        ],
      ),
    );
  }
}
