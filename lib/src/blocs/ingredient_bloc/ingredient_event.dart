part of 'ingredient_bloc.dart';

@immutable
abstract class IngredientEvent extends Equatable {
  const IngredientEvent();
}

class LoadIngredientEvent extends IngredientEvent {
  @override
  List<Object> get props => [];
}
