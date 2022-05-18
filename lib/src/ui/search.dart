import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './detail.dart';
import '../models/search_model.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //final suggestions = ["검색", "기능", "따라하기", "힘들어", "살려줘"];

  List<SearchModel> _list = []; //fetched data
  List<SearchModel> _search = []; //searched data
  bool _onLoading = false;

  /* 검색 바 컨트롤러 */
  final TextEditingController searchController = TextEditingController();

  /* 텍스트 입력과 동시에 state 발생 */
  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    /* 해쉬태그로 검색시 */
    if (text.startsWith('#')) {
      text = text.substring(1);
      _list.forEach((tagItem) {
        if (tagItem.flavors
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          _search.add(tagItem);

          print(tagItem.flavors.toString() + ", "); //출력되는지확인
        }
      });
      /* 이름으로 검색 시 */
    } else {
      _list.forEach((nameItem) {
        if (nameItem.name
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          _search.add(nameItem);

          print(nameItem.name.toString() + ", "); //출력되는지확인
        }
      });
    }

    setState(() {});
  }

  late Future<List> searchItem;
  @override
  void initState() {
    super.initState();
    /* 메인 페이지 API fetching */
    searchItem = fetchSearchItem();

    searchItem.then((value) {
      _list = value as List<SearchModel>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
          toolbarHeight: 44,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: buildSearchBar(context, searchController, onSearch),
          leadingWidth: 60,
          actions: []),
      body: searchController.text == ''
          ? buildSuggestion(context)
          : searchController.text.startsWith('#')
              ? buildResultByTag(context, _search, searchController.text)
              : buildResultByName(context, _search, searchController.text),
    );
  }
}

@override
Widget buildSearchBar(
    BuildContext context, TextEditingController controller, dynamic onSearch) {
  return CupertinoTextField(
      controller: controller,
      placeholder: "원하는 맛 또는 재료를 검색해보세요!",
      placeholderStyle: const TextStyle(color: Color(0xffa9a9a9)),
      padding: const EdgeInsets.fromLTRB(0, 6, 11, 6),
      onChanged: onSearch,
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
      ));
}

@override
Widget buildSuggestion(BuildContext context) {
  return SingleChildScrollView(
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
    ),
  );
}

/* 이름으로 검색할 시 뜨는 아이템 */
@override
Widget buildResultByName(
    BuildContext context, List<SearchModel> list, String text) {
  final int len = list.length;
  List<Widget> ret = [];
  String cocktailName;
  int textIndex;

  for (int i = 0; i < len; ++i) {
    cocktailName = list[i].name.toString();
    textIndex = cocktailName.indexOf(text);
    if (textIndex != -1) {
      ret.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    DetailPage(cocktailId: list[i].id.toString()),
              ));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          decoration: BoxDecoration(
              border: i < len - 1
                  ? const Border(bottom: BorderSide(color: Color(0xff212121)))
                  : null),
          child: RichText(
              text: TextSpan(
                  text: cocktailName.substring(0, textIndex),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                  children: [
                /* 키워드 색상 하이라이트 */
                TextSpan(
                    text: cocktailName.substring(
                        textIndex, textIndex + text.length),
                    style: TextStyle(color: Colors.white.withOpacity(1.0))),
                TextSpan(
                  text: cocktailName.substring(
                      textIndex + text.length, cocktailName.length),
                ),
              ])),
        ),
      ));
    }
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [for (int i = 0; i < ret.length; ++i) ret[i]],
    ),
  );
}

/* 해쉬태그로 검색할 시 뜨는 아이템 */
@override
Widget buildResultByTag(
    BuildContext context, List<SearchModel> list, String text) {
  final int len = list.length;
  List<Widget> ret = [];
  String replacedText = text.replaceAll('#', '');
  String cocktailName;
  String flavorRaw;
  List<String> flavorSplit;
  int textIndex;
  int flavorLen;

  for (int i = 0; i < len; ++i) {
    cocktailName = list[i].name.toString();
    flavorRaw = list[i].flavors.toString();
    flavorSplit = list[i].flavors.toString().split(', ');
    flavorLen = flavorSplit.length > 2 ? 2 : flavorSplit.length;
    if (flavorRaw.contains(replacedText)) {
      ret.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) =>
                      DetailPage(cocktailId: list[i].id.toString()),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xff1e1e1e),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.topCenter,
                child: Image(
                    image: AssetImage('asset/images/c.png'), fit: BoxFit.cover),
              ),

              /* 이미지
              Container(
                alignment: Alignment.topCenter,
                child: Image.network(list[i].img.toString(), fit: BoxFit.cover),
              ),
              */
              Container(
                  padding: const EdgeInsets.fromLTRB(12, 13, 12, 12),
                  child: Text(
                    cocktailName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < flavorLen; ++i)
                          buildTagItem(
                              context: context,
                              text: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold),
                                      children: [
                                    /* 태그 별 키워드 색상 하이라이트 부분 */

                                    if (flavorSplit[i].contains(replacedText))
                                      (TextSpan(children: [
                                        TextSpan(
                                          text: flavorSplit[i].substring(
                                              0,
                                              flavorSplit[i]
                                                  .indexOf(replacedText)),
                                        ),
                                        /* 키워드 색상 하이라이트 */
                                        TextSpan(
                                            text: flavorSplit[i].substring(
                                                flavorSplit[i]
                                                    .indexOf(replacedText),
                                                flavorSplit[i]
                                                        .indexOf(replacedText) +
                                                    replacedText.length),
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(1.0))),
                                        TextSpan(
                                          text: flavorSplit[i].substring(
                                              flavorSplit[i]
                                                      .indexOf(replacedText) +
                                                  replacedText.length,
                                              flavorSplit[i].length),
                                        ),
                                      ]))
                                    else
                                      TextSpan(
                                          text: flavorSplit[i],
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              fontWeight: FontWeight.bold)),
                                  ])),
                              origtext: flavorSplit[i]),
                      ]))
            ]),
          ),
        ),
      );
    }
  }

  return GridView(
    padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
    children: [for (int i = 0; i < ret.length; ++i) ret[i]],
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 220,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12),
  );
}

/* 태그 블록 위젯 */
@override
Widget buildTagItem(
    {required BuildContext context,
    required RichText text,
    required String origtext}) {
  Color getColor(String name) {
    if ("상큼한".contains(name)) {
      return const Color(0xffDA6C31).withOpacity(0.4);
    } else if ("달콤한".contains(name)) {
      return const Color(0xffF08FA4).withOpacity(0.4);
    } else if ("청량한".contains(name)) {
      return const Color(0xffABEDE1).withOpacity(0.4);
    }
    return const Color(0xffeeeeee).withOpacity(0.4);
  }

  return Container(
      decoration: BoxDecoration(
        color: getColor(origtext),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.fromLTRB(11, 7, 11, 7),
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: text);
}
