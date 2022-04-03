import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './detail.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

/*

  List<String> _listName = [
    "진",
    "진 토닉",
    "토닉 진",
    "진진자라자라",
    "방탄소년단 진",
    "리그오브레전드 진 장인",
    "빌리진",
    "갓마더",
    "갓파더",
    "그래스호퍼",
    "깔루아 밀크",
    "데킬라 선라이즈",
    "로브 로이",
    "롱 아일랜드 아이스티",
    "마가리타",
    "마티니",
    "맨해튼",
    "모히토",
    "미도리사워",
    "미모사",
    "벨리니",
    "블랙 러시안",
    "블루 라군",
    "블루사파이어",
    "블루하와이",
    "섹스온더비치",
    "셜리 템플",
    "스크루 드라이버",
    "스팅거",
    "신데렐라",
    "애플 마티니",
    "엔젤스키스",
    "예거 밤",
    "올드패션드",
    "위스키 온 더 락",
    "준 벅",
    "진 토닉",
    "진 피즈",
    "쿠바 리브레",
    "키스 오브 파이어",
    "플로리다",
    "피나콜라다",
    "피치크러쉬"
  ];

*/
class CocktailItem {
  String? name;
  String? flavor;
  int? id;

  CocktailItem({this.name, this.flavor, this.id});
}

class _SearchState extends State<Search> {
  //final suggestions = ["검색", "기능", "따라하기", "힘들어", "살려줘"];

  List<CocktailItem> _list = [
    CocktailItem(name: "진 토닉", flavor: "상큼한, 청량한", id: 1),
    CocktailItem(name: "진", flavor: "상큼한, 쓴", id: 1),
    CocktailItem(name: "진진자라자라", flavor: "상큼, 달달한", id: 1),
    CocktailItem(name: "토닉 진", flavor: "상큼한, 청량한", id: 1),
    CocktailItem(name: "방탄소년단 진", flavor: "상큼한, 쓴", id: 1),
    CocktailItem(name: "리그오브레전드 진", flavor: "상큼, 달달한", id: 1),
    CocktailItem(name: "빌리진", flavor: "상큼한, 청량한", id: 1),
    CocktailItem(name: "마가리타", flavor: "상큼한, 쓴", id: 1),
    CocktailItem(name: "블루 하와이", flavor: "상큼, 달달한", id: 1),
    CocktailItem(name: "모히토", flavor: "상큼한, 청량한", id: 1),
    CocktailItem(name: "마가리타", flavor: "상큼한, 쓴", id: 1),
    CocktailItem(name: "블루 하와이", flavor: "상큼, 달달한", id: 1),
    CocktailItem(name: "미도리사워", flavor: "상큼한, 달달한", id: 1),
    CocktailItem(name: "이거 만드는거", flavor: "쓴, 쓴", id: 1),
    CocktailItem(name: "힘들었어요", flavor: "쓴, 로맨틱한", id: 1),
    CocktailItem(name: "ㅎ긓그후ㅡㄱ훅", flavor: "상큼한, 청량한", id: 1),
    CocktailItem(name: "오쥬화이팅", flavor: "상큼한, 청량한", id: 1),
    CocktailItem(name: "짱짱짱", flavor: "상큼한, 청량한", id: 1),
  ];

  List<CocktailItem> _search = [];
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
        if (tagItem.flavor
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          _search.add(tagItem);

          print(tagItem.flavor.toString() + ", "); //출력되는지확인
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

  @override
  void initState() {
    super.initState();
    /* 데이터 fetch 아래에다가 입력 예정 */
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

@override
Widget buildResultByName(
    BuildContext context, List<CocktailItem> list, String text) {
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
                builder: (context) => Detail(id: "1"),
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

@override
Widget buildResultByTag(
    BuildContext context, List<CocktailItem> list, String text) {
  final int len = list.length;
  List<Widget> ret = [];
  String replacedText = text.replaceAll('#', '');
  String cocktailName;
  String flavorRaw;
  List<String> flavorSplit;
  int textIndex;

  for (int i = 0; i < len; ++i) {
    cocktailName = list[i].name.toString();
    flavorRaw = list[i].flavor.toString();
    flavorSplit = list[i].flavor.toString().split(',');
    if (flavorRaw.contains(replacedText)) {
      ret.add(
        Container(
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
            Container(
                padding: const EdgeInsets.fromLTRB(12, 13, 12, 12),
                child: Text(
                  cocktailName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                      children: [
                    /* 태그 별 키워드 색상 하이라이트 부분 */
                    for (int i = 0; i < flavorSplit.length; ++i)
                      if (flavorSplit[i].contains(replacedText))
                        (TextSpan(children: [
                          TextSpan(
                            text: flavorSplit[i].substring(
                                0, flavorSplit[i].indexOf(replacedText)),
                          ),
                          /* 키워드 색상 하이라이트 */
                          TextSpan(
                              text: flavorSplit[i].substring(
                                  flavorSplit[i].indexOf(replacedText),
                                  flavorSplit[i].indexOf(replacedText) +
                                      replacedText.length),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(1.0))),
                          TextSpan(
                            text: flavorSplit[i].substring(
                                flavorSplit[i].indexOf(replacedText) +
                                    replacedText.length,
                                flavorSplit[i].length),
                          ),
                        ]))
                      else
                        TextSpan(
                            text: flavorSplit[i],
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold)),
                  ])),
            )
          ]),
        ),
      );
    }
  }

  return GridView(
    padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
    children: [for (int i = 0; i < ret.length; ++i) ret[i]],
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 210,
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
  String getColor(String name) {
    switch (name) {
      case "상큼한":
        return "DA6C31";
      case "달콤한":
        return "F08FA4";
      default:
        return "aaaaaa";
    }
  }

  return Container(
      decoration: BoxDecoration(
        color: Color(int.parse("0xff" + getColor(origtext))),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.fromLTRB(11, 7, 11, 7),
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: text);
}
