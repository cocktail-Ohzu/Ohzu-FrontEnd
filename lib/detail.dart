import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Detail> {
  final String drinkKo = "미도리 사워";
  final String drinkEn = "Midori Sour";
  final String description = "90년대를 휩쓸었던 전설의 그 칵테일!";
  final int strength = 20;

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
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: IconButton(
                onPressed: () {},
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
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(7, 7, 7, 0),
                width: double.infinity,
                height: 328,
                decoration: const BoxDecoration(
                  color: Color(0xffF08FA4),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Image(
                    image: AssetImage('asset/images/image 58.png'),
                    fit: BoxFit.cover
                )
            ),

            Container(
                margin: const EdgeInsets.fromLTRB(24, 21, 24, 28),
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
                            color: Colors.white.withOpacity(0.6),
                            height: 20,
                            width: 1,
                            margin: const EdgeInsets.fromLTRB(12, 3, 12, 0),
                          ),
                          Text(
                            "Midori Sour",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ]
                    ),
                    /* 둘째줄 */
                    Text("90년대를 휩쓸었던 전설의 그 칵테일!",
                        style: TextStyle(
                          height: 1.5,
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
                      )
                    ),
                  ],
                )
            ),

            /* 중간 디바이드 바 */
            const Divider(
              color: Color(0xFF1E1E1E),
              thickness: 12,
            ),

            /* 태그 */
            Container(
              margin: const EdgeInsets.fromLTRB(24, 52, 24, 16),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "이 칵테일은,",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),

                  /* 태그 및 설명 */
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2,
                      )
                    ),
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }
}