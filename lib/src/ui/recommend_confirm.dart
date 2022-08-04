import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/ui/recommend_result.dart';

class RecommendConfirm extends StatefulWidget {
  const RecommendConfirm({Key? key, required this.itemList}) : super(key: key);

  final List<List<IngredientElement>> itemList;
  @override
  _RecommendConfirmState createState() =>
      _RecommendConfirmState(itemList: itemList);
}

class _RecommendConfirmState extends State<RecommendConfirm> {
  final List<List<IngredientElement>> itemList;
  final List<String> title = ["기본 술", "추가 재료", "도수", "맛", "무드&기분", "날씨", "가니쉬"];

  @override
  void initState() {
    super.initState();
  }

  _RecommendConfirmState({required this.itemList});

  bool isItemListEmpty() {
    for (var list in itemList) {
      if (list.isNotEmpty) {
        return false;
      }
    }
    return true;
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
            actions: []),
        body: Container(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: buildSelectedItemContainer()),
      ),
    );
  }

  Widget buildSelectedItemContainer() {
    return Column(
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
                Text(
                  isItemListEmpty() ? "선택한 내역이 아직 없어요!" : "아래 선택 내역으로",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                      isItemListEmpty()
                          ? "나만의 칵테일을 만들러 가볼까요?"
                          : "칵테일 추천을 진행할까요?",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                )
              ]),
        ),

        /* 중앙 박스 */
        isItemListEmpty()
            ? //아무것도 선택안함
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text("선택 내역이 없습니다"),
                ),
              )
            : //선택한 태그 리스트
            Container(
                // constraints: BoxConstraints(
                //   maxHeight: MediaQuery.of(context).size.height / 2,
                // ), //가변 크기
                height: 320, //고정크기
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFDA6C31),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: const Color(0xFF1E1E1E),
                ),
                padding: const EdgeInsets.fromLTRB(33, 20, 30, 20),
                margin: const EdgeInsets.fromLTRB(0, 28, 0, 24),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(), //scroll bouncing 제거
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* 아이템 태그 리스트 */
                      for (int i = 0; i < title.length; ++i)
                        if (itemList[i].isNotEmpty)
                          buildSelectedItemLine(
                              title: title[i], itemList: itemList[i]),
                    ],
                  ),
                ),
              ),

        /* 하단 버튼 */
        Expanded(
          child: Container(
            height: 196,
            margin: const EdgeInsets.only(bottom: 65),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isItemListEmpty()
                      ? CupertinoButton(
                          padding: const EdgeInsets.all(16),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          color: const Color(0xffDA6C31),
                          child: const Text(
                            "만들러 가기",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () => Navigator.of(context).pop())
                      : buildConfirmButton(),
                  isItemListEmpty()
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0)),
                            ),
                            onPressed: () =>
                                openRecommendResultPage(context, itemList),
                            child: const Text(
                              "랜덤으로 추천 받을게요",
                              style: TextStyle(
                                  color: Color(0xffDA6C31),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      : buildReturnButton(),
                ]),
          ),
        ),
      ],
    );
  }

  /* 선택한 아이템 태그로 미리보여주기 */
  Widget buildSelectedItemLine(
      {required String title, required List<IngredientElement> itemList}) {
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          /* 타이틀 */
          Container(
            margin: const EdgeInsets.fromLTRB(0, 11, 12, 0),
            alignment: Alignment.topRight,
            width: 65,
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
          /* 선택 내역 */
          Expanded(
              child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (int i = 0; i < itemList.length; ++i)
                buildTagItem(
                    text: itemList[i].name!,
                    color: Color(int.parse("0xff${itemList[i].tagColor!}"))),
            ],
          )),
        ],
      ),
    );
  }

  /* 태그 블록 위젯 */
  Widget buildTagItem({required String text, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.fromLTRB(11, 7, 11, 7),
      margin: const EdgeInsets.fromLTRB(8, 5, 0, 5),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
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
      margin: const EdgeInsets.fromLTRB(0, 14, 0, 0),
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

void openRecommendConfirmPage(
    BuildContext context, List<List<IngredientElement>> itemList) {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => RecommendConfirm(itemList: itemList),
    ),
  );
}
