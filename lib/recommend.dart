import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/details.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> with TickerProviderStateMixin {
  TabController? _tabController;
  String? _baseDrink;
  final List<String> baseList = [
    "와인",
    "데낄라",
    "럼",
    "진",
    "샴페인",
    "리퀴어",
    "보드카",
    "위스키"
  ];

  @override
  void initState() {
    _tabController = TabController(length: 9, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: TextButton(
                  child: Text(
                    "완료",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        height: 0.4),
                  ),
                  onPressed: () {},
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
                      buildTabBarItem(name: "재료"),
                      buildTabBarItem(name: "무드/기분"),
                      buildTabBarItem(name: "날씨/계절"),
                      buildTabBarItem(name: "가니쉬"),
                      buildTabBarItem(name: "색상"),
                    ],
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Colors.white.withOpacity(0.5),
                  )),
              /* 중간선 */
              Divider(
                height: 1,
                color: Color(0xff2B2B2B),
              ),
              /* 뷰 */
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Column(
                    children: [
                      /* 타이틀 및 설명 */
                      Container(
                        padding: EdgeInsets.only(top: 38, bottom: 40),
                        alignment: Alignment.centerLeft,
                        child: buildTabViewTitle(
                            title: "원하는 베이스 술을 선택해 주세요",
                            desc: "원하는 재료를 선택해 주세요!\n관심 없는 선택지는 넘겨도 좋아요."),
                      ),
                      /* 베이스 술 선택 */
                      SizedBox(
                        height: 200,
                        child: GridView(
                          shrinkWrap: true,
                          children: [
                            /* 아이템 리스트에서 꺼내옴 */
                            for (int i = 0; i < baseList.length; ++i)
                              GestureDetector(
                                onTap: () => {
                                  setState(() {
                                    if (baseList[i]
                                        .contains(_baseDrink.toString())) {
                                      _baseDrink = null;
                                    } else {
                                      _baseDrink = baseList[i];
                                    }
                                    print(_baseDrink); //
                                  })
                                },
                                child: (Column(
                                  children: [
                                    AnimatedContainer(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      height: 64,
                                      decoration: BoxDecoration(
                                          color: Color(0xff474747),
                                          shape: BoxShape.circle,
                                          border: _baseDrink == baseList[i]
                                              ? Border.all(
                                                  color:
                                                      const Color(0xffce6228),
                                                  width: 1)
                                              : null),
                                      duration:
                                          const Duration(milliseconds: 200),
                                    ),
                                    Text(baseList[i]),
                                  ],
                                )),
                              ),
                          ],
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 74,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 10),
                        ),
                      ),
                      /* 하단 버튼 */
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: CupertinoButton(
                              padding: const EdgeInsets.all(19),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: const Color(0xffDA6C31),
                              child: const Text(
                                "추가하기",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(child: Text("tabbar view")),
                  Container(child: Text("tabbar view")),
                  Container(child: Text("tabbar view")),
                  Container(child: Text("tabbar view")),
                  Container(child: Text("tabbar view")),
                  Container(child: Text("tabbar view")),
                  Container(child: Text("tabbar view")),
                  Container(child: Text("tabbar view")),
                ]),
              )
            ],
          ),
        ));
  }
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
