import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/provider/category_provider.dart';
import 'package:term_proj2/src/styles.dart';
import 'package:term_proj2/src/ui/add_item_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          leading: const Icon(
            Icons.category,
            color: AppColor.onPrimaryColor,
          ),
          title: const Text("카테고리"),
          foregroundColor: AppColor.onPrimaryColor,
        ),
        body: const Center(
          child: GridViewPanel(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GridViewPanel extends StatefulWidget {
  const GridViewPanel({Key? key}) : super(key: key);

  @override
  State<GridViewPanel> createState() => _GridViewPanelState();
}

class _GridViewPanelState extends State<GridViewPanel> {
  List<String> categories = ["bread", "condiments", "dairy", "desserts", "dishes", "drink", "etc", "fruits"];
  bool _offStage = true;
  int _clickedIdx = 0;

  @override
  Widget build(BuildContext context) {
    List<dynamic> datas = context.read<CategoryProvider>().categoryList;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories!.length, //item 개수
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1 / 1.3, //item 의 가로 1, 세로 1 의 비율
              mainAxisSpacing: 10, //수평 Padding
              crossAxisSpacing: 10, //수직 Padding
            ),
            itemBuilder: (BuildContext context, int index) {
              //item 의 반목문 항목 형성
              return InkWell(
                child: Column(
                  children: [
                    Image.asset(
                      "lib/assets/img/category/${categories.elementAt(index)}.png",
                    ),
                    const SizedBox(height: 5,),
                    Expanded(
                      child: Container(
                        height: 10,
                        alignment: Alignment.center,
                        child: Text(
                          datas[index]['name'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  setState(() {
                    if(_clickedIdx == index){
                      _offStage = !_offStage;
                    }else{
                      _offStage = false;
                      _clickedIdx = index;
                    }
                  });

                },
              );
            },
          ),
          const Divider(thickness: 2, color: AppColor.primaryColor,),
          Offstage(
            offstage: _offStage,
            child: Column(
              children: [
                const SizedBox(height: 10,),
                GridViewDetailedPanel(clickedIdx: _clickedIdx),
                // Text('${(context.read<CategoryProvider>().categoryList[_clickedIdx]['items'])}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GridViewDetailedPanel extends StatelessWidget {
  const GridViewDetailedPanel({Key? key, required this.clickedIdx}) : super(key: key);
  final clickedIdx;

  @override
  Widget build(BuildContext context) {
    final categoryName = context.read<CategoryProvider>().categoryList[clickedIdx]['category'];
    final categoryPrintName = context.read<CategoryProvider>().categoryList[clickedIdx]['name'];
    final itemList = context.read<CategoryProvider>().categoryList[clickedIdx]['items'];

    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: itemList.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1.3, //item 의 가로 1, 세로 1 의 비율
          mainAxisSpacing: 10, //수평 Padding
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index){
          if ( index == itemList.length) {
            String imgPath = "lib/assets/img/category/dish.png";
            return GestureDetector(
              onTap: (){
                var logger = Logger();
                logger.d('$categoryName');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddItemPage(itemCategory: categoryPrintName,name: '',img : imgPath))); // 페이지 이동을 위한 예시 코드입니다. 담당하시는 분이 수정하시면 됩니다.
              },
              child: Container(
                margin: const EdgeInsets.only(top:20,bottom: 20,left: 10,right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    '+',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          }
          return InkWell(
            child: Column(
              children: [
                Image.asset(
                    "lib/assets/img/items/" + categoryName + "/" + itemList[index]['img']
                ),
                const SizedBox(height: 5,),
                Expanded(
                  child: Container(
                    height: 10,
                    alignment: Alignment.center,
                    child: Text(
                      itemList[index]['name'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onTap: (){ // 세부 음식 이미지를 클릭 시 발생하는 이벤트를 관리하는 부분입니다.
              var logger = Logger();
              String imgPath = "lib/assets/img/items/$categoryName/${itemList[index]['img']}";
              logger.d('$categoryName ${itemList[index]['name']} ');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddItemPage(itemCategory: categoryPrintName,name: itemList[index]['name'],img: imgPath))); // 페이지 이동을 위한 예시 코드입니다. 담당하시는 분이 수정하시면 됩니다.
              /**
               * 1. 세부 음식 이미지를 눌러서 페이지를 이동시키는 부분입니다
               * 2. 세부 음식의 카테고리명은 {categoryName} 을 통해 불러옵니다
               * 3. 세부 음식의 음식명은 {itemList[index]['name']} 을 통해 불러옵니다
               * 4. 세부 음식의 이미지 파일 경로는 {"lib/assets/img/items/" + categoryName + "/" + itemList[index]['img']} 을 통해 불러옵니다
               * 5. 세부 음식의 정보를 불러오는 데 추가적인 문의가 있을 시 김상협 에게 물어봐주시면 됩니다
               * */
            },
          );
        }
    );
  }
}