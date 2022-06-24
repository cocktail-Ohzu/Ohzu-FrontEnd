import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ohzu/src/models/ingredient_model.dart';
import 'package:ohzu/src/resources/repository.dart';

part 'ingredient_event.dart';
part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final Repository _recommendRepository = Repository();

  IngredientBloc() : super(IngredientLoadingState()) {
    on<LoadIngredientEvent>((event, emit) async {
      emit(IngredientLoadingState());
      try {
        final recommend = await _recommendRepository.fetchIngredientItem();
        emit(IngredientLoadedState(recommend));
      } catch (e) {
        emit(IngredientErrorState(e.toString()));
      }
    });
  }
}
