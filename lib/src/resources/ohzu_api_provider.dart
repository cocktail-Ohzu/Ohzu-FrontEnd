import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Request, Response;
import 'package:ohzu/src/models/detail_model.dart';
import 'package:ohzu/src/models/search_model.dart';
import 'package:ohzu/src/models/todays_cocktail_model.dart';
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
    Map<String, String> header = {};
    final url = Uri.parse("$_baseurl/recommend");

    try {
      for (int i = 0; i < name.length; ++i) {
        if (i < itemList.length && itemList[i].isNotEmpty) {
          var a = <String, String>{name[i]: itemList[i].toString()};
          header.addAll(a);
        }
      }
    } catch (err) {
      print(err);
    }

    final request = Request('GET', url);
    //request.body = header.toString();
    request.body = '{base_id: [1, 3, 4, 5], mood_id: [1, 4]}';
    final streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    print(request);
    print(request.method);
    print(request.headers);
    print(request.body);

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
