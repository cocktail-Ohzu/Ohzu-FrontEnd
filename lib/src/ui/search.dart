import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohzu/src/blocs/serach_bloc/search_bloc.dart';
import 'package:ohzu/src/utils/search_util.dart';
import 'package:ohzu/src/models/search_model.dart';
import 'package:ohzu/src/ui/detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //final suggestions = ["검색", "기능", "따라하기", "힘들어", "살려줘"];

  /* 검색 바 컨트롤러 */
  final TextEditingController searchController = TextEditingController();
  final SearchBloc searchBloc = SearchBloc();

  /* 텍스트 입력과 동시에 state 발생 */
  onSearch(String text) async {
    setState(() {});
  }

  @override
  void initState() {
    /* 검색 페이지 Bloc 주입 */
    searchBloc.add(LoadSearchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => searchBloc,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
            toolbarHeight: 44,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: buildSearchBar(searchController, onSearch),
            leadingWidth: 60,
            actions: const []),
        body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state is SearchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoadedState) {
            if (searchController.text.isEmpty) {
              return buildSuggestion();
            } else if (searchController.text.startsWith('#')) {
              return buildResultByTag(
                  getProcessedList(state.search, searchController.text),
                  searchController.text);
            } else {
              return buildResultByName(
                  getProcessedList(state.search, searchController.text),
                  searchController.text);
            }
          } else if (state is SearchErrorState) {
            return const Text("search api error");
          }
          return Container();
        }),
        //searchController.text == ''
        //     ? buildSuggestion(context)
        //     : searchController.text.startsWith('#')
        //         ? buildResultByTag(context, _search, searchController.text)
        //         : buildResultByName(context, _search, searchController.text),
      ),
    );
  }

  /* 검색 바 위젯 생성 */
  Widget buildSearchBar(TextEditingController controller, dynamic onSearch) {
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

/* 검색 내역이 없을 때 제안 생성 */
  Widget buildSuggestion() {
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
  Widget buildResultByName(List<SearchModel> list, String text) {
    final int len = list.length;
    List<Widget> ret = [];
    String cocktailName;
    int textIndex;

    for (int i = 0; i < len; ++i) {
      /* 한글로 검색 */
      cocktailName = list[i].name!;
      textIndex = cocktailName.toLowerCase().indexOf(text.toLowerCase());
      /* 한글이 아니면 영어로 검색 */
      if (textIndex == -1) {
        cocktailName = list[i].engName!;
        textIndex = cocktailName.toLowerCase().indexOf(text.toLowerCase());
      }
      if (textIndex != -1) {
        ret.add(GestureDetector(
          onTap: () {
            openDetailPage(context, list[i].id!);
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
  Widget buildResultByTag(List<SearchModel> _list, String _text) {
    final int len = _list.length;
    List<Widget> ret = [];
    String replacedText = _text.replaceAll('#', '');
    String cocktailName;

    List<Tag> tagToShow = [];
    int tagToShowLen;

    for (int i = 0; i < len; ++i) {
      cocktailName = _list[i].name!;

      tagToShow = getTag(_list[i], replacedText);
      tagToShowLen = tagToShow.length > 2 ? 2 : tagToShow.length;

      if (tagToShowLen > 0) {
        ret.add(
          GestureDetector(
            onTap: () {
              openDetailPage(context, _list[i].id!);
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xff1e1e1e),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: const Image(
                          image: AssetImage('asset/images/c.png'),
                          fit: BoxFit.cover),
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
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0; i < tagToShowLen; ++i)
                                  buildTagItem(
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                            /* 태그 별 키워드 색상 하이라이트 부분 */ TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: tagToShow[i]
                                                        .name!
                                                        .substring(
                                                            0,
                                                            tagToShow[i]
                                                                .name!
                                                                .indexOf(
                                                                    replacedText)),
                                                  ),
                                                  /* 키워드 색상 하이라이트 */
                                                  TextSpan(
                                                      text: tagToShow[i]
                                                          .name!
                                                          .substring(
                                                              tagToShow[i]
                                                                  .name!
                                                                  .indexOf(
                                                                      replacedText),
                                                              tagToShow[i]
                                                                      .name!
                                                                      .indexOf(
                                                                          replacedText) +
                                                                  replacedText
                                                                      .length),
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  1.0))),
                                                  TextSpan(
                                                    text: tagToShow[i]
                                                        .name!
                                                        .substring(
                                                            tagToShow[i]
                                                                    .name!
                                                                    .indexOf(
                                                                        replacedText) +
                                                                replacedText
                                                                    .length,
                                                            tagToShow[i]
                                                                .name!
                                                                .length),
                                                  ),
                                                ]),
                                          ])),
                                      tagToShow[i].tagColor!),
                              ])),
                    )
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
  Widget buildTagItem(RichText text, String colorCode) {
    return Container(
        decoration: BoxDecoration(
          color: Color(int.parse("0xf$colorCode")).withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.fromLTRB(11, 7, 11, 7),
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: text);
  }
}
