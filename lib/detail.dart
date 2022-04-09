import 'package:flutter/material.dart';
import 'model/details.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _DetailState createState() => _DetailState(id: id);
}

class _DetailState extends State<Detail> {
  _DetailState({required this.id});
  final String id;

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

  bool recipeExpanded = false;
  //레시피 스크롤바 컨트롤러
  final ScrollController _recipeScrollController = ScrollController();
  /* API Fetching */
  late Future<Details> details;
  @override
  void initState() {
    super.initState();
    /* 메인 페이지 API fetching */
    details = fetchDetails(id: id);

    details.then((value) {
      print("Cocktail Details #$id Sucessfully Fetched!\n");
    });
  }

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
          child: FutureBuilder<Details>(
              future: details,
              builder: (context, AsyncSnapshot<Details> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        if (snapshot.data?.info != null)
                          buildCocktailImg(
                            context: context,
                            img: snapshot.data?.info?.img,
                            color: snapshot.data?.info?.backgroundColor,
                          ),
                        buildCocktailName(
                            context: context,
                            koName: snapshot.data?.info?.name,
                            enName: snapshot.data?.info?.engName,
                            desc: snapshot.data?.info?.desc,
                            strength: snapshot.data?.info?.strength),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    color: Color(0xFF1E1E1E),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 23, 23, 23),
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 24),
                                  child: Column(
                                    children: [
                                      /* 맛 태그 */
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            margin: const EdgeInsets.fromLTRB(
                                                4, 0, 0, 4),
                                            child: Text(
                                              "맛이 나요.",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ],
                                      ),

                                      /* 분위기 태그 */
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              margin: const EdgeInsets.fromLTRB(
                                                  4, 0, 0, 4),
                                              child: Text(
                                                "분위기로,",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                        .withOpacity(0.7)),
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
                                                  const EdgeInsets.fromLTRB(
                                                      0, 6, 0, 0),
                                              child: Text(
                                                "날에 어울려요.",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                        .withOpacity(0.7)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /* 가니쉬 텍스트 */
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 15, 0, 15),
                                        child: Text(
                                          "자주 올라가는 장식으로는",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white
                                                  .withOpacity(0.7)),
                                        ),
                                      ),

                                      /* 가니쉬 태그 */
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              margin: const EdgeInsets.fromLTRB(
                                                  4, 0, 0, 0),
                                              child: Text(
                                                "등이 있어요.",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                        .withOpacity(0.7)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /* 오쥬 포인트 */
                                buildOhzuPoint(
                                    context: context,
                                    description:
                                        snapshot.data?.info?.ohzuPoint),

                                /* 레시피 익스펜션 타일 */
                                ExpansionTile(
                                  tilePadding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                  trailing: const Text(""),
                                  key: expansionTileKey,
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    buildIngredients(
                                        context: context,
                                        img: snapshot.data?.info?.img,
                                        scrollController:
                                            _recipeScrollController,
                                        ingredients:
                                            snapshot.data?.ingredients),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "제조 방법",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        "미도리 : 스윗 앤 사워 믹스 : 스프라이트 = 1 : 1 : 2",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ),
                                    /* 제조 방법 */
                                    buildRecipe(
                                        context: context,
                                        rawRecipe: snapshot.data?.info?.recipe),
                                    const SizedBox(
                                      height: 122,
                                    ),
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
                    );
                  } else {
                    return const Text("snapshot is empty");
                  }
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("detail snapshot Error");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}

/* 최상단 칵테일 위젯 */
Widget buildCocktailImg({
  required BuildContext context,
  required String? img,
  required String? color,
}) {
  if (img == null || color == null) return const Text("파라미터 값 오류입니다");
  return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: double.infinity,
      height: 388,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
        color: Color(int.parse("0xf$color")),
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        boxShadow: const [
          BoxShadow(color: Color.fromRGBO(240, 143, 164, 0.4), blurRadius: 28)
        ],
      ));
}

/* 칵테일 이름 및 도수 위젯 */
Widget buildCocktailName(
    {required BuildContext context,
    required String? koName,
    required String? enName,
    required String? desc,
    required int? strength}) {
  if (koName == null || enName == null || desc == null || strength == null) {
    return const Text("파라미터 값 오류입니다");
  }
  return Container(
      margin: const EdgeInsets.fromLTRB(24, 32, 24, 28),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* 첫째줄 */
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              koName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            /* Vertical Divider */
            Container(
              color: const Color(0xFF999999),
              height: 20,
              width: 1,
              margin: const EdgeInsets.fromLTRB(12, 3, 12, 0),
            ),
            Text(
              enName,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: Color(0xFF999999),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ]),
          /* 둘째줄 */
          Text(desc,
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
                "$koName의 도수는 $strength도 입니다",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )),
        ],
      ));
}

/* ohzu point 위젯 */
Widget buildOhzuPoint(
    {required BuildContext context, required String? description}) {
  if (description == null || description == "") return Text("");
  return /* 오쥬 포인트 */
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
            text: description,
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                height: 1.7,
                fontSize: 14,
                fontWeight: FontWeight.w300))
      ],
    )),
  );
}

/* 재료 사진 및 리스트 위젯 */
Widget buildIngredients(
    {required BuildContext context,
    required ScrollController scrollController,
    required String? img,
    required List? ingredients}) {
  if (img == null || ingredients == null) return const Text("");
  int listLength = ingredients.length;

  return IntrinsicHeight(
    child: Container(
        height: 270, //재료 스크롤을 위한 높이지정
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(0, 16, 0, 44),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /* 칵테일 이미지 */
            Container(
              width: 115,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.cover),
                color: const Color(0xffF08FA4),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
            /* 칵테일 재료들 */
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 0; i < listLength; ++i)
                        buildIngrediantItem(
                          context: context,
                          name: ingredients[i].ingredient,
                          description: "멜론 리큐어",
                          ratio: ingredients[i].amount,
                          //isDrink: true
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
  );
}

/* 레시피 리스트 위젯 */
Widget buildRecipe(
    {required BuildContext context, required String? rawRecipe}) {
  if (rawRecipe == null || rawRecipe == "") return const Text("");
  List<String> recipeList = rawRecipe.split("||");
  int recipeLength = recipeList.length;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (int i = 0; i < recipeLength; ++i)
        buildRecipeItem(
            context: context, number: i + 1, description: recipeList[i]),
    ],
  );
}

/* ******************** */
/* 각 아이템 생성 메소드 */
/* ******************** */

/* 태그 블록 위젯 */
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
Widget buildIngrediantItem({
  required BuildContext context,
  required String name,
  required String description,
  required String ratio,
  //required bool isDrink
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
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
            // if (isDrink)
            //   Container(
            //     padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(width: 1, color: const Color(0xFFDA6C31)),
            //         borderRadius: const BorderRadius.all(Radius.circular(8))),
            //     alignment: Alignment.bottomRight,
            //     child: const Text(
            //       "칵테일 한 잔 기준",
            //       textAlign: TextAlign.right,
            //       style: TextStyle(color: Color(0xFFDA6C31)),
            //     ),
            //   ),
          ],
        ),
      ],
    ),
  );
}

Widget buildRecipeItem(
    {required BuildContext context,
    required int number,
    required String description}) {
  return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            margin: const EdgeInsets.fromLTRB(0, 3, 12, 0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white,
            ),
            child: Text(
              number.toString(),
              style: const TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                description,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ));
}
