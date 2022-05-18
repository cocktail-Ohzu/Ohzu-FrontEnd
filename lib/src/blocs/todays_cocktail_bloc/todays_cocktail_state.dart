part of 'todays_cocktail_bloc.dart';

@immutable
abstract class TodaysCocktailState extends Equatable {}

/* Bloc (Now) Loading State */
class TodaysCocktailLoadingState extends TodaysCocktailState {
  @override
  List<Object?> get props => [];
}

/* Bloc (Successfully) Loaded State */
class TodaysCocktailLoadedState extends TodaysCocktailState {
  final TodaysCocktailModel todaysCocktail;

  TodaysCocktailLoadedState(this.todaysCocktail);

  @override
  List<Object?> get props => [todaysCocktail];
}

/* Bloc ErrorState */
class TodaysCocktailErrorState extends TodaysCocktailState {
  final String error;

  TodaysCocktailErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
