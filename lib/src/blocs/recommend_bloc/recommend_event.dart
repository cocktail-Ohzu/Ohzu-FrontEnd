part of 'recommend_bloc.dart';

@immutable
abstract class RecommendEvent extends Equatable {
  const RecommendEvent();
}

class LoadRecommendEvent extends RecommendEvent {
  @override
  List<Object> get props => [];
}
