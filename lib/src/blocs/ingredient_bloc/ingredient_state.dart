part of 'ingredient_bloc.dart';

@immutable
abstract class IngredientState extends Equatable {}

/* Bloc (Now) Loading State */
class IngredientLoadingState extends IngredientState {
  @override
  List<Object?> get props => [];
}

/* Bloc (Successfully) Loaded State */
class IngredientLoadedState extends IngredientState {
  final IngredientModel ingredient;

  IngredientLoadedState(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

/* Bloc ErrorState */
class IngredientErrorState extends IngredientState {
  final String error;

  IngredientErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
