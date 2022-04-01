import 'package:http/http.dart' as http;
import 'dart:convert';

/* 칵테일 상세 정보 모델 */
const String URL = "https://ohzu.xyz";

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
