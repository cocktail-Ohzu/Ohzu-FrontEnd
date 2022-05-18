import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/todays_cocktail_model.dart';
import '../../resources/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'todays_cocktail_event.dart';
part 'todays_cocktail_state.dart';

class TodaysCocktailBloc
    extends Bloc<TodaysCocktailEvent, TodaysCocktailState> {
  final Repository _todaysCocktailRepository = Repository();

  TodaysCocktailBloc() : super(TodaysCocktailLoadingState()) {
    on<LoadTodaysCocktailEvent>((event, emit) async {
      emit(TodaysCocktailLoadingState());
      try {
        final todaysCocktail =
            await _todaysCocktailRepository.fetchTodaysCocktail();
        emit(TodaysCocktailLoadedState(todaysCocktail));
      } catch (e) {
        emit(TodaysCocktailErrorState(e.toString()));
      }
    });
  }
}

final todaysCocktailbloc = TodaysCocktailBloc();
