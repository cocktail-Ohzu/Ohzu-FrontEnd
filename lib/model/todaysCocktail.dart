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

const String URL = "https://ohzu.xyz";

/* 메인 페이지 오늘의 추천 칵테일 모델 */
class TodaysCocktail {
  int? id;
  String? img;
  String? backgroundColor;
  String? name;
  String? engName;
  String? desc;
  int? strength;

  TodaysCocktail(
      {this.id,
      this.img,
      this.backgroundColor,
      this.name,
      this.engName,
      this.desc,
      this.strength});

  TodaysCocktail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    backgroundColor = json['background_color'];
    name = json['name'];
    engName = json['eng_name'];
    desc = json['desc'];
    strength = json['strength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "img": img,
      "background_color": backgroundColor,
      "name": name,
      "eng_name": engName,
      "desc": desc,
      "strength": strength,
    };
    return data;
  }
}

Future<TodaysCocktail> fetchTodaysCocktail() async {
  final url = Uri.parse("$URL/main");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return TodaysCocktail.fromJson(
        json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception("Failed to load TodaysCocktail");
  }
}
