import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ohzu/src/models/search_model.dart';
import 'package:ohzu/src/resources/repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Repository _searchRepository = Repository();

  SearchBloc() : super(SearchLoadingState()) {
    on<LoadSearchEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        final search = await _searchRepository.fetchSearchItem();
        emit(SearchLoadedState(search));
      } catch (e) {
        emit(SearchErrorState(e.toString()));
      }
    });
  }
}
