import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enums/auth_type.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInititalState()) {
    on<AuthLoginWithGoogleOrAppleEvent>(_authLoginWithGoogleOrAppleEvent);
    on<AuthLoginWithPhoneEvent>(_authLoginWithPhoneEvent);
    on<AuthSendPhoneCodeEvent>(_authSendPhoneCodeEvent);
    on<AuthCheckPhoneCodeEvent>(_authCheckPhoneCodeEvent);
    on<AuthTryAgainEvent>(_authTryAgainEvent);
  }

  FutureOr<void> _authLoginWithGoogleOrAppleEvent(
      AuthLoginWithGoogleOrAppleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.authType == AuthType.google) {
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

  FutureOr<void> _authLoginWithPhoneEvent(
      AuthLoginWithPhoneEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await Future.delayed(
      const Duration(
        milliseconds: 2000,
      ),
    );
    emit(AuthAuthorizedState());
  }

  FutureOr<void> _authSendPhoneCodeEvent(
      AuthSendPhoneCodeEvent event, Emitter<AuthState> emit) {
    if (event.phoneNumber.isNotEmpty) {
      debugPrint('Send verification code');
    }
  }

  FutureOr<void> _authCheckPhoneCodeEvent(
      AuthCheckPhoneCodeEvent event, Emitter<AuthState> emit) {
    const String validCode = '5555';
    if (event.code.isNotEmpty) {
      if (event.code.length == 4) {
        if (event.code == validCode) {
          emit(AuthPhoneCodeVerifiedState());
        } else {
          emit(AuthPhoneCodeErrorState());
        }
      } else {
        emit(AuthPhoneCodeInputState());
      }
    }
  }

  FutureOr<void> _authTryAgainEvent(
      AuthTryAgainEvent event, Emitter<AuthState> emit) {
    emit(AuthInititalState());
  }
}
