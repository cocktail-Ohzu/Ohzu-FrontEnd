import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final dummyData = ["진", "진 토닉", "진 토닉토닉 진", "토닉 진", "지아이조", "진 장인"];
  final suggestions = ["검색", "기능", "따라하기", "힘들어", "살려줘"];
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
          toolbarHeight: 44,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: buildSearchBar(context, searchController),
          leadingWidth: 60,
          actions: []),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 38),
                child: const Text(
                  "검색 추천 키워드",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 38),
                child: const Text(
                  "재료",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }
}

@override
Widget buildSearchBar(BuildContext context, TextEditingController controller) {
  return CupertinoTextField(
      controller: controller,
      placeholder: "원하는 맛 또는 재료를 검색해보세요!",
      placeholderStyle: const TextStyle(color: Color(0xffa9a9a9)),
      padding: const EdgeInsets.fromLTRB(0, 6, 11, 6),
      onChanged: null,
      style: const TextStyle(fontSize: 14, color: Color(0xffa9a9a9)),
      prefix: Container(
        child: const Icon(
          Icons.search,
          size: 20,
          color: Color(0xff7c7c7c),
        ),
        margin: const EdgeInsets.fromLTRB(11, 0, 6, 0),
      ),
      decoration: const BoxDecoration(
        color: Color(0xff1e1e1e),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      )

      /*  InputDecoration(
        focusColor: null,
        contentPadding: EdgeInsets.fromLTRB(11, 6, 6, 11),
        prefix: Container(
          child: Icon(
            Icons.search,
            size: 20,
            color: Color(0xff7c7c7c),
          ),
          margin: EdgeInsets.fromLTRB(0, 4, 6, 0),
        ),
        hintText: "원하는 맛이나 재료를 입력하세요!",
        hintStyle: TextStyle(fontSize: 14, color: Color(0xffa9a9a9)),
        filled: true,
        fillColor: Color(0xff1e1e1e),
      
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          borderSide: BorderSide(width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          borderSide: BorderSide(width: 0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          borderSide: BorderSide(width: 0),
        )), */
      );
}
