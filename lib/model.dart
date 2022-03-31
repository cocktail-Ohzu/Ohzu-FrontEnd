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

/* 칵테일 상세 정보 모델 */

class Details {
  Info? info;
  List<Bases>? bases;
  List<Ingredients>? ingredients;

  Details({this.info, this.bases, this.ingredients});

  Details.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['bases'] != null) {
      bases = <Bases>[];
      json['bases'].forEach((v) {
        bases!.add(new Bases.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (bases != null) {
      data['bases'] = bases!.map((v) => v.toJson()).toList();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? id;
  String? name;
  String? backgroundColor;
  String? engName;
  String? img;
  String? desc;
  int? strength;
  List<String>? flavors;
  List<String>? moods;
  List<String>? weathers;
  List<String>? ornaments;
  String? recipe;
  String? ohzuPoint;

  Info(
      {this.id,
      this.name,
      this.backgroundColor,
      this.engName,
      this.img,
      this.desc,
      this.strength,
      this.flavors,
      this.moods,
      this.weathers,
      this.ornaments,
      this.recipe,
      this.ohzuPoint});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    backgroundColor = json['background_color'];
    engName = json['eng_name'];
    img = json['img'];
    desc = json['desc'];
    strength = json['strength'];
    flavors = json['flavors'].cast<String>();
    moods = json['moods'].cast<String>();
    weathers = json['weathers'].cast<String>();
    ornaments = json['ornaments'].cast<String>();
    recipe = json['recipe'];
    ohzuPoint = json['ohzu_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['background_color'] = backgroundColor;
    data['eng_name'] = engName;
    data['img'] = img;
    data['desc'] = desc;
    data['strength'] = strength;
    data['flavors'] = flavors;
    data['moods'] = moods;
    data['weathers'] = weathers;
    data['ornaments'] = ornaments;
    data['recipe'] = recipe;
    data['ohzu_point'] = ohzuPoint;
    return data;
  }
}

class Bases {
  String? base;
  String? desc;
  String? amount;

  Bases({this.base, this.desc, this.amount});

  Bases.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    desc = json['desc'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = base;
    data['desc'] = desc;
    data['amount'] = amount;
    return data;
  }
}

class Ingredients {
  String? ingredient;
  String? amount;

  Ingredients({this.ingredient, this.amount});

  Ingredients.fromJson(Map<String, dynamic> json) {
    ingredient = json['ingredient'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredient'] = ingredient;
    data['amount'] = amount;
    return data;
  }
}

Future<Details> fetchDetails({required String id}) async {
  final url = Uri.parse("$URL/cocktails/$id");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return Details.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception("Failed to load TodaysCocktail");
  }
}

/* 종료 */
