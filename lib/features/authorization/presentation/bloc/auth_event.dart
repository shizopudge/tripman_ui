part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final AuthType authType;

  AuthLoginEvent({required this.authType});
}

class AuthCheckPhoneCodeEvent extends AuthEvent {
  final String code;

  AuthCheckPhoneCodeEvent({required this.code});
}

class AuthTryAgainEvent extends AuthEvent {}
