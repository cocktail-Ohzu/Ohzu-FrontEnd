part of 'cocktail_detail_bloc.dart';

@immutable
abstract class CocktailDetailState extends Equatable {}

/* Bloc (Now) Loading State */
class CocktailDetailLoadingState extends CocktailDetailState {
  @override
  List<Object?> get props => [];
}

/* Bloc (Successfully) Loaded State */
class CocktailDetailLoadedState extends CocktailDetailState {
  final DetailModel cocktailDetail;

  CocktailDetailLoadedState(this.cocktailDetail);

  @override
  List<Object?> get props => [cocktailDetail];
}

/* Bloc ErrorState */
class CocktailDetailErrorState extends CocktailDetailState {
  final String error;

  CocktailDetailErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
