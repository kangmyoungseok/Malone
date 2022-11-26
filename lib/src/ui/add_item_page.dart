import 'package:flutter/material.dart';

import '../styles.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text("새로운 식품"),
        foregroundColor: AppColor.onPrimaryColor,
      ),
    );
  }
}
