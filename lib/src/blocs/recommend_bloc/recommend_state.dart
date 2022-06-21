part of 'recommend_bloc.dart';

@immutable
abstract class RecommendState extends Equatable {}

/* Bloc (Now) Loading State */
class RecommendLoadingState extends RecommendState {
  @override
  List<Object?> get props => [];
}

/* Bloc (Successfully) Loaded State */
class RecommendLoadedState extends RecommendState {
  final RecommendModel recommend;

  RecommendLoadedState(this.recommend);

  @override
  List<Object?> get props => [recommend];
}

/* Bloc ErrorState */
class RecommendErrorState extends RecommendState {
  final String error;

  RecommendErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
