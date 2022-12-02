import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';
import '../provider/controller_provider.dart';
import 'home.dart';
import '../styles.dart';

class AddItemPage extends StatefulWidget {
  final String name;
  final String itemCategory;
  final String img;
  const AddItemPage({Key? key, required String this.itemCategory, required String this.name, required String this.img }) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final double _kItemExtent = 32.0;

  late String img;
  late String itemCategory;
  int selectedStorage = 0;
  int selectedItemCategory = 0;
  String name = "";
  String enrollDate = "";
  DateTime enrollDateTime = DateTime.now();
  String expireDate = "";
  DateTime expireDateTime = DateTime.now();
  String notificationDate = "";
  DateTime notificationDateTime = DateTime.now();
  bool whetherNotify = true;
  int count = 0;
  String memo = "";
  TextEditingController _nameController = TextEditingController();

  Item newItem = Item(
    itemCategory: "빵류",
    name: "",
    enrollDate: DateFormat('yyyy/MM/dd').format(DateTime.now()),
    expireDate: DateFormat('yyyy/MM/dd').format(DateTime.now()),
    count: 0,
    memo: "",
    notificationDate: DateFormat('yyyy/MM/dd').format(DateTime.now()),
    storageCategory: "냉장",
    image: '',
  );

  List<String> storages = [
    '냉장',
    '냉동',
    '실온',
  ];

