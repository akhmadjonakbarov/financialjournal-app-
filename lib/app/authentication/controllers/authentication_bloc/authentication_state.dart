part of 'authentication_bloc.dart';

@immutable
class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticatingState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final UserModel user;

  AuthenticatedState({required this.user});
}

class UnAuthenticatedState extends AuthenticationState {}

class AuthUnAvailableInternet extends AuthenticationState {}

class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;

  AuthenticationErrorState({required this.errorMessage});
}

class LoginOrPasswordIncorrectState extends AuthenticationState {}
