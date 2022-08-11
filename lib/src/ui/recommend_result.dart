import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohzu/src/models/recommend_model.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/blocs/recommend_bloc/recommend_bloc.dart';

import 'detail.dart';

class RecommendResult extends StatefulWidget {
  const RecommendResult({Key? key, required this.itemList}) : super(key: key);
  final List<List<IngredientElement>> itemList;

  @override
  _RecommendResultState createState() =>
      _RecommendResultState(itemList: itemList);
}

class _RecommendResultState extends State<RecommendResult> {
  late RecommendBloc bloc;
  final List<List<IngredientElement>> itemList;

  @override
  void initState() {
    super.initState();
    bloc = RecommendBloc(itemList);
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
            leading: const Text(""),
            actions: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                alignment: Alignment.centerRight,
                child: IconButton(
                    iconSize: 24,
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              )
            ]),
        body: BlocProvider(
            create: (_) => bloc,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /* 상단 텍스트 */

                  BlocBuilder<RecommendBloc, RecommendState>(
                      builder: (context, state) {
                    if (state is RecommendLoadingState) {
                      return Container(
                        constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height / 1.3),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      );
                    } else if (state is RecommendLoadedState) {
                      /* 추천 칵테일이 존재할 경우 */
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      state.recommend.fitCocktails != null &&
                                              state.recommend.fitCocktails!
                                                  .isNotEmpty
                                          ? "당신을 위한 오늘의 칵테일은"
                                          : "일치하는 검색 결과가 없어요.",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(
                                          state.recommend.fitCocktails !=
                                                      null &&
                                                  state.recommend.fitCocktails!
                                                      .isNotEmpty
                                              ? "${state.recommend.fitCocktails![0].name} 네요!"
                                              : "유사한 칵테일을 추천해드릴게요!",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ]),
                            ),
                            if (state.recommend.fitCocktails != null &&
                                state.recommend.fitCocktails!.isNotEmpty)
                              buildCocktailContainer(
                                  state.recommend.fitCocktails![0])
                            else if (state.recommend.similarCocktails != null &&
                                state.recommend.similarCocktails!.isNotEmpty)
                              buildCocktailContainer(
                                  state.recommend.similarCocktails![0]),
                          ]);
                    }
                    if (state is RecommendErrorState) {
                      return const Text("서버 연결 오류");
                    }
                    return Container();
                  }),

                  /* 하단 박스 */

                  BlocBuilder<RecommendBloc, RecommendState>(
                      builder: (context, state) {
                    if (state is RecommendLoadingState) {
                      return Container();
                    } else if (state is RecommendLoadedState) {
                      return Expanded(
                          child: buildSimilarCocktailCards(state.recommend));
                    }
                    if (state is RecommendErrorState) {
                      return const Text("서버 연결 오류");
                    }
                    return Container();
                  }),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildCocktailContainer(RecommendCocktail? cocktail) {
    if (cocktail == null) {
      return const Center(
        child: Text("추천 결과가 없습니다"),
      );
    }
    final id = cocktail.id!;
    // final name = cocktail.name!;
    final imgUrl = cocktail.img2!;
    final backgroundColor = cocktail.backgroundColor!;

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
      decoration: BoxDecoration(
        color: Color(int.parse('0xff$backgroundColor')),
        borderRadius: const BorderRadius.all(Radius.circular(11.5)),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.fromLTRB(11, 11, 11, 11),
        height: 344,
        decoration: BoxDecoration(
          color: Color(int.parse("0xff$backgroundColor")),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(
            image: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset('asset/images/58.png', fit: BoxFit.cover);
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              },
            ).image,
          ),
        ),
        child: SizedBox(
          height: 52,
          child: CupertinoButton(
            minSize: double.infinity,
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
          ),
        ),
      ),
    );
  }

  Widget buildSimilarCocktailCards(RecommendModel cocktails) {
    List<RecommendCocktail> sc = [];
    sc += cocktails.fitCocktails ?? [];
    sc += cocktails.similarCocktails ?? [];
    final int len = sc.length;

    if (len == 0) {
      return const Text("");
    }

    List<Widget> ret = [];

    for (int i = 0; i < len; ++i) {
      ret.add(
        GestureDetector(
          onTap: () {
            openDetailPage(context, sc[i].id!);
          },
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xff1e1e1e),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              width: 98,
              height: 98,
              alignment: Alignment.topCenter,
              child: Image.network(
                sc[i].img2!,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset('asset/images/c.png', fit: BoxFit.cover);
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            /* 이미지
              Container(
                alignment: Alignment.topCenter,
                child: Image.network(list[i].img.toString(), fit: BoxFit.cover),
              ),
              */
            Container(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  sc[i].name!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14),
                )),
          ]),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text("이런 칵테일은 어때요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: SizedBox(
            height: 130,
            child: GridView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [for (int i = 0; i < ret.length; ++i) ret[i]],
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 0,
                  mainAxisExtent: 98,
                  mainAxisSpacing: 16),
            ),
          ),
        )
      ],
    );
  }
}

void openRecommendResultPage(
    BuildContext context, List<List<IngredientElement>> itemList) {
  Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RecommendResult(itemList: itemList),
      ));
}
