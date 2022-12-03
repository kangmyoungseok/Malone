import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/provider/shopping_provider.dart';

import '../styles.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<Shopping> shoppingList = [];

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
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
              child: SizedBox(

              ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.onPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          // 모달? 같은 화면 띄워서 추가하기 하자
        },
      ),
    );
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
}
