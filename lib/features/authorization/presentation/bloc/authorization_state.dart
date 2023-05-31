part of 'authorization_bloc.dart';

@immutable
class AuthorizationState {}

@immutable
class AuthorizationActionState extends AuthorizationState {}

class AuthorizationInititalState extends AuthorizationState {}

class AuthorizationLoadingState extends AuthorizationState {}

class AuthorizationErrorState extends AuthorizationState {
  final String message;

  AuthorizationErrorState({required this.message});
}

class AuthorizationAuthorizedState extends AuthorizationActionState {}

class AuthorizationLoginWithPhoneState extends AuthorizationActionState {}
