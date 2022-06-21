import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohzu/src/ui/recommend_result.dart';

class RecommendConfirm extends StatefulWidget {
  const RecommendConfirm({Key? key, required this.itemList}) : super(key: key);

  final List<List<int>> itemList;
  @override
  _RecommendConfirmState createState() =>
      _RecommendConfirmState(itemList: itemList);
}

class _RecommendConfirmState extends State<RecommendConfirm> {
  final List<List<int>> itemList;

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
  }

  _RecommendConfirmState({required this.itemList});

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
              actions: []),
          body: Container(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /* 상단 텍스트 */
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  alignment: Alignment.topLeft,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "아래 선택 내역으로",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: const Text("칵테일 추천을 진행할까요?",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20)),
                        )
                      ]),
                ),

                /* 중앙 박스 */
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFDA6C31),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: const Color(0xFF1E1E1E),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 25, 24, 25),
                  margin: const EdgeInsets.fromLTRB(0, 28, 0, 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(itemList.toString()),
                      ]),
                ),

                /* 하단 버튼 */
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildConfirmButton(),
                        buildReturnButton(),
                      ]),
                ),
              ],
            ),
          )),
    );
  }

//   Widget buildSelectedItem(List<List<int>> items){

//   }

//   Widget buildSelectedItemLine(String name, List<int> item){

//  if (item.isEmpty) return const Text("");
//   final int itemLength = item.length;

//   return Container(
//     margin: const EdgeInsets.only(top: 8),
//     alignment: Alignment.centerLeft,
//     child: Wrap(
//       alignment: WrapAlignment.start,
//       crossAxisAlignment: WrapCrossAlignment.center,
//       children: [
//         for (int i = 0; i < itemLength; ++i)
//           (buildTagItem(
//             context: context,
//             text: item[i].name.toString(),
//             color: Color(int.parse("0xff${item[i].tagColor.toString()}")),
//           )),
//       ],
//     ),
//   );

//   }

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

  /* 칵테일 추천 확정 버튼 */
  Widget buildConfirmButton() {
    return CupertinoButton(
      padding: const EdgeInsets.all(16),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: const Color(0xffDA6C31),
      child: const Text(
        "이걸로 추천 받을래요",
        style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
      onPressed: () => openRecommendResultPage(context, itemList),
    );
  }

  /* 취소 버튼 */
  Widget buildReturnButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 14, 0, 48),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
        ),
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          "다시 고를게요",
          style: TextStyle(
              color: Color(0xffDA6C31),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

void openRecommendConfirmPage(BuildContext context, List<List<int>> itemList) {
  Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RecommendConfirm(itemList: itemList),
      ));
}
