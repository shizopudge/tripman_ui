part of 'auth_bloc.dart';

@immutable
class AuthState {}

@immutable
class AuthActionState extends AuthState {}

class AuthInititalState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState({required this.message});
}

class AuthAuthorizedState extends AuthActionState {}

class AuthCodeConfirmedState extends AuthActionState {}

class AuthCodeErrorState extends AuthActionState {}
