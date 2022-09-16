import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohzu/src/blocs/ingredient_bloc/ingredient_bloc.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/ui/recommend_confirm.dart';
//힌트 팝업 최초 띄우기 의한 플러그인
import 'package:shared_preferences/shared_preferences.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> with TickerProviderStateMixin {
  TabController? _tabController;
  final ingredientBloc = IngredientBloc();

  final _strengthItem = [
    IngredientElement(
        id: 0, name: "논알콜", img: null, tagColor: "FFD233", desc: null),
    IngredientElement(
        id: 1, name: "10도 미만", img: null, tagColor: "FFD233", desc: null),
    IngredientElement(
        id: 2, name: "10~20도", img: null, tagColor: "FFD233", desc: null),
    IngredientElement(
        id: 3, name: "21~40도", img: null, tagColor: "FFD233", desc: null)
  ];

  Map<String, bool> _expansionController = {};

  List<List<IngredientElement>> itemListController = [
    [], //3 flavorId
    [], //2 strength
    [], //4 moodId
    [], //5 weatherId
    [], //0 baseId
    [], //1 ingredientId
    [] //6 ornamentId
  ];

  _loadHintPopupPreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool('hintPopupRecommend') ?? false)) {
      // print("show hint");
      showHintPopup();
    }
    // else {
    //   print("Do not show hint");
    // }
  }

  //다음부터 힌트 팝업을 띄우지 않도록 저장하는 메소드
  _saveNotShowHintPopupPreference(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('hintPopupRecommend', status);
    });
  }

  bool isControllerEmpty() {
    for (var list in itemListController) {
      if (list.isNotEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    ingredientBloc.add(LoadIngredientEvent());
    //힌트 팝업 띄우기
    _loadHintPopupPreference();
    //테스트용 팝업 초기화
    // _saveNotShowHintPopupPreference(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ingredientBloc,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.2],
          colors: [
            Color(0xff8C5B40),
            Color(0xff121212),
          ],
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                toolbarHeight: 40,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                    child: TextButton(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      child: const Text(
                        "완료",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                            height: 0.4),
                      ),
                      onPressed: () => //선택한 내역으로 추천 진행하기
                          openRecommendConfirmPage(context, itemListController),
                    ),
                  )
                ]),
            body: Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                children: [
                  /* 탭 바 */
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 26),
                      child: TabBar(
                        labelPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                        tabs: [
                          buildTabBarItem(name: "맛"),
                          buildTabBarItem(name: "도수"),
                          buildTabBarItem(name: "무드/기분"),
                          buildTabBarItem(name: "날씨/계절"),
                          buildTabBarItem(name: "베이스"),
                          buildTabBarItem(name: "재료"),
                          buildTabBarItem(name: "가니쉬"),
                        ],
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: Colors.white.withOpacity(0.5),
                      )),
                  /* 중간선 */
                  const Divider(
                    height: 1,
                    color: Color(0xff2B2B2B),
                  ),
                  /* 뷰 */
                  BlocBuilder<IngredientBloc, IngredientState>(
                      builder: (context, state) {
                    if (state is IngredientLoadingState) {
                      return Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      );
                    } else if (state is IngredientLoadedState) {
                      return Expanded(
                        child:
                            TabBarView(controller: _tabController, children: [
                          buildTabView(
                              name: "맛을",
                              item: state.ingredient.flavors!.toList(),
                              controllerList: itemListController[0]),
                          buildTabViewStrength(
                              item: _strengthItem,
                              controllerList: itemListController[1]),
                          buildTabView(
                              name: "무드나 기분을",
                              item: state.ingredient.moods!.toList(),
                              controllerList: itemListController[2]),
                          buildTabView(
                              name: "날씨나 계절을",
                              item: state.ingredient.weathers!.toList(),
                              controllerList: itemListController[3]),
                          buildTabView(
                              name: "베이스 술을",
                              item: state.ingredient.bases!.toList(),
                              controllerList: itemListController[4]),
                          buildTabViewIngredients(
                              name: "재료를",
                              item: state.ingredient.ingredients!.toList(),
                              controllerList: itemListController[5]),
                          buildTabView(
                              name: "가니쉬를",
                              item: state.ingredient.ornaments!.toList(),
                              controllerList: itemListController[6]),
                        ]),
                      );
                    } else if (state is IngredientErrorState) {
                      return const Text("Ingredient api error");
                    }
                    return Container();
                  }),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildTabView(
      {required String name,
      required List<IngredientElement> item,
      required List<IngredientElement> controllerList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /* 타이틀 및 설명 */
        Container(
          padding: const EdgeInsets.only(top: 38, bottom: 40),
          alignment: Alignment.centerLeft,
          child: buildTabViewTitle(
              title: "원하는 $name 선택해 주세요",
              desc: "관심 없는 선택지는 넘겨도 좋아요.",
              hint: name == "베이스 술을" ? "태그를 꾹 누르면 설명을 볼 수 있습니다." : null),
        ),
        Expanded(
          child: GridView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              /* 아이템 리스트에서 꺼내옴 */
              for (int i = 0; i < item.length; ++i)
                GestureDetector(
                  onLongPress: () => {
                    if (item[i].desc != null)
                      showDescriptionPopup(context: context, item: item[i])
                  },
                  onTap: () => {
                    setState(
                      () {
                        if (controllerList.contains(item[i])) {
                          controllerList.remove(item[i]);
                        } else {
                          controllerList.add(item[i]);
                        }
                        // print(controllerList); //
                        // print(itemListController); //
                      },
                    ),
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      key: ValueKey<bool>(controllerList.contains(item[i])),
                      margin: const EdgeInsets.only(bottom: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff272727),
                          border: Border.all(
                            color: controllerList.contains(item[i])
                                ? Color(int.parse("0xff${item[i].tagColor!}"))
                                : Colors.transparent,
                          )),
                      child: Text(
                        item[i].name!,
                        style: TextStyle(
                          fontSize: 14,
                          color: controllerList.contains(item[i])
                              ? Color(int.parse("0xff${item[i].tagColor!}"))
                              : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 60,
                //세로줄 아이템 개수
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
          ),
        ),
        /* 하단 버튼 */
        buildBottomButton(controllerList: controllerList)
      ],
    );
  }

  Widget buildTabViewIngredients(
      {required String name,
      required List<IngredientElement> item,
      required List<IngredientElement> controllerList}) {
    //카테고리별 나누는 로직
    Map<String, List<IngredientElement>> _categoryItemList = {};

    for (IngredientElement ingredient in item) {
      final String title = ingredient.category!;
      if (!_categoryItemList.containsKey(title)) {
        _categoryItemList[title] = [];
        //타일 확장 컨트롤러
        _expansionController[title] = true;
      }
      _categoryItemList[title]!.add(ingredient);
    }

    return Column(
      children: [
        /* 타이틀 및 설명 */
        Container(
          padding: const EdgeInsets.only(top: 38, bottom: 20),
          alignment: Alignment.centerLeft,
          child: buildTabViewTitle(
              title: "원하는 $name 선택해 주세요",
              desc: "관심 없는 선택지는 넘겨도 좋아요.",
              hint: "태그를 꾹 누르면 설명을 볼 수 있습니다."),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                for (String title in _categoryItemList.keys)
                  ExpansionTile(
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0.5),
                    initiallyExpanded: true,
                    trailing: const Text(""),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: Color(0xffDA6C31),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 24,
                          color: Color(0xffDA6C31),
                        ),
                      ],
                    ),
                    /* 숨겨진 내용들 */
                    children: [
                      GridView(
                        //스크롤 막기
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          /* 아이템 리스트에서 꺼내옴 */
                          for (IngredientElement ingredient
                              in _categoryItemList[title]!)
                            GestureDetector(
                              onLongPress: () => {
                                if (ingredient.desc != null)
                                  showDescriptionPopup(
                                      context: context, item: ingredient)
                              },
                              onTap: () => {
                                setState(() {
                                  if (controllerList.contains(ingredient)) {
                                    controllerList.remove(ingredient);
                                  } else {
                                    controllerList.add(ingredient);
                                  }
                                }),
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  key: ValueKey<bool>(
                                      controllerList.contains(ingredient)),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xff272727),
                                      // color: controllerList.contains(item[i])
                                      //     ? Color(0xff474747)
                                      //     : Color(int.parse("0xff${item[i].tagColor!}")),//태그컬러로사용?임시
                                      border: Border.all(
                                        color: controllerList
                                                .contains(ingredient)
                                            ? Color(int.parse(
                                                "0xff${ingredient.tagColor!}"))
                                            : Colors.transparent,
                                      )),
                                  child: Text(
                                    ingredient.name!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: controllerList.contains(ingredient)
                                          ? Color(int.parse(
                                              "0xff${ingredient.tagColor!}"))
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                        ],
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 60,
                                //세로줄 아이템 개수
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),

        /* 하단 버튼 */
        buildBottomButton(controllerList: controllerList)
      ],
    );
  }

  Widget buildTabViewStrength(
      {required List<IngredientElement> item,
      required List<IngredientElement> controllerList}) {
    return Column(
      children: [
        /* 타이틀 및 설명 */
        Container(
          padding: const EdgeInsets.only(top: 38, bottom: 40),
          alignment: Alignment.centerLeft,
          child: buildTabViewTitle(
              title: "원하는 도수를 선택해 주세요", desc: "관심 없는 선택지는 넘겨도 좋아요."),
        ),
        /* 베이스 술 선택 */
        Expanded(
          child: GridView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              /* 아이템 리스트에서 꺼내옴 */
              for (int i = 0; i < item.length; ++i)
                GestureDetector(
                  onTap: () => {
                    setState(() {
                      if (controllerList.contains(item[i])) {
                        controllerList.remove(item[i]);
                      } else {
                        controllerList.add(item[i]);
                      }
                      // print(controllerList); //
                      // print(itemListController); //
                    })
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      key: ValueKey<bool>(controllerList.contains(item[i])),
                      margin: const EdgeInsets.only(bottom: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff272727),
                          border: Border.all(
                            color: controllerList.contains(item[i])
                                ? Color(int.parse("0xff${item[i].tagColor!}"))
                                : Colors.transparent,
                          )),
                      child: Text(
                        item[i].name!,
                        style: TextStyle(
                          fontSize: 14,
                          color: controllerList.contains(item[i])
                              ? Color(int.parse("0xff${item[i].tagColor!}"))
                              : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 60,
                //세로줄 아이템 개수
                crossAxisCount: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
          ),
        ),

        /* 하단 버튼 */
        buildBottomButton(controllerList: controllerList)
      ],
    );
  }

  Widget buildBottomButton({required List<IngredientElement> controllerList}) {
    const duration = Duration(milliseconds: 200);

    return Container(
      height: 52,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: AnimatedSwitcher(
        duration: duration,
        child: CupertinoButton(
          minSize: double.infinity,
          key: ValueKey<bool>(controllerList.isEmpty),
          padding: const EdgeInsets.all(17),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: controllerList.isEmpty
              ? const Color(0xff181818)
              : const Color(0xffDA6C31),
          child: Text(
            controllerList.isEmpty ? "건너뛰기" : "추가하기",
            style: TextStyle(
                color: controllerList.isEmpty
                    ? const Color(0xffDA6C31)
                    : const Color(0xffffffff),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            if (_tabController!.index + 1 < _tabController!.length) {
              _tabController!.index++;
            } else if (!isControllerEmpty() ||
                _tabController!.index + 1 == _tabController!.length) {
              //선택한 내역으로 추천 진행하기
              openRecommendConfirmPage(context, itemListController);
            }
          },
        ),
      ),
    );
  }

  void showHintPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color(0xff272727),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: const Text(
                  "Hint",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xffDA6C31),
                    fontSize: 19,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: const Text(
                  "고민되거나 원하지 않는 선택지는\n아래 건너뛰기 버튼으로\n생략할 수 있어요!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 32, 30, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _saveNotShowHintPopupPreference(true);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "다시 보지 않기",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffA9A9A9),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "닫기",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffA9A9A9),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showDescriptionPopup(
    {required BuildContext context, required IngredientElement item}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.zero,
        backgroundColor: const Color(0xff272727),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(34, 38, 34, 0),
              child: Text(
                item.name!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xffDA6C31),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(34, 30, 34, 0),
              child: Text(
                item.desc!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(34, 32, 34, 32),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "닫기",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xffA9A9A9),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildTabBarItem({required String name}) {
  return Container(
    child: Text(
      name,
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget buildTabViewTitle(
    {required String title, required String desc, String? hint}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),

      if (hint != null)
        Row(
          children: [
            const Text(
              "Hint! ",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffDA6C31),
                height: 1.5,
              ),
            ),
            Expanded(
              child: Text(
                hint,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),

      Row(
        children: [
          if (hint == null)
            const Text(
              "Hint! ",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffDA6C31),
                height: 1.5,
              ),
            ),
          Expanded(
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.6),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
      // if (hint != null)
      //   Container(
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: Text(
      //             hint,
      //             style: TextStyle(
      //               fontSize: 14,
      //               color: Colors.white.withOpacity(0.6),
      //               height: 1.5,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // Container(
      //   child: Text(
      //     desc,
      //     style: TextStyle(
      //       fontSize: 14,
      //       color: Colors.white.withOpacity(0.6),
      //       height: 1.5,
      //     ),
      //   ),
      // ),
    ],
  );
}