  List<String> itemCategories = [
    "빵류",
    "조미료",
    "유제품",
    "디저트",
    "요리",
    "음료",
    "과일",
    "기타",
  ];


  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.name);
    print(widget.itemCategory);
    selectedItemCategory = itemCategories.indexOf(widget.itemCategory);
    _nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text("새로운 식품"),
        foregroundColor: AppColor.onPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [

            Image.asset(widget.img),
            const Text(
              '보관장소',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '보관 장소를 선택해 주세요.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  // Display a CupertinoPicker with list of fruits.
                  onPressed: () => _showDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          selectedStorage = selectedItem;
                          // newItem.storageCategory = storages[selectedItem];
                        });
                      },
                      children:
                      List<Widget>.generate(storages.length, (int index) {
                        return Center(
                          child: Text(
                            storages[index],
                          ),
                        );
                      }),
                    ),
                  ),
                  // This displays the selected fruit name.
                  child: Text(
                    storages[selectedStorage],
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black // AppColor.onPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),

            const Text(
              '카테고리',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '제품 카테고리를 선택해 주세요.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  // Display a CupertinoPicker with list of fruits.
                  onPressed: () => _showDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          selectedItemCategory = selectedItem;
                          newItem.itemCategory = itemCategories[selectedItem];
                        });
                      },
                      children: List<Widget>.generate(itemCategories.length,
                              (int index) {
                            return Center(
                              child: Text(
                                itemCategories[index],
                              ),
                            );
                          }),
                    ),
                  ),
                  // This displays the selected fruit name.
                  child: Text(
                    itemCategories[selectedItemCategory],
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black // AppColor.onPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),

            const Text(
              '제품 이름',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '제품 이름을 입력해 주세요.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _nameController,
              onChanged: (text) {
                setState(() {
                  _nameController.text = text;
                  newItem.name = text;
                });
              },
              decoration: InputDecoration(
                labelText: 'name',
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColor.onPrimaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),

            const Text(
              '등록 날짜',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '등록 날짜를 선택해 주세요.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              // Display a CupertinoDatePicker in date picker mode.
              onPressed: () => _showDialog(
                CupertinoDatePicker(
                  initialDateTime: enrollDateTime,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  // This is called when the user changes the date.
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      enrollDateTime = newDate;
                      enrollDate =
                      '${enrollDateTime.year}/${enrollDateTime.month}/${enrollDateTime.day}';
                      newItem.enrollDate =
                      '${enrollDateTime.year}/${enrollDateTime.month}/${enrollDateTime.day}';
                    });
                  },
                ),
              ),
              // In this example, the date value is formatted manually. You can use intl package
              // to format the value based on user's locale settings.
              child: Text(
                '${enrollDateTime.year}/${enrollDateTime.month}/${enrollDateTime.day}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '유통기한 만료 날짜',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '유통기한 만료 날짜를 선택해 주세요.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
              // Display a CupertinoDatePicker in date picker mode.
              onPressed: () => _showDialog(
                CupertinoDatePicker(
                  initialDateTime: expireDateTime,
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  // This is called when the user changes the date.
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      expireDateTime = newDate;
                      expireDate =
                      '${expireDateTime.year}/${expireDateTime.month}/${expireDateTime.day}';
                      newItem.expireDate =
                      '${expireDateTime.year}/${expireDateTime.month}/${expireDateTime.day}';
                    });
                  },
                ),
              ),
              // In this example, the date value is formatted manually. You can use intl package
              // to format the value based on user's locale settings.
              child: Text(
                '${expireDateTime.year}/${expireDateTime.month}/${expireDateTime.day}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '알림 날짜',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '알림을 받을 날짜를 선택해 주세요.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  // Display a CupertinoDatePicker in date picker mode.
                  onPressed: () => _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: notificationDateTime,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This is called when the user changes the date.
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          notificationDateTime = newDate;
                          notificationDate =
                          '${notificationDateTime.year}/${notificationDateTime.month}/${notificationDateTime.day}';
                          newItem.notificationDate =
                          '${notificationDateTime.year}/${notificationDateTime.month}/${notificationDateTime.day}';
                        });
                      },
                    ),
                  ),
                  // In this example, the date value is formatted manually. You can use intl package
                  // to format the value based on user's locale settings.
                  child: Text(
                    '${notificationDateTime.year}/${notificationDateTime.month}/${notificationDateTime.day}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                IconButton(
                  icon: whetherNotify
                      ? const Icon(Icons.alarm_on)
                      : const Icon(Icons.alarm_off),
                  onPressed: () {
                    setState(() {
                      whetherNotify = !whetherNotify;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '제품 수량',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '제품 수량을 입력해 주세요.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (text) {
                setState(() {
                  newItem.count = int.parse(text);
                });
              },
              decoration: InputDecoration(
                labelText: 'amount',
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColor.onPrimaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '메모란',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              '추가 메모란입니다.',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 116, 113, 149),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (text) {
                setState(() {
                  newItem.memo = text;
                });
              },
              decoration: InputDecoration(
                labelText: 'memo',
                labelStyle: const TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: AppColor.onPrimaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50, //height of button
              width: double.infinity, //width of button equal to parent widget
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.onPrimaryColor,

                  // textColor: Colors.white,
                ),
                onPressed: () {
                  if (whetherNotify == false) {
                    setState(() {
                      newItem.notificationDate = null;
                    });
                  }

                  if (selectedStorage == 0) {
                    newItem.storageCategory = "냉장";
//                    newItem.storageSubCategory = "냉장";
                  } else if (selectedStorage == 1) {
                    newItem.storageCategory = "냉동";
//                    newItem.storageSubCategory = "냉동";
                  } else if (selectedStorage == 2) {
                    newItem.storageCategory = "실온";
//                    newItem.storageSubCategory = "실온";
                  } else {
                    setState(() {
                      newItem.storageCategory = storages[selectedStorage];
                    });
                  }

                  print(newItem.storageCategory);
//                  print(newItem.storageSubCategory);
                  print(newItem.itemCategory);
                  print(newItem.name);
                  print(newItem.enrollDate);
                  print(newItem.expireDate);
                  print(newItem.notificationDate);
                  print(newItem.count);
                  print(newItem.memo);

                  /* newItem을 데이터 전송 -> LateInitializationError 해결해야 함.*/

                  ControllerProvider _controller =
                  Provider.of<ControllerProvider>(context, listen: false);
                  _controller.insertItem(newItem);


                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const MainPage()),
                          (route) => false);
                },
                child: const Text("등록하기"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}