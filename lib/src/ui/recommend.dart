import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohzu/src/blocs/ingredient_bloc/ingredient_bloc.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/ui/recommend_confirm.dart';

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
    [], //0 baseId
    [], //1 ingredientId
    [], //2 strength
    [], //3 flavorId
    [], //4 moodId
    [], //5 weatherId
    [] //6 ornamentId
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    ingredientBloc.add(LoadIngredientEvent());
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
                          buildTabBarItem(name: "베이스"),
                          buildTabBarItem(name: "재료"),
                          buildTabBarItem(name: "도수"),
                          buildTabBarItem(name: "맛"),
                          buildTabBarItem(name: "무드/기분"),
                          buildTabBarItem(name: "날씨/계절"),
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
                        height: MediaQuery.of(context).size.height / 2,
                        child: CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      );
                    } else if (state is IngredientLoadedState) {
                      return Expanded(
                        child:
                            TabBarView(controller: _tabController, children: [
                          buildTabView(
                              name: "베이스 술을",
                              item: state.ingredient.bases!.toList(),
                              controllerList: itemListController[0]),
                          buildTabViewIngredients(
                              name: "재료를",
                              item: state.ingredient.ingredients!.toList(),
                              controllerList: itemListController[1]),
                          buildTabViewStrength(
                              item: _strengthItem,
                              controllerList: itemListController[2]),
                          buildTabView(
                              name: "맛을",
                              item: state.ingredient.flavors!.toList(),
                              controllerList: itemListController[3]),
                          buildTabView(
                              name: "무드나 기분을",
                              item: state.ingredient.moods!.toList(),
                              controllerList: itemListController[4]),
                          buildTabView(
                              name: "날씨나 계절을",
                              item: state.ingredient.weathers!.toList(),
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
      children: [
        /* 타이틀 및 설명 */
        Container(
          padding: const EdgeInsets.only(top: 38, bottom: 40),
          alignment: Alignment.centerLeft,
          child: buildTabViewTitle(
              title: "원하는 $name 선택해 주세요",
              desc: "원하는 재료를 선택해 주세요!\n관심 없는 선택지는 넘겨도 좋아요."),
        ),
        /* 베이스 술 선택 */
        Expanded(
          child: GridView(
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
                    setState(() {
                      if (controllerList.contains(item[i])) {
                        controllerList.remove(item[i]);
                      } else {
                        controllerList.add(item[i]);
                      }
                      print(controllerList); //
                      print(itemListController); //
                    })
                  },
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff272727),
                        // color: controllerList.contains(item[i])
                        //     ? Color(0xff474747)
                        //     : Color(int.parse("0xff${item[i].tagColor!}")),//태그컬러로사용?임시
                        border: Border.all(
                          color: controllerList.contains(item[i])
                              ? Color(int.parse("0xff${item[i].tagColor!}"))
                              : Colors.transparent,
                        )),
                    duration: const Duration(milliseconds: 300),
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
        // /* 설명 칸 */
        // if (controllerList.isNotEmpty && controllerList.last.desc != null)
        //   Center(
        //     child: Container(
        //       alignment: Alignment.bottomLeft,
        //       decoration: BoxDecoration(
        //         border: Border.all(
        //           color: const Color(0xFFDA6C31),
        //           width: 1,
        //         ),
        //         borderRadius: const BorderRadius.all(Radius.circular(12)),
        //         color: const Color(0xFF1E1E1E),
        //       ),
        //       padding: const EdgeInsets.fromLTRB(29, 20, 29, 20),
        //       margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               controllerList.last.name!,
        //               style: const TextStyle(
        //                   fontSize: 16, fontWeight: FontWeight.w600),
        //             ),
        //             const SizedBox(
        //               height: 12,
        //             ),
        //             Text(
        //               controllerList.last.desc!,
        //               style: const TextStyle(
        //                   fontSize: 12, fontWeight: FontWeight.w500),
        //               textAlign: TextAlign.start,
        //             ),
        //           ]),
        //     ),
        //   ),
        /* 하단 버튼 */
        Container(
            height: 52,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(17),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xff181818),
                    child: const Text(
                      "건너뛰기",
                      style: TextStyle(
                          color: Color(0xffDA6C31),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      if (_tabController!.index + 1 < _tabController!.length) {
                        _tabController!.index++;
                      } else {
                        //선택한 내역으로 추천 진행하기
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(17),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color(0xffDA6C31),
                    child: const Text(
                      "추가하기",
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {
                      if (_tabController!.index + 1 < _tabController!.length) {
                        _tabController!.index++;
                      } else {
                        //선택한 내역으로 추천 진행하기
                        openRecommendConfirmPage(context, itemListController);
                      }
                    },
                  ),
                ),
              ],
            )
            // child: SizedBox(
            //   width: double.infinity,
            //   child: CupertinoButton(
            //     padding: const EdgeInsets.all(19),
            //     borderRadius: const BorderRadius.all(Radius.circular(8)),
            //     color: const Color(0xffDA6C31),
            //     child: const Text(
            //       "추가하기",
            //       style: TextStyle(
            //           color: Color(0xffffffff),
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400),
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
            )
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
          padding: const EdgeInsets.only(top: 38, bottom: 40),
          alignment: Alignment.centerLeft,
          child: buildTabViewTitle(
              title: "원하는 $name 선택해 주세요",
              desc: "원하는 재료를 선택해 주세요!\n관심 없는 선택지는 넘겨도 좋아요."),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (String title in _categoryItemList.keys)
                  ExpansionTile(
                    tilePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0.5),
                    initiallyExpanded: true,
                    trailing: const Text(""),
                    //key: expansionTileKey,
                    // onExpansionChanged: (bool isExpanded) {
                    //   setState(
                    //       () => {_expansionController[title] = isExpanded});
                    //   /* 자동 스크롤 */
                    //   //   _scrollToSelectedContent(
                    //   //       expansionTileKey: expansionTileKey);
                    //   //
                    // },
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
                              child: AnimatedContainer(
                                margin: const EdgeInsets.only(bottom: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff272727),
                                    // color: controllerList.contains(item[i])
                                    //     ? Color(0xff474747)
                                    //     : Color(int.parse("0xff${item[i].tagColor!}")),//태그컬러로사용?임시
                                    border: Border.all(
                                      color: controllerList.contains(ingredient)
                                          ? Color(int.parse(
                                              "0xff${ingredient.tagColor!}"))
                                          : Colors.transparent,
                                    )),
                                duration: const Duration(milliseconds: 300),
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
        Container(
          height: 52,
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.all(17),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: const Color(0xff181818),
                  child: const Text(
                    "건너뛰기",
                    style: TextStyle(
                        color: Color(0xffDA6C31),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    if (_tabController!.index + 1 < _tabController!.length) {
                      _tabController!.index++;
                    } else {
                      //선택한 내역으로 추천 진행하기
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.all(17),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: const Color(0xffDA6C31),
                  child: const Text(
                    "추가하기",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    if (_tabController!.index + 1 < _tabController!.length) {
                      _tabController!.index++;
                    } else {
                      //선택한 내역으로 추천 진행하기
                      openRecommendConfirmPage(context, itemListController);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
              title: "원하는 도수를 선택해 주세요",
              desc: "원하는 도수를 선택해 주세요!\n관심 없는 선택지는 넘겨도 좋아요."),
        ),
        /* 베이스 술 선택 */
        Expanded(
          child: GridView(
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
                      print(controllerList); //
                      print(itemListController); //
                    })
                  },
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff272727),
                        // color: controllerList.contains(item[i])
                        //     ? Color(0xff474747)
                        //     : Color(int.parse("0xff${item[i].tagColor!}")),//태그컬러로사용?임시
                        border: Border.all(
                          color: controllerList.contains(item[i])
                              ? Color(int.parse("0xff${item[i].tagColor!}"))
                              : Colors.transparent,
                        )),
                    duration: const Duration(milliseconds: 300),
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
        Container(
          height: 52,
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.all(17),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: const Color(0xff181818),
                  child: const Text(
                    "건너뛰기",
                    style: TextStyle(
                        color: Color(0xffDA6C31),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    if (_tabController!.index + 1 < _tabController!.length) {
                      _tabController!.index++;
                    } else {
                      //선택한 내역으로 추천 진행하기
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Expanded(
                child: CupertinoButton(
                  padding: const EdgeInsets.all(17),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: const Color(0xffDA6C31),
                  child: const Text(
                    "추가하기",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    if (_tabController!.index + 1 < _tabController!.length) {
                      _tabController!.index++;
                    } else {
                      //선택한 내역으로 추천 진행하기
                      openRecommendConfirmPage(context, itemListController);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
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
                padding: const EdgeInsets.fromLTRB(34, 30, 34, 38),
                child: Text(
                  item.desc!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              )
            ]),
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

Widget buildTabViewTitle({required String title, required String desc}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )),
      Container(
          child: Text(
        desc,
        style: TextStyle(
            fontSize: 14, color: Colors.white.withOpacity(0.6), height: 1.5),
      )),
    ],
  );
}
