part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {}

/* Bloc (Now) Loading State */
class SearchLoadingState extends SearchState {
  @override
  List<Object?> get props => [];
}

/* Bloc (Successfully) Loaded State */
class SearchLoadedState extends SearchState {
  final List<SearchModel> search;

  SearchLoadedState(this.search);

  @override
  List<Object?> get props => [search];
}

/* Bloc ErrorState */
class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
