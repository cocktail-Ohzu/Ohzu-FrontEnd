part of 'todays_cocktail_bloc.dart';

@immutable
abstract class TodaysCocktailEvent extends Equatable {
  const TodaysCocktailEvent();
}

class LoadTodaysCocktailEvent extends TodaysCocktailEvent {
  @override
  List<Object> get props => [];
}
