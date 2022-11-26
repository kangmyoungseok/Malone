import 'package:flutter/material.dart';
import 'package:term_proj2/src/styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchText = TextEditingController();

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), top: Radius.circular(20)),
      color: AppColor.primaryColor,
    );
  }

  Widget _searchBox() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: TextFormField(
            textAlign: TextAlign.start,
            controller: _searchText,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.primaryColor,
              prefixIcon: InkWell(
                child: const Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              suffixIcon: InkWell(
                child: const Icon(Icons.close),
                onTap: () {
                  _searchText.clear();
                },
              ),
              hintText: '보관 중인 식품을 검색하세요.',
              hintStyle: const TextStyle(color: Colors.black,fontSize: 18),
              contentPadding: const EdgeInsets.all(0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _searchBox()
    );
  }
}
