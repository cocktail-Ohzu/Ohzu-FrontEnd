import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './model.dart';
import './search.dart';
import './detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ohzu',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: '오쥬'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* 메인 페이지 API 받아오는 객체 */
  late Future<TodaysCocktail> todaysCocktail;

  @override
  void initState() {
    super.initState();
    /* 메인 페이지 API fetching */
    todaysCocktail = fetchTodaysCocktail();

    todaysCocktail.then((value) {
      print("Main Cocktail Sucessfully Fetched!\n");
    });
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
      child: FutureBuilder<TodaysCocktail>(
          future: todaysCocktail,
          builder: (context, AsyncSnapshot<TodaysCocktail> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return buildScaffold(context: context, cocktail: snapshot.data);
              } else {
                return const Text("snapshot is empty");
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Text("snapshot Error");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

/* 메인 페이지 위젯 빌드 */
Widget buildScaffold(
    {required BuildContext context, required TodaysCocktail? cocktail}) {
  if (cocktail == null) {
    return const Text("error");
  } else {
    return Scaffold(
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
                  showSearch(context: context, delegate: Search());
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
              height: 464,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color.fromRGBO(255, 172, 190, 1),
                    Color.fromRGBO(255, 241, 244, 0.06),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(240, 143, 164, 0.4), blurRadius: 28)
                ],
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                margin: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: const Alignment(0.10, 0.0),
                      end: Alignment.bottomCenter,
                      stops: const [
                        0.4,
                        0.8,
                        1
                      ],
                      colors: <Color>[
                        Color(int.parse("0xff${cocktail.backgroundColor}")),
                        Color(0xff956570),
                        Color.fromRGBO(82, 82, 82, 0.6)
                      ]),
                  borderRadius: const BorderRadius.all(Radius.circular(11.5)),
                ),
                child: Column(
                  children: [
                    /* 추천 칵테일 이미지 */
                    Container(
                        margin: const EdgeInsets.fromLTRB(7, 7, 7, 0),
                        width: double.infinity,
                        height: 328,
                        decoration: BoxDecoration(
                          color: Color(
                              int.parse("0xff${cocktail.backgroundColor}")),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Image.network(cocktail.img.toString(),
                            fit: BoxFit.cover)),

                    /* 추천 칵테일 텍스트 */
                    Container(
                        margin: const EdgeInsets.fromLTRB(25, 21, 25, 5),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* 첫째줄 */
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    cocktail.name.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  /* Vertical Divider */
                                  Container(
                                    color: Colors.white.withOpacity(0.6),
                                    height: 22,
                                    width: 1,
                                    margin:
                                        const EdgeInsets.fromLTRB(12, 3, 12, 0),
                                  ),
                                  Text(
                                    cocktail.engName.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                ]),
                            /* 둘째줄 */
                            Text(cocktail.desc.toString(),
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.85),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            /* 셋째줄 */
                            Text("alcohol ${cocktail.strength.toString()}%",
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFDA6C31),
                                )),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            /* 하단 버튼 1 */
            CupertinoButton(
              padding: const EdgeInsets.all(19),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: const Color(0xffDA6C31),
              child: const Text(
                "자세한 정보가 궁금해요",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Detail(id: cocktail.id.toString()),
                    ));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            /* 하단 버튼 2 */
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
              child: const Text(
                "나에게 맞는 칵테일로 추천 받을래요",
                style: TextStyle(
                    color: Color(0xffDA6C31),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
