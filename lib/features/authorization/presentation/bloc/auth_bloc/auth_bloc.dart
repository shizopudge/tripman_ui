import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enums/auth_type.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInititalState()) {
    on<AuthLoginEvent>(_authLoginEvent);
    on<AuthTryAgainEvent>(_authTryAgainEvent);
  }

  FutureOr<void> _authLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.authType == AuthType.phone) {
      await Future.delayed(
        const Duration(
          milliseconds: 2000,
        ),
      );
      emit(AuthAuthorizedState());
    } else if (event.authType == AuthType.google) {
      await Future.delayed(
        const Duration(
          milliseconds: 2000,
        ),
      );
      emit(
        AuthErrorState(
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
        AuthErrorState(
          message: 'Приложение не удалось загрузить',
        ),
      );
    }
  }

  FutureOr<void> _authTryAgainEvent(
      AuthTryAgainEvent event, Emitter<AuthState> emit) {
    emit(AuthInititalState());
  }
}
