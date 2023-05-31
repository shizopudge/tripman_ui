import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/authorization_type.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInititalState()) {
    on<AuthorizationLoginEvent>(_authorizationLoginEvent);
    on<AuthorizationTryAgainEvent>(_authorizationTryAgainEvent);
  }

  FutureOr<void> _authorizationLoginEvent(
      AuthorizationLoginEvent event, Emitter<AuthorizationState> emit) async {
    emit(AuthorizationLoadingState());
    if (event.authorizationType == AuthorizationType.phone) {
      emit(AuthorizationLoginWithPhoneState());
      emit(AuthorizationInititalState());
    } else if (event.authorizationType == AuthorizationType.google) {
      await Future.delayed(
        const Duration(
          milliseconds: 2000,
        ),
      );
      emit(
        AuthorizationErrorState(
          message: 'Приложение не удалось загрузить',
        ),
      );
    } else {
      await Future.delayed(
        const Duration(
          milliseconds: 2000,
        ),
      );
      emit(
        AuthorizationErrorState(
          message: 'Приложение не удалось загрузить',
        ),
      );
    }
  }

  FutureOr<void> _authorizationTryAgainEvent(
      AuthorizationTryAgainEvent event, Emitter<AuthorizationState> emit) {
    emit(AuthorizationInititalState());
  }
}
