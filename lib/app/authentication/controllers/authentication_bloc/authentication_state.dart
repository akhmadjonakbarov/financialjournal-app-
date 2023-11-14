part of 'authentication_bloc.dart';

@immutable
class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {}

class UnAuthenticatedState extends AuthenticationState {}

class AuthenticationErrorState extends AuthenticationState {
  final String errorMessage;
  AuthenticationErrorState({required this.errorMessage});
}
