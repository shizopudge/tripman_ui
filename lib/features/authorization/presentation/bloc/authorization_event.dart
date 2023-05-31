part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationEvent {}

class AuthorizationInitialEvent extends AuthorizationEvent {}

class AuthorizationLoginEvent extends AuthorizationEvent {
  final AuthorizationType authorizationType;

  AuthorizationLoginEvent({required this.authorizationType});
}

class AuthorizationTryAgainEvent extends AuthorizationEvent {}
