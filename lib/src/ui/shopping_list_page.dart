import 'package:flutter/material.dart';

import '../styles.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
