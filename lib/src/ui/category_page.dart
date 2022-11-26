import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/provider/category_provider.dart';
import 'package:term_proj2/src/styles.dart';
import 'package:term_proj2/src/ui/add_item_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    final _itemList = context.read<CategoryProvider>().categoryList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text("카테고리"),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 20,),
          Icon(Icons.more_vert)
        ],
        foregroundColor: AppColor.onPrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> AddItemPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColor.onPrimaryColor,
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemBuilder:(BuildContext context, int index){
          if (index == 0){
            // 큰 카테고리 그리기
            return GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: _itemList.map(
                (item) {
                  return GestureDetector(

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.all(5),
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                        color: 0 == 0 ? AppColor.primaryColor : Colors.white54,
                        borderRadius: 0 == 0
                            ? BorderRadius.circular(15)
                            : BorderRadius.circular(30),
                        border: 0 == 0
                            ? null
                            : null,
                      ),
                      child: 0==0
                          ? const Center(child: Text("냉장",style: TextStyle(fontSize: 16),))
                          : const Center(child: Icon(Icons.dns_rounded))
                      ,
                    ),
                  );
                },
              ).toList(),
            );
          }
          else{
            if(_isClicked){
            return GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: [],
            );
          }else{
              return Container();
            }
          }

        } , separatorBuilder: (BuildContext context, int index)=> const Divider(), itemCount: 2),
    );
  }
}
