import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/entities/trip.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInititalEvent>(_homeInititalEvent);
    on<HomeGetTripsEvent>(_homeGetTripsEvent);
  }

  FutureOr<void> _homeInititalEvent(
      HomeInititalEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(milliseconds: 2000));
    emit(HomeLoadedState(trips: trips));
  }

  FutureOr<void> _homeGetTripsEvent(
      HomeGetTripsEvent event, Emitter<HomeState> emit) async {
    if (event.isRefresh) {
      emit(HomeLoadingState(isRefreshing: true));
    } else {
      emit(HomeLoadingState());
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    if (event.type == tripTypes.last.title) {
      emit(HomeErrorState(message: 'Сообщение об ошибке.'));
    } else if (event.type == tripTypes[2].title) {
      emit(HomeLoadedState(trips: const []));
    } else {
      emit(HomeLoadedState(trips: trips));
    }
  }
}
