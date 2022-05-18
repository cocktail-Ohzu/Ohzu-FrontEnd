part of 'cocktail_detail_bloc.dart';

@immutable
abstract class CocktailDetailEvent extends Equatable {
  const CocktailDetailEvent();
}

class LoadCocktailDetailEvent extends CocktailDetailEvent {
  @override
  List<Object> get props => [];
}
