import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/provider/frozen_provider.dart';
import 'package:term_proj2/src/provider/normal_provider.dart';
import 'package:term_proj2/src/provider/refrigerated_provider.dart';
import 'package:term_proj2/src/styles.dart';
import 'package:term_proj2/src/ui/item_info_page.dart';
import 'package:term_proj2/src/ui/search_page.dart';
import 'package:term_proj2/src/ui/shopping_list_page.dart';

import '../model/item.dart';
import 'add_item_page.dart';
import 'category_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int screenIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Home(),
//      const AddItemPage(),
      const CategoryPage(),
      const ShoppingListPage(),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(screenIndex),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,
                  color: AppColor.onPrimaryColor // Colors.blue,
                  ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined,
                  color: AppColor.onPrimaryColor // Colors.blue,
                  ),
              label: 'addItem'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined,
                  color: AppColor.onPrimaryColor // Colors.blue,
                  ),
              label: 'list'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchText = TextEditingController();
  late FrozenProvider _frozenProvider;
  late NormalProvider _normalProvider;
  late RefrigeratedProvider _refrigeratedProvider;


  @override
  void didChangeDependencies() {
    print("home : didChangeDep");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _frozenProvider = context.read<FrozenProvider>();
    _normalProvider = context.read<NormalProvider>();
    _refrigeratedProvider = context.read<RefrigeratedProvider>();
  }

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBar(),
        body: Center(
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              _tabBarViewItem(Icons.dns_rounded, '냉장 물품'),
              _tabBarViewItem(Icons.ac_unit_outlined, '냉동 물품'),
              _tabBarViewItem(Icons.eco, '실온 물품'),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(146),
      child: Padding(
        padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: _boxDecoration(),
              child: SafeArea(
                child: Column(
                  children: [
                    _topBar(),
                    const SizedBox(height: 15),
                    //_searchBox(),
                    //const SizedBox(height: 19),
                    _tabBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), top: Radius.circular(20)),
      color: AppColor.primaryColor,
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.home,
              color: AppColor.onPrimaryColor,
            ),
            Text(
              '  Malone ',
              style: TextStyle(fontSize: 20, color: AppColor.onPrimaryColor),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              child: const Icon(
                Icons.search,
                color: AppColor.onPrimaryColor,
              ),
              onTap: () {
                print("search 클릭");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: const Icon(
                Icons.logout,
                color: AppColor.onPrimaryColor,
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
/*                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShoppingListPage()));
                print("장바구니 클릭");*/
              },
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: const Icon(
                Icons.more_vert,
                color: AppColor.onPrimaryColor,
              ),
              onTap: () {
                print("설정 클릭");
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _tabBar() {
    return TabBar(
      labelPadding: const EdgeInsets.all(0),
      labelColor: AppColor.onPrimaryColor,
      indicatorColor: AppColor.onPrimaryColor,
      indicatorWeight: 4,
      unselectedLabelColor: const Color(0xff777777),
      onTap: (value) {
        setState(() {
          current = value;
        });
      },
      tabs: [
        Tab(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(5),
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              color: current == 0 ? AppColor.primaryColor : Colors.white54,
              borderRadius: current == 0
                  ? BorderRadius.circular(15)
                  : BorderRadius.circular(30),
              border: current == 0 ? null : null,
            ),
            child: current == 0
                ? const Center(
                    child: Text(
                    "냉장",
                    style: TextStyle(fontSize: 16),
                  ))
                : const Center(child: Icon(Icons.dns_rounded)),
          ),
        ),
        Tab(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(5),
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              color: current == 1 ? AppColor.primaryColor : Colors.white54,
              borderRadius: current == 1
                  ? BorderRadius.circular(15)
                  : BorderRadius.circular(30),
              border: current == 1 ? null : null,
            ),
            child: current == 1
                ? const Center(
                    child: Text(
                    "냉동",
                    style: TextStyle(fontSize: 16),
                  ))
                : const Center(child: Icon(Icons.ac_unit_rounded)),
          ),
        ),
        Tab(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(5),
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              color: current == 2 ? AppColor.primaryColor : Colors.white54,
              borderRadius: current == 2
                  ? BorderRadius.circular(15)
                  : BorderRadius.circular(30),
              border: current == 2 ? null : null,
            ),
            child: current == 2
                ? Center(
                    child: const Text(
                    "실온",
                    style: TextStyle(fontSize: 16),
                  ))
                : Center(child: Icon(Icons.eco_rounded)),
          ),
        ),
      ],
    );
  }

  Widget _tabBarViewItem(IconData icon, String name) {
    Map<String, List<dynamic>> itemList;
    int total = 0;
    if (name == '냉장 물품') {
      itemList = context.watch<RefrigeratedProvider>().itemList;
      total = context.read<RefrigeratedProvider>().total;
    } else if (name == "냉동 물품") {
      itemList = context.watch<FrozenProvider>().itemList;
      total = context.read<FrozenProvider>().total;
    } else {
      // "실온 물품"
      itemList = context.watch<NormalProvider>().itemList;
      total = context.read<NormalProvider>().total;
    }

    if (total == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 40),
          ),
        ],
      );
    } else {
      // total이 >0 이면, 리스트
      int category_num = 0;
      List categoryList = [];
      for (var category in itemList.keys) {
        if (itemList[category]!.isNotEmpty) {
          // 공백이 아닌 카테고리 수 출력
          category_num++;
          categoryList.add(category);
        }
      }

      // 이 아래 부분 코드 수정
      return Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: ListView.separated(
            itemBuilder: (context, categoryIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${categoryList[categoryIndex]} (${itemList[categoryList[categoryIndex]]!.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemBuilder: (context, itemIndex) {
                      Item item =
                          itemList[categoryList[categoryIndex]]![itemIndex];
                      print(itemList[categoryList[categoryIndex]]![itemIndex]
                          .image);
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ItemInfoPage(item: item),));
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF2F4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 80,
                              child: Row(
                                children: [
                                  Container(
                                    color: const Color(0xFFEFF2F4),
                                    width: 20,
                                    height: 50,
                                  ),
                                  Container(
                                    width: 30,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF2F4),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          itemList[categoryList[categoryIndex]]![
                                                  itemIndex]
                                              .image,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: const Color(0xFFEFF2F4),
                                    width: 20,
                                    height: 50,
                                  ),
                                  Container(
                                    height: 50,
                                    color: const Color(0xFFEFF2F4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${itemList[categoryList[categoryIndex]]![itemIndex].name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          itemList[categoryList[categoryIndex]]![
                                                          itemIndex]
                                                      .notificationDate !=
                                                  null
                                              ? 'D - ${int.parse(DateTime.parse(itemList[categoryList[categoryIndex]]![itemIndex].notificationDate).difference(DateTime.now()).inDays.toString())}'
                                              : 'D - ${int.parse(DateTime.parse(itemList[categoryList[categoryIndex]]![itemIndex].expireDate).difference(DateTime.now()).inDays.toString())}',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: itemList[categoryList[categoryIndex]]!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 2,
              );
            },
            itemCount: category_num),
      );
    }
  }
}
