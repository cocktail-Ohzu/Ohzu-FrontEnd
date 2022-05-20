import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:ohzu/src/models/detail_model.dart';
import 'package:ohzu/src/models/search_model.dart';
import 'package:ohzu/src/models/todays_cocktail_model.dart';

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
}
