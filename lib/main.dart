import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ohzu',
      home: MyHomePage(title: '오쥬'),
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
        appBar: CupertinoNavigationBar(
            backgroundColor: Colors.transparent,
            border: const Border(bottom: BorderSide(color: Colors.transparent)),
            //middle: Text(widget.title),
            trailing: IconButton(
              onPressed: () {},
              //splashColor: Colors.transparent,
              splashRadius: 12,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
              color: Colors.white.withOpacity(0.6),
            )),
        body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
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
                        color: Colors.white,
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  ),

                  /* 추천 칵테일 컨테이너 */
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0.13, 0.0),
                          end: Alignment.bottomCenter,
                          stops: [
                            0.5,
                            0.8,
                            1
                          ],
                          colors: <Color>[
                            Color(0xFFF08FA4),
                            Color(0xff956570),
                            Color.fromRGBO(82, 82, 82, 0.6)
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    height: 460,
                    child: Column(
                      children: [
                        /* 추천 칵테일 이미지 */
                        Container(
                          margin: const EdgeInsets.fromLTRB(7, 7, 7, 0),
                          width: double.infinity,
                          height: 350,
                          decoration: const BoxDecoration(
                            color: Color(0xffF28093),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),

                        /* 추천 칵테일 텍스트 */
                        Container(
                            margin: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text.rich(TextSpan(
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(text: "미도리 사워"),
                                    TextSpan(
                                        text: " | ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 25,
                                        )),
                                    TextSpan(
                                        text: "Midori Sour",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 16,
                                        )),
                                  ],
                                )),
                                Text("90년대를 휩쓸었던 전설의 그 칵테일!",
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white.withOpacity(0.7),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text("alcohol 20%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color:
                                      Colors.deepOrangeAccent.withOpacity(0.8),
                                    )),
                              ],
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /* 하단 버튼 1 */
                  CupertinoButton(
                    color: const Color(0xffA35C65),
                    child: Text(
                      "자세한 정보가 궁금해요",
                      style: TextStyle(
                          color: const Color(0xffDCC5B6).withOpacity(0.8),
                          fontSize: 13,
                          fontWeight: FontWeight.w900),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /* 하단 버튼 2 */
                  CupertinoButton(
                    color: const Color(0xff351B1B),
                    child: const Text(
                      "나에게 맞는 칵테일로 추천 받을래요",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            )),
      ),
    );
  }
}