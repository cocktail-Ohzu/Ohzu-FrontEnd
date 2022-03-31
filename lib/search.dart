import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Search extends SearchDelegate<String> {
  final dummyData = [
    "진",
    "진 토닉",
    "진 토닉토닉 진",
    "토닉 진",
    "지아이조",
    "진 장인",
  ];

  final suggestions = ["검색", "기능", "따라하기", "힘들어", "살려줘"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.abc),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Card(child: Text(query)),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suggestions
        : dummyData.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.no_drinks),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
