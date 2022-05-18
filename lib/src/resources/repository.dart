import 'dart:async';
import 'package:ohzu/src/models/detail_model.dart';
import 'package:ohzu/src/resources/ohzu_api_provider.dart';

import 'ohzu_api_provider.dart';
import '../models/todays_cocktail_model.dart';

class Repository {
  final ohzuApiProvider = OhzuApiProvider();

  Future<TodaysCocktailModel> fetchTodaysCocktail() =>
      ohzuApiProvider.fetchTodaysCocktail();

  Future<DetailModel> fetchDetail(int cocktailId) =>
      ohzuApiProvider.fetchDetail(cocktailId);
}
