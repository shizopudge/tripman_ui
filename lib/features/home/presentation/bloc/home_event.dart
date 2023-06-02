part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInititalEvent extends HomeEvent {}

class HomeGetTripsEvent extends HomeEvent {
  final String type;
  final bool isRefresh;
  final DateTime? startDate;
  final DateTime? endDate;

  HomeGetTripsEvent({
    required this.type,
    this.startDate,
    this.endDate,
    required this.isRefresh,
  });
}
