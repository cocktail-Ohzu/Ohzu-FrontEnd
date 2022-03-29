/*
Dart 에서는 JSON 형식을 class 로 직렬화 해주어야 한다
이 파일은 직렬화된 모델(class)들을 모아놓은 것

JSON to dart
https://javiercbk.github.io/json_to_dart/

API 명세
https://www.notion.so/1-API-9eede01a48ca4bc5b6ffeceab8e773bc

*/

import 'package:http/http.dart' as http;
import 'dart:convert';

final String URL = "https://ohzu.xyz";

/* 메인 페이지 오늘의 추천 칵테일 모델 */
class TodaysCocktail {
  int? id;
  String? img;
  String? name;
  String? engName;
  String? desc;
  int? strength;

  TodaysCocktail(
      {this.id, this.img, this.name, this.engName, this.desc, this.strength});

  TodaysCocktail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    engName = json['eng_name'];
    desc = json['desc'];
    strength = json['strength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['eng_name'] = this.engName;
    data['desc'] = this.desc;
    data['strength'] = this.strength;
    return data;
  }
}

Future<TodaysCocktail> fetchTodaysCocktail() async {
  final url = Uri.parse("$URL/main");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return TodaysCocktail.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load TodaysCocktail");
  }
}
