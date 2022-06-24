import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ohzu/src/models/recommend_model.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/resources/repository.dart';

part 'recommend_event.dart';
part 'recommend_state.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  final Repository _recommendRepository = Repository();

  RecommendBloc(List<List<IngredientElement>> itemList)
      : super(RecommendLoadingState()) {
    on<LoadRecommendEvent>((event, emit) async {
      emit(RecommendLoadingState());
      try {
        final recommend =
            await _recommendRepository.fetchRecommendItem(itemList);
        emit(RecommendLoadedState(recommend));
      } catch (e) {
        emit(RecommendErrorState(e.toString()));
      }
    });
  }
}
