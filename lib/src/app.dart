import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohzu/src/ui/search.dart';
import 'package:ohzu/src/ui/recommend.dart';
import 'package:ohzu/src/ui/today.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: const MainPage(title: '오쥬'),
      onGenerateRoute: (route) => onGenerateRoute(route),
    );
  }

  /* 페이지 라우팅 */
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* Fade out & Fade in Animation */
      case '/search':
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return const SearchPage();
          },
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation.drive(Tween<double>(begin: 0.0, end: 1.0)
                  .chain(CurveTween(curve: Curves.linear))),
              child: child,
            );
          },
        );
      case '/recommend':
        return CupertinoPageRoute(
            builder: (context) => const Recommend(), settings: settings);
      case '/main':
      default:
        return CupertinoPageRoute(
            builder: (context) => const MainPage(title: 'ohzu'),
            settings: settings);
    }
  }
}
