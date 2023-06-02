part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {
  final bool isRefreshing;

  HomeLoadingState({this.isRefreshing = false});
}

class HomeLoadedState extends HomeState {
  final List<Trip> trips;

  HomeLoadedState({required this.trips});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}
