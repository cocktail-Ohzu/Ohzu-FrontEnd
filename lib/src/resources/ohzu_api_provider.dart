import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Request, Response;
import 'package:ohzu/src/models/detail_model.dart';
import 'package:ohzu/src/models/search_model.dart';
import 'package:ohzu/src/models/todays_cocktail_model.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/models/recommend_model.dart';

class OhzuApiProvider {
  Client client = Client();
  final String _baseurl = "https://ohzu.xyz";

  Future<TodaysCocktailModel> fetchTodaysCocktail() async {
    final url = Uri.parse("$_baseurl/main");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TodaysCocktailModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Failed to load TodaysCocktail");
    }
  }

  Future<DetailModel> fetchDetail(int detailId) async {
    final url = Uri.parse("$_baseurl/cocktails/$detailId");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return DetailModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Failed to load details of cocktail $detailId");
    }
  }

  Future<List<SearchModel>> fetchSearchItem() async {
    final url = Uri.parse("$_baseurl/search");
    final response = await client.get(url);
    List jsonData;
    List<SearchModel> ret = [];

    if (response.statusCode == 200) {
      jsonData = json.decode(utf8.decode(response.bodyBytes)); //Json List
      for (var elem in jsonData) {
        ret.add(SearchModel.fromJson(elem)); //parse Json List
      }
      return ret;
    } else {
      throw Exception("Failed to load SearchItem");
    }
  }

  Future<IngredientModel> fetchIngredientItem() async {
    final url = Uri.parse("$_baseurl/recommend");
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return IngredientModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Failed to load Ingredients for selection");
    }
  }

  Future<RecommendModel> fetchRecommendItem(List<List<int>> itemList) async {
    print("called"); //

    final List<String> name = [
      "base_id",
      "ingredient_id",
      "strength",
      "flavor_id",
      "mood_id",
      "weather_id",
      "ornament_id"
    ];
    Map<String, List<int>> body = {};
    final url = Uri.parse("$_baseurl/recommend");

    try {
      for (int i = 0; i < name.length; ++i) {
        if (i < itemList.length && itemList[i].isNotEmpty) {
          var a = <String, List<int>>{name[i]: itemList[i]};
          body.addAll(a);
        }
      }
    } catch (err) {
      print(err);
    }

    print(body);
    print(json.encode(body));

    final response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(body));

    print("response = ${response.body}");

    if (response.statusCode == 200) {
      print(response); //
      return RecommendModel.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } else {
      print(
          "status code: ${response.statusCode} failed to load recommend : ${response.body}"); //
      throw Exception("Failed to load Recommend");
    }
  }
}
