part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeLoaded extends HomeState {
  final ImageSlider imageSlider;
  HomeLoaded(this.imageSlider);
}
final class HomeError extends HomeState {}
