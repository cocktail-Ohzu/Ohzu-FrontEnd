import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohzu/src/blocs/todays_cocktail_bloc/todays_cocktail_bloc.dart';
import 'package:ohzu/src/models/todays_cocktail_model.dart';
import 'package:ohzu/src/ui/detail.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /* 메인 페이지 API 받아오는 객체 */
  final todaysCocktailbloc = TodaysCocktailBloc();
  @override
  void initState() {
    super.initState();
    /* bloc 객체에 메인 페이지 API fetching */
    todaysCocktailbloc.add(LoadTodaysCocktailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => todaysCocktailbloc,
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
              //middle: Text(widget.title),
              actions: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/search');
                    },
                    splashRadius: 18,
                    icon: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                    color: Colors.white.withOpacity(0.6),
                  ),
                )
              ]),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /* 추천 칵테일 타이틀 */
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "오늘의 추천 칵테일",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    ),

                    /* 추천 칵테일 컨테이너 */
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child:
                          BlocBuilder<TodaysCocktailBloc, TodaysCocktailState>(
                              builder: (context, state) {
                        if (state is TodaysCocktailLoadingState) {
                          return Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(240, 143, 164, 0.4),
                                    blurRadius: 28)
                              ],
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(255, 172, 190, 1),
                                  Color.fromRGBO(255, 241, 244, 0.06),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.white.withOpacity(0.5),
                            )),
                          );
                        } else if (state is TodaysCocktailLoadedState) {
                          return buildCocktailContainer(
                              context, state.todaysCocktail);
                        }
                        if (state is TodaysCocktailErrorState) {
                          return const Text("snapshot is empty");
                        }
                        return Container();
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /* 하단 버튼 1 */
                    buildGetRecommendButton(context),
                    const SizedBox(
                      height: 10,
                    ),
                    /* 하단 버튼 2 */
                    BlocBuilder<TodaysCocktailBloc, TodaysCocktailState>(
                        builder: (context, state) {
                      if (state is TodaysCocktailLoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.transparent,
                        ));
                      } else if (state is TodaysCocktailLoadedState) {
                        return buildShowDetailButton(
                            context, state.todaysCocktail.id!);
                      }
                      if (state is TodaysCocktailErrorState) {
                        return const Text("snapshot is empty");
                      }
                      return Container();
                    }),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

@override
Widget buildCocktailContainer(
    BuildContext context, TodaysCocktailModel cocktail) {
  return Stack(
    // alignment: Alignment.bottomLeft,
    children: [
      /* 추천 칵테일 이미지 */
      Container(
        decoration: BoxDecoration(
          color: Color(int.parse("0xff${cocktail.backgroundColor}")),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                //color: Color.fromRGBO(240, 143, 164, 0.4),
                color: Color(int.parse("0xff${cocktail.backgroundColor}"))
                    .withOpacity(0.4),
                blurRadius: 28)
          ],
        ),
        child: cocktail.img != null && cocktail.img!.isNotEmpty
            ? Image.network(cocktail.img!, fit: BoxFit.cover)
            : Image.asset('asset/images/default.png', fit: BoxFit.cover),
      ),

      /* 추천 칵테일 텍스트 */
      Container(
          // margin: const EdgeInsets.fromLTRB(24, 21, 24, 25),
          margin: const EdgeInsets.fromLTRB(7, 7, 7, 7),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 마진 띄우기 용 정사각 컨테이너 */
              LayoutBuilder(
                builder: (context, constraints) {
                  final size = min(constraints.maxWidth, constraints.maxHeight);
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: size * 1.04792332,
                      width: size,
                      // color: Colors.amber.withOpacity(0.4),
                    ),
                  );
                },
              ),

              /* 첫째줄 */
              Container(
                margin: const EdgeInsets.fromLTRB(17, 21, 17, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          cocktail.name.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                cocktail.name.toString().length > 7 ? 21 : 24,
                            color: Colors.white,
                          ),
                        ),
                        /* Vertical Divider */
                        Container(
                          color: Colors.white.withOpacity(0.6),
                          height: 22,
                          width: 1,
                          margin: const EdgeInsets.fromLTRB(12, 3, 12, 0),
                        ),
                        Text(
                          cocktail.engName.toString(),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.6),
                            fontSize: cocktail.engName.toString().length > 18
                                ? 13
                                : 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    /* 둘째줄 */
                    Text(
                      cocktail.desc.toString(),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        height: 1.5,
                        // fontSize: cocktail.desc!.length < 25 ? 18 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    /* 셋째줄 */
                    Text(
                      "alcohol ${cocktail.strength.toString()}%",
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFDA6C31),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    ],
  );
}

/* 다른 칵테일 추천 받기 버튼 */
@override
Widget buildGetRecommendButton(BuildContext context) {
  return CupertinoButton(
    padding: const EdgeInsets.all(19),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    color: const Color(0xffDA6C31),
    child: const Text(
      "나에게 맞는 칵테일로 추천 받을래요",
      style: TextStyle(
          color: Color(0xffffffff), fontSize: 14, fontWeight: FontWeight.w400),
    ),
    onPressed: () {
      Navigator.of(context).pushNamed('/recommend');
    },
  );
}

/* 자세한 정보 보기 버튼 */
@override
Widget buildShowDetailButton(BuildContext context, int id) {
  return TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
    onPressed: () => openDetailPage(context, id),
    child: const Text(
      "자세한 정보가 궁금해요",
      style: TextStyle(
          color: Color(0xffDA6C31), fontSize: 14, fontWeight: FontWeight.w400),
    ),
  );
}
