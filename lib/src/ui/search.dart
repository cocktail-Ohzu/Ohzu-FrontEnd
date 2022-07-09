import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohzu/src/blocs/serach_bloc/search_bloc.dart';
import 'package:ohzu/src/blocs/ingredient_bloc/ingredient_bloc.dart';
import 'package:ohzu/src/utils/search_util.dart';
import 'package:ohzu/src/models/search_model.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/ui/detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /* 검색 바 컨트롤러 */
  final TextEditingController searchController = TextEditingController();
  final SearchBloc searchBloc = SearchBloc();
  final IngredientBloc ingredientBloc = IngredientBloc();
  String _selectedItemName = "";

  /* 텍스트 입력과 동시에 state 발생 */
  onSearch(String text) async {
    setState(() {});
  }

  @override
  void initState() {
    /* 검색 페이지 Bloc 주입 */
    searchBloc.add(LoadSearchEvent());
    /* recommend 위한 Bloc 주입 */
    ingredientBloc.add(LoadIngredientEvent());
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
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (state is SearchLoadedState) {
            if (searchController.text.isEmpty) {
              /* 검색 태그 제안 */
              return BlocProvider(
                  create: (_) => ingredientBloc,
                  child: BlocBuilder<IngredientBloc, IngredientState>(
                      builder: (context, ingredientState) {
                    if (ingredientState is IngredientLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      );
                    } else if (ingredientState is IngredientLoadedState) {
                      return buildSuggestion(ingredientState.ingredient);
                    } else if (ingredientState is IngredientErrorState) {
                      return const Text("recommend api error");
                    }
                    return const Text("");
                  }));
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
        suffix: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(
                  Icons.cancel,
                  size: 20,
                ),
                onPressed: () => {
                  setState(
                    () => {controller.text = ""},
                  )
                },
              )
            : null,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
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

/*
 *
 * searchController 가 비어있으면 제안 페이지 생성하는 부분
 * 
 */

/* 검색 내역이 없을 때 제안 생성 */
  Widget buildSuggestion(IngredientModel ingredientlist) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 38),
            child: const Text(
              "검색 추천 키워드",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 28),
              child: Column(
                children: [
                  buildSuggestionItemLine(
                      title: "재료", itemList: ingredientlist.bases!, maxItem: 8),
                  const SizedBox(
                    height: 36,
                  ),
                  buildSuggestionItemLine(
                      title: "맛",
                      itemList: ingredientlist.flavors!,
                      maxItem: 4),
                  const SizedBox(
                    height: 36,
                  ),
                  buildSuggestionItemLine(
                      title: "분위기",
                      itemList: ingredientlist.moods!,
                      maxItem: 6),
                  const SizedBox(
                    height: 36,
                  ),
                  buildSuggestionItemLine(
                      title: "날씨",
                      itemList: ingredientlist.weathers!,
                      maxItem: 7),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildSuggestionItemLine(
      {required String title,
      required List<IngredientElement> itemList,
      required int maxItem}) {
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          /* 타이틀 */
          Container(
            margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            alignment: Alignment.centerLeft,
            width: 61,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
          ),
          /* 선택 내역 */
          Expanded(
              child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            /* 좌우 간격 */
            spacing: 8,
            /* 위아래 간격 */
            runSpacing: 6,
            children: [
              for (int i = 0; i < itemList.length && i < maxItem; ++i)
                buildSuggestionTagItem(itemList[i]),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildSuggestionTagItem(IngredientElement ingredientElem) {
    final myName = ingredientElem.name! + ingredientElem.id!.toString();
    return GestureDetector(
        onTap: () {
          _selectedItemName = myName;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 180), () {
            searchController.text = "#" + ingredientElem.name!;
            setState(() {});
          });
        },
        child: AnimatedContainer(
            decoration: BoxDecoration(
              color: _selectedItemName == myName
                  ? Color(int.parse("0xf${ingredientElem.tagColor}"))
                      .withOpacity(0.5)
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: _selectedItemName == myName
                  ? null
                  : Border.all(
                      color: const Color(0xffA9A9A9),
                      width: 1,
                    ),
            ),
            padding: _selectedItemName == myName
                ? const EdgeInsets.fromLTRB(11, 7, 11, 7)
                : const EdgeInsets.fromLTRB(10, 6, 10, 6),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            duration: const Duration(milliseconds: 100),
            child: Text(
              ingredientElem.name!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )));
  }

/*
 *
 * 이름으로 검색할 시 뜨는 아이템 생성하는 부분
 * 
 */
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

/*
 *
 * 해쉬태그로 검색할 시 뜨는 아이템 생성하는 부분
 * 
 */
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
