import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/todays_cocktail_model.dart';
import '../models/detail_model.dart';

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
}
