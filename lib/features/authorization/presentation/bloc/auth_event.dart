part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthInitialEvent extends AuthEvent {}

class AuthLoginWithGoogleOrAppleEvent extends AuthEvent {
  final AuthType authType;

  AuthLoginWithGoogleOrAppleEvent({required this.authType});
}

class AuthLoginWithPhoneEvent extends AuthEvent {
  final String phoneNumber;

  AuthLoginWithPhoneEvent({required this.phoneNumber});
}

class AuthSendPhoneCodeEvent extends AuthEvent {
  final String phoneNumber;

  AuthSendPhoneCodeEvent({required this.phoneNumber});
}

class AuthCheckPhoneCodeEvent extends AuthEvent {
  final String code;

  AuthCheckPhoneCodeEvent({required this.code});
}

class AuthTryAgainEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
