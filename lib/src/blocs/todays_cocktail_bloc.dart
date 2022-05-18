import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/todays_cocktail_model.dart';

class TodaysCocktailBloc {
  final _repository = Repository();
  final _todaysCocktailFetcher = PublishSubject<TodaysCocktailModel>();

  Stream<TodaysCocktailModel> get allTodaysCocktail =>
      _todaysCocktailFetcher.stream;

  fetchTodaysCocktail() async {
    TodaysCocktailModel todaysCocktail =
        await _repository.fetchTodaysCocktail();
    _todaysCocktailFetcher.sink.add(todaysCocktail);
  }

  dispose() {
    _todaysCocktailFetcher.close();
  }
}

final todaysCocktailbloc = TodaysCocktailBloc();
