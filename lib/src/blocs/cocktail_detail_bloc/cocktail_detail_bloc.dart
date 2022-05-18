import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/detail_model.dart';
import '../../resources/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cocktail_detail_event.dart';
part 'cocktail_detail_state.dart';

class CocktailDetailBloc
    extends Bloc<CocktailDetailEvent, CocktailDetailState> {
  final Repository _cocktailDetailRepository = Repository();

  // CocktailDetailBloc(this._cocktailDetailRepository, int id)
  //     : super(CocktailDetailLoadingState()) {
  //   on<LoadCocktailDetailEvent>((event, emit) async {
  //     emit(CocktailDetailLoadingState());
  //     try {
  //       final cocktailDetail = await _cocktailDetailRepository.fetchDetail(id);
  //       emit(CocktailDetailLoadedState(cocktailDetail));
  //     } catch (e) {
  //       emit(CocktailDetailErrorState(e.toString()));
  //     }
  //   });
  // }

  CocktailDetailBloc(int id) : super(CocktailDetailLoadingState()) {
    on<LoadCocktailDetailEvent>((event, emit) async {
      emit(CocktailDetailLoadingState());
      try {
        final cocktailDetail = await _cocktailDetailRepository.fetchDetail(id);
        emit(CocktailDetailLoadedState(cocktailDetail));
      } catch (e) {
        emit(CocktailDetailErrorState(e.toString()));
      }
    });
  }
}
