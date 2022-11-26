import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_proj2/src/styles.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key, required this.tabController})
      : super(key: key);

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.primaryColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    //border: Border.all(color: Colors.white38, width: 2),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child : const Text("Malone"),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TabBar(
              controller: tabController,
              unselectedLabelColor:
                  Theme.of(context).colorScheme.onInverseSurface,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelColor: Theme.of(context).colorScheme.inversePrimary,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 5,
                      color: Theme.of(context).colorScheme.inversePrimary),
                  insets: EdgeInsets.symmetric(horizontal: 16)),
              indicatorWeight: 4,
              tabs: [
                Tab(text: '냉장'),
                Tab(text: '실온'),
                Tab(text: '냉동'),
                Tab(text: '추천'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
