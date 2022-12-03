import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/interface/controller.dart';
import 'package:term_proj2/src/provider/shopping_provider.dart';

import '../styles.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<Shopping> shoppingList = [];
  late TextEditingController controller;

  List<Shopping> selectedList = [];

  @override
  Widget build(BuildContext context) {
    shoppingList = context.watch<ShoppingProvider>().productList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text("장바구니"),
        leading: Icon(
          Icons.shopping_cart,
          color: AppColor.onPrimaryColor,
        ),
        foregroundColor: AppColor.onPrimaryColor,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: shoppingList.length,
                  itemBuilder: (context, index) {
                    // return item
                    return ShoppingItem(shoppingList[index].name,
                        shoppingList[index].isSelected, index);
                  },
                ),
              ),
              selectedList.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                          ),
                          child: Text(
                            '삭제',
                            style: TextStyle(
                                fontSize: 18, color: AppColor.onPrimaryColor),
                          ),
                          onPressed: () {
                            setState(() {
                              shoppingList.removeWhere(
                                  (element) => element.isSelected == true);
                              selectedList.clear();
                            });
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.onPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () async{
          // 모달? 같은 화면 띄워서 추가하기 하자
          await openDialog();
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget ShoppingItem(String name, bool isSelected, int index) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      tileColor: shoppingList[index].isSelected
          ? AppColor.primaryColor.withOpacity(0.5)
          : null,
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColor.onPrimaryColor)
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          shoppingList[index].isSelected = !shoppingList[index].isSelected;
          if (shoppingList[index].isSelected == true) {
            selectedList.add(Shopping(name, true));
          } else {
            selectedList.removeWhere(
                (element) => element.name == shoppingList[index].name);
          }
        });
      },
    );
  }

  Future<String?> openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('장바구니 추가'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: '장바구니에 추가할 물건 이름 입력'),
        ),
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text('추가')
          )
        ],
      ),
  );

  void submit(){
    context.read<ShoppingProvider>().add(controller.text);
    controller.clear();
    Navigator.pop(context);

  }
}
