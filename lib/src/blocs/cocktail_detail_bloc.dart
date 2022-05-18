import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/detail_model.dart';
import '../resources/repository.dart';

class CocktailDetailBloc {
  final _repository = Repository();
  final _detailId = PublishSubject<int>();
  final _details = BehaviorSubject<DetailModel>();

  Function(int) get fetchDetailsById => _detailId.sink.add;
  Stream<DetailModel> get cocktailDetails => _details.stream;

  CocktailDetailBloc() {
    print(1);
    _detailId.stream.transform(_itemTransformer()).pipe(_details);
    print(2);
  }

  dispose() async {
    _detailId.close();
    await _details.drain();
    _details.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<DetailModel>> cache, int id, int index) {
      print(index);
      cache[id] = _repository.fetchDetail(id);
      return cache;
    }, <int, Future<DetailModel>>{});
  }
}
