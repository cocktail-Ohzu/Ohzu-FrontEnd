import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohzu/src/models/recommend_model.dart';
import 'package:ohzu/src/blocs/recommend_bloc/recommend_bloc.dart';

import 'detail.dart';

class RecommendResult extends StatefulWidget {
  const RecommendResult({Key? key, required this.itemList}) : super(key: key);
  final List<List<int>> itemList;

  @override
  _RecommendResultState createState() =>
      _RecommendResultState(itemList: itemList);
}

class _RecommendResultState extends State<RecommendResult> {
  late RecommendBloc bloc;
  final List<List<int>> itemList;

  final List<List<int>> dummyList = [
    [1, 3, 4, 5],
    [],
    [],
    [],
    [1, 4],
    [],
    []
  ];

  @override
  void initState() {
    super.initState();
    bloc = RecommendBloc(dummyList);
    bloc.add(LoadRecommendEvent());
  }

  /* BloC 주입 */
  _RecommendResultState({required this.itemList});

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
        body: BlocProvider(
            create: (_) => bloc,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /* 상단 텍스트 */

                  BlocBuilder<RecommendBloc, RecommendState>(
                      builder: (context, state) {
                    if (state is RecommendLoadingState) {
                      return CircularProgressIndicator(
                        color: Colors.white.withOpacity(0.5),
                      );
                    } else if (state is RecommendLoadedState) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "당신을 위한 오늘의 칵테일은",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text("${state.recommend.name} 네요!",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 20)),
                              )
                            ]),
                      );
                    }
                    if (state is RecommendErrorState) {
                      return const Text("snapshot is empty");
                    }
                    return Container();
                  }),

                  /* 하단 박스 */

                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: const Text("이런 칵테일은 어때요?",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                            Row(
                              children: [
                                BlocBuilder<RecommendBloc, RecommendState>(
                                    builder: (context, state) {
                                  if (state is RecommendLoadingState) {
                                    return CircularProgressIndicator(
                                      color: Colors.white.withOpacity(0.5),
                                    );
                                  } else if (state is RecommendLoadedState) {
                                    return Center(
                                      child: Text("done"),
                                    );
                                  }
                                  if (state is RecommendErrorState) {
                                    return const Text("snapshot is empty");
                                  }
                                  return Container();
                                }),
                              ],
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildSimilarCocktailCards(int id, String name, String imgUrl) {
    final int len = 5;
    List<Widget> ret = [];

    for (int i = 0; i < len; ++i) {
      ret.add(
        GestureDetector(
          onTap: () {
            openDetailPage(context, id);
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xff1e1e1e),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.topCenter,
                child: Image.network(imgUrl, fit: BoxFit.cover),
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
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )),
            ]),
          ),
        ),
      );
    }

    return GridView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      children: [for (int i = 0; i < ret.length; ++i) ret[i]],
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 220,
          crossAxisCount: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 12),
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

  Widget buildCocktailContainer(int id, String name, String imgUrl) {
    return Container(
        margin: const EdgeInsets.all(1.5),
        decoration: const BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.all(Radius.circular(11.5)),
        ),
        child: Column(
          children: [
            /* 추천 칵테일 이미지 */
            Container(
                margin: const EdgeInsets.fromLTRB(7, 7, 7, 0),
                width: double.infinity,
                height: 328,
                decoration: const BoxDecoration(
                  //color: Color(int.parse("0xff${cocktail.backgroundColor}")),
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Image.network(imgUrl, fit: BoxFit.cover)),

            /* 추천 칵테일 텍스트 */
            Container(
                margin: const EdgeInsets.fromLTRB(25, 21, 25, 5),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(16),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: const Color(0xff1e1e1e),
                  child: const Text(
                    "상세 정보 보러가기",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () => openDetailPage(context, id),
                )),
          ],
        ));
  }
}

void openRecommendResultPage(BuildContext context, List<List<int>> itemList) {
  Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RecommendResult(itemList: itemList),
      ));
}
