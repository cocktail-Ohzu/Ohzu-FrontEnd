import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './detail.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

/*
클래스로 만들다가 만것들

class NameItem {
  String? name;
  int? id;

  NameItem(String name, int id) {
    name = name;
    id = id;
  }
}

class TagItem {
  String? name;
  List<String>? tag;

  TagItem(String name, List<String> tag) {
    name = name;
    tag = tag;
  }

  List<String>? getTag() {
    return tag;
  }
}

class _SearchState extends State<Search> {
  //final suggestions = ["검색", "기능", "따라하기", "힘들어", "살려줘"];

  List<NameItem> _listName = [
    NameItem("진", 1),
    NameItem("진 토닉", 1),
    NameItem("토닉 진", 1),
    NameItem("진진자라자라", 1),
    NameItem("방탄소년단 진", 1),
    NameItem("리그오브레전드 진 장인", 1),
    NameItem("빌리진", 1),
    NameItem("깔루아 밀크", 1),
    NameItem("데킬라 선라이즈", 1),
    NameItem("블랙 러시안", 1),
    NameItem("블루하와이", 1),
  ];
  List<TagItem> _listTag = [
    TagItem("모히토", ["상큼한", "청량한"]),
    TagItem("마가리타", ["상큼한", "쓴"]),
    TagItem("블루 하와이", ["상큼한", "달달한"]),
    TagItem("미도리사워", ["상큼한", "달달한"]),
    TagItem("이거 만드는거", ["쓴", "쓴"]),
    TagItem("힘들었어요", ["쓴", "로맨틱한"]),
    TagItem("ㅎ긓그후ㅡㄱ훅", ["상큼한", "청량한"]),
    TagItem("오쥬화이팅", ["상큼한", "청량한"]),
    TagItem("짱짱짱", ["상큼한", "청량한"]),
  ];
  List<Object> _search = [];
  bool _onLoading = false;

*/

class _SearchState extends State<Search> {
  //final suggestions = ["검색", "기능", "따라하기", "힘들어", "살려줘"];

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
  List<String> _listTag = [
    "상큼한",
    "달달한",
    "로맨틱한",
    "쓴",
    "힘들어요",
    "한가한",
    "이거 만드는거",
    "흑흑흑ㅎ긓ㄱ한",
    "오쥬화이팅한"
  ];
  List<String> _search = [];
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

    if (text.startsWith('#')) {
      text = text.substring(1);
      _listTag.forEach((tagItem) {
        if (tagItem.contains(text) || tagItem.toString().contains(text)) {
          _search.add(tagItem);

          print(tagItem + ", "); //출력되는지확인
        }
      });
    } else {
      _listName.forEach((nameItem) {
        if (nameItem.contains(text) || nameItem.toString().contains(text)) {
          _search.add(nameItem);

          print(nameItem + ", "); //출력되는지확인
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
Widget buildResultByName(BuildContext context, List<String> list, String text) {
  final int len = list.length;
  List<Widget> ret = [];
  int textIndex;

  for (int i = 0; i < len; ++i) {
    textIndex = list[i].indexOf(text);
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
                  text: list[i].substring(0, textIndex),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                  children: [
                /* 키워드 색상 하이라이트 */
                TextSpan(
                    text: list[i].substring(textIndex, textIndex + text.length),
                    style: TextStyle(color: Colors.white.withOpacity(1.0))),
                TextSpan(
                  text: list[i]
                      .substring(textIndex + text.length, list[i].length),
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
Widget buildResultByTag(BuildContext context, List<String> list, String text) {
  final int len = list.length;
  List<Widget> ret = [];
  String replacedText = text.replaceAll('#', '');
  int textIndex;

  for (int i = 0; i < len; ++i) {
    textIndex = list[i].indexOf(replacedText);
    if (textIndex != -1) {
      ret.add(
        Container(
          decoration: BoxDecoration(
              color: Color(0xffaaaaaa), //Color(0xff1e1e1e),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image(
                  image: AssetImage('asset/images/c.png'), fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: RichText(
                  text: TextSpan(
                      text: list[i].substring(0, textIndex),
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                      children: [
                    /* 키워드 색상 하이라이트 */
                    TextSpan(
                        text: list[i].substring(
                            textIndex, textIndex + replacedText.length),
                        style: TextStyle(color: Colors.white.withOpacity(1.0))),
                    TextSpan(
                      text: list[i].substring(
                          textIndex + replacedText.length, list[i].length),
                    ),
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
