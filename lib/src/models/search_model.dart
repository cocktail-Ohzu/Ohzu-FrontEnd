import 'package:http/http.dart' as http;
import 'dart:convert';

/* 검색 데이터 모델 (리스트) */
const String URL = "https://ohzu.xyz";

class SearchModel {
  int? id;
  String? name;
  String? img;
  String? backgroundColor;
  String? bases;
  String? flavors;
  String? moods;
  String? ornaments;
  String? ingredients;
  String? weathers;

  SearchModel(
      {this.id,
      this.name,
      this.img,
      this.backgroundColor,
      this.bases,
      this.flavors,
      this.moods,
      this.ornaments,
      this.ingredients,
      this.weathers});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    backgroundColor = json['background_color'];
    bases = json['bases'];
    flavors = json['flavors'];
    moods = json['moods'];
    ornaments = json['ornaments'];
    ingredients = json['ingredients'];
    weathers = json['weathers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
      'background_color': backgroundColor,
      'bases': bases,
      'flavors': flavors,
      'moods': moods,
      'ornaments': ornaments,
      'ingredients': ingredients,
      'weathers': weathers
    };
    return data;
  }
}

Future<List> fetchSearchItem() async {
  final url = Uri.parse("$URL/search");
  final response = await http.get(url);
  List jsonData;
  List<SearchModel> ret = [];

  if (response.statusCode == 200) {
    jsonData = json.decode(utf8.decode(response.bodyBytes)); //Json List
    for (var elem in jsonData) {
      ret.add(SearchModel.fromJson(elem)); //parse Json List
    }
    return ret;
  } else {
    throw Exception("Failed to load SearchData");
  }
}
