import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/provider/category_provider.dart';
import 'package:term_proj2/src/provider/controller_provider.dart';
import 'package:term_proj2/src/provider/frozen_provider.dart';
import 'package:term_proj2/src/provider/normal_provider.dart';
import 'package:term_proj2/src/provider/refrigerated_provider.dart';
import 'package:term_proj2/src/ui/home.dart';
import 'package:term_proj2/src/ui/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late CategoryProvider _categoryProvider;

  Widget _splashLoadingWidget(
      BuildContext context, AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return const Text("Error!!");
    } else if (snapshot.hasData) {
      _initializeProvider(context);
      return Home();
    } else {
      return const IntroScreen();
    }
  }

  _futureFunc() async {
    // 초기화 해야 하는 함수들 여기다가 추가
    await _categoryProvider.loadCategory();
    await Future.delayed(const Duration(seconds: 10));
    return "Intro Completed";
  }

  _initializeProvider(context) {
    // provider들의 변수 모두 초기화
    List<dynamic> datas =
        Provider.of<CategoryProvider>(context, listen: false).categoryList;
    Provider.of<FrozenProvider>(context, listen: false).initList(datas);
    Provider.of<NormalProvider>(context, listen: false).initList(datas);
    Provider.of<RefrigeratedProvider>(context, listen: false).initList(datas);
    //context.read<FrozenProvider>().initList(datas);
    //context.read<NormalProvider>().initList(datas);
    //context.read<RefrigeratedProvider>().initList(datas);
  }

  // Future함수에서 provider들을 초기화 시켜야 할텐데,,
  @override
  Widget build(BuildContext context) {
    print("build: main.dart");
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FrozenProvider()),
          ChangeNotifierProvider(create: (context) => NormalProvider()),
          ChangeNotifierProvider(create: (context) => RefrigeratedProvider()),
          ChangeNotifierProvider(create: (context) => ControllerProvider()),
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Term Project',
          debugShowCheckedModeBanner: false,
          home: Builder(builder: (context) {
            print("build: main/builder");
            _categoryProvider =
                Provider.of<CategoryProvider>(context, listen: false);
            // provider 추가하면 여기다가 하면 된다.
            return FutureBuilder(
              future: _futureFunc(),
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: _splashLoadingWidget(context, snapshot),
                );
              },
            );
          }),
        ));
  }
}
