import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> with TickerProviderStateMixin {
  TabController? _tabController;
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

  List<int> baseId = [];
  List<int> ingredientId = [];
  List<int> strength = [];
  List<int> flavorId = [];
  List<int> moodId = [];
  List<int> weatherId = [];
  List<int> ornamentId = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    buildTabView(
                        name: "베이스 술을", item: baseList, controllerList: baseId),
                    buildTabView(
                        name: "재료를",
                        item: baseList,
                        controllerList: ingredientId),
                    buildTabView(
                        name: "도수를", item: baseList, controllerList: strength),
                    buildTabView(
                        name: "맛을", item: baseList, controllerList: weatherId),
                    buildTabView(
                        name: "무드나 기분을",
                        item: baseList,
                        controllerList: moodId),
                    buildTabView(
                        name: "날씨나 계절을",
                        item: baseList,
                        controllerList: weatherId),
                    buildTabView(
                        name: "가니쉬를",
                        item: baseList,
                        controllerList: ornamentId),
                  ]),
                )
              ],
            ),
          )),
    );
  }

  Widget buildTabView(
      {required String name,
      required List<String> item,
      required List<int> controllerList}) {
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
        SizedBox(
          height: 200,
          child: GridView(
            shrinkWrap: true,
            children: [
              /* 아이템 리스트에서 꺼내옴 */
              for (int i = 0; i < item.length; ++i)
                GestureDetector(
                  onTap: () => {
                    setState(() {
                      if (controllerList.contains(i)) {
                        controllerList.remove(i);
                      } else {
                        controllerList.add(i);
                      }
                      print(controllerList); //
                    })
                  },
                  child: (Column(
                    children: [
                      AnimatedContainer(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 64,
                        decoration: BoxDecoration(
                            color: const Color(0xff474747),
                            shape: BoxShape.circle,
                            border: controllerList.contains(i)
                                ? Border.all(
                                    color: const Color(0xffce6228), width: 1)
                                : null),
                        duration: const Duration(milliseconds: 200),
                      ),
                      Text(baseList[i]),
                    ],
                  )),
                ),
            ],
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 74,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 10),
          ),
        ),
        const Expanded(
          child: Text(""),
        ),
        /* 설명 칸 */
        Center(
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFDA6C31),
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: const Color(0xFF1E1E1E),
            ),
            padding: const EdgeInsets.fromLTRB(29, 20, 29, 20),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "위스키",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "엿기름 또는 곡류 따위를 효모로 알코올 발효하여 증류하고, 오크통에 저장하여 숙성한 술.",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ]),
          ),
        ),
        /* 하단 버튼 */
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 54),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CupertinoButton(
                    padding: const EdgeInsets.all(19),
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
                    padding: const EdgeInsets.all(19),
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
