import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Detail> {
  /* 레시피 자동 스크롤 함수 */
  final GlobalKey expansionTileKey = GlobalKey();
  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 400)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 400));
      });
    }
  }

  final String drinkKo = "미도리 사워";
  final String drinkEn = "Midori Sour";
  final String description = "90년대를 휩쓸었던 전설의 그 칵테일!";
  final int strength = 20;
  bool recipeExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              // Container(
              //   margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
              //   child: IconButton(
              //     onPressed: () {},
              //     splashRadius: 18,
              //     icon: const Icon(
              //       Icons.search,
              //       size: 25,
              //     ),
              //     color: Colors.white.withOpacity(0.6),
              //   ),
              // )
            ]),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: double.infinity,
                height: 388,
                decoration: const BoxDecoration(
                  color: Color(0xffF08FA4),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(240, 143, 164, 0.4),
                        blurRadius: 28)
                  ],
                ),
                child: const Image(
                    image: AssetImage('asset/images/image 58.png'),
                    fit: BoxFit.cover)),
            Container(
                margin: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* 첫째줄 */
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "미도리 사워",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          /* Vertical Divider */
                          Container(
                            color: Color(0xFF999999),
                            height: 20,
                            width: 1,
                            margin: const EdgeInsets.fromLTRB(12, 3, 12, 0),
                          ),
                          const Text(
                            "Midori Sour",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF999999),
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ]),
                    /* 둘째줄 */
                    Text("90년대를 휩쓸었던 전설의 그 칵테일!",
                        style: TextStyle(
                          height: 1.7,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.85),
                        )),
                    const SizedBox(
                      height: 28,
                    ),
                    /* 셋째줄 */
                    Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color(0xFFDA6C31),
                        ),
                        child: Text(
                          "$drinkKo의 도수는 $strength도 입니다",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )),
                  ],
                )),

            /* 중간 디바이드 바 */
            const Divider(
              color: Color(0xFF1E1E1E),
              thickness: 12,
            ),

            /* 태그 */
            Container(
                margin: const EdgeInsets.fromLTRB(24, 50, 24, 16),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "이 칵테일은,",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),

                    /* 태그 및 설명 */
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFDA6C31),
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Color(0xFF1E1E1E),
                      ),
                      padding: const EdgeInsets.fromLTRB(23, 23, 23, 23),
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 24),
                      child: Column(
                        children: [
                          /* 맛 태그 */
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildTagItem(
                                  context: context,
                                  text: "상큼한",
                                  color: const Color(0xFFDA6C31)),
                              buildTagItem(
                                  context: context,
                                  text: "달달한",
                                  color: const Color(0xFFF08FA4)),
                              Container(
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                                child: Text(
                                  "맛이 나요.",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                              ),
                            ],
                          ),

                          /* 분위기 태그 */
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildTagItem(
                                    context: context,
                                    text: "밝은",
                                    color: const Color(0xFFFFD233)),
                                buildTagItem(
                                    context: context,
                                    text: "청량한",
                                    color: const Color(0xFFABEDE1)),
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                                  child: Text(
                                    "분위기로,",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /* 날씨 태그 */
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 8),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                buildTagItem(
                                    context: context,
                                    text: "봄",
                                    color: const Color(0xFFF08FA4)),
                                buildTagItem(
                                    context: context,
                                    text: "여름",
                                    color: const Color(0xFFABEDE1)),
                                buildTagItem(
                                    context: context,
                                    text: "맑은",
                                    color: const Color(0xFF8DD6FF)),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                  child: Text(
                                    "날에 어울려요.",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /* 가니쉬 텍스트 */
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Text(
                              "자주 올라가는 장식으로는",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          ),

                          /* 가니쉬 태그 */
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildTagItem(
                                    context: context,
                                    text: "레몬",
                                    color: const Color(0xFFFFD233)),
                                buildTagItem(
                                    context: context,
                                    text: "체리",
                                    color: const Color(0xFFDA6C31)),
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                  child: Text(
                                    "등이 있어요.",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /* 오쥬 포인트 */
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 96),
                      child: Text.rich(TextSpan(
                        children: [
                          const TextSpan(
                              text: "Ohzù point! ",
                              style: TextStyle(
                                  color: Color(0xFFDA6C31),
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                              text:
                                  "사워(Sour)는 '신', '시큼한'의 의미로, 미도리 사워는 증류주에 산미와 단맛을 더해 만든 칵테일입니다. \n나라에 따라 소다수의 용량에 차이가 있어, 소다수를 사용하지 않는 경우와 레몬 주스와 설탕을 사용해 새콤달콤한 맛을 내며 청량감을 주는 경우가 있습니다. 다양한 증류주나 리큐어를 사용하여 여러 가지 사워 칵테일을 만들 수 있어요.",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  height: 1.7,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300))
                        ],
                      )),
                    ),

                    /* 레시피 익스펜션 타일 */
                    ExpansionTile(
                      tilePadding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                      trailing: const Text(""),
                      key: expansionTileKey,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: const Text(
                              "레시피",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Icon(
                            recipeExpanded
                                ? Icons.keyboard_arrow_up_sharp
                                : Icons.keyboard_arrow_down_sharp,
                            size: 30,
                            color: Colors.white,
                          ), //solid arrow
                        ],
                      ),
                      /* 숨겨진 내용들 */
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "필요한 재료",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 44),
                            child: Row(
                              children: [
                                /* 칵테일 이미지 */
                                Container(
                                  width: 115,
                                  height: 271,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffF08FA4),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: const Image(
                                      image: AssetImage(
                                          'asset/images/image 58.png'),
                                      fit: BoxFit.cover),
                                ),
                                /* 칵테일 재료들 */
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      buildIngrediantItem(
                                          context: context,
                                          name: "미도리",
                                          description: "멜론 리큐어",
                                          ratio: "1/4",
                                          isDrink: true),
                                      buildIngrediantItem(
                                          context: context,
                                          name: "스윗 앤 사워 믹스",
                                          description: "비알콜성 칵테일 부재료",
                                          ratio: "1/4",
                                          isDrink: false),
                                      buildIngrediantItem(
                                          context: context,
                                          name: "스프라이트",
                                          description: "탄산 음료 (사이다)",
                                          ratio: "2/4",
                                          isDrink: false),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                      onExpansionChanged: (bool isExpanded) {
                        setState(() => recipeExpanded = isExpanded);
                        /* 자동 스크롤 */
                        _scrollToSelectedContent(
                            expansionTileKey: expansionTileKey);
                      },
                    )
                  ],
                ))
          ],
        )));
  }
}

Widget buildTagItem(
    {required BuildContext context,
    required String text,
    required Color color}) {
  return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.fromLTRB(11, 7, 11, 7),
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
      ));
}

//
Widget buildIngrediantItem(
    {required BuildContext context,
    required String name,
    required String description,
    required String ratio,
    required bool isDrink}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name + " 💧",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          description,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w100,
              color: Colors.white.withOpacity(0.8)),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ratio,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w100,
              ),
            ),
            if (isDrink)
              Container(
                padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: const Color(0xFFDA6C31)),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                alignment: Alignment.bottomRight,
                child: const Text(
                  "칵테일 한 잔 기준",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Color(0xFFDA6C31)),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
