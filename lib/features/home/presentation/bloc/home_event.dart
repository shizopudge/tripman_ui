part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInititalEvent extends HomeEvent {}

class HomeGetTripsEvent extends HomeEvent {
  final String type;
  final bool isRefresh;
  final DateTimeRange? interval;

  HomeGetTripsEvent({
    required this.type,
    this.interval,
    this.isRefresh = false,
  });
}
