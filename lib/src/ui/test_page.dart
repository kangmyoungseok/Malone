import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';
import '../provider/controller_provider.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("임시 테스트 페이지"),
      ),
      body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  ControllerProvider _controller = Provider.of<ControllerProvider>(context,listen: false);
                  Item item = Item(
                      name: '베이글',
                      count: 1,
                      enrollDate: '2022-02-11',
                      expireDate: '2022-02-11',
                      itemCategory: '빵류',
                      memo: '',
                      notificationDate: '2022-02-12',
                      storageCategory: '냉장',
                  );
                  _controller.insertItem(item);
                },
                child: const Text("냉장"),
              ),
              ElevatedButton(
                onPressed: (){
                  ControllerProvider _controller = Provider.of<ControllerProvider>(context,listen: false);
                  Item item = Item(
                      name: '베이글',
                      count: 1,
                      enrollDate: '2022-02-11',
                      expireDate: '2022-02-11',
                      itemCategory: '빵류',
                      memo: '',
                      notificationDate: '2022-02-12',
                      storageCategory: '냉동',
                  );
                  _controller.insertItem(item);
                },
                child: const Text("냉동"),
              ),
              ElevatedButton(
                onPressed: (){
                  ControllerProvider _controller = Provider.of<ControllerProvider>(context,listen: false);
                  Item item = Item(
                      name: '베이글',
                      count: 1,
                      enrollDate: '2022-02-11',
                      expireDate: '2022-02-11',
                      itemCategory: '빵류',
                      memo: '',
                      notificationDate: '2022-02-12',
                      storageCategory: '실온',
                  );
                  _controller.insertItem(item);
                },
                child: const Text("실온"),
              ),
            ],
          )
      ),
    );
  }
}
