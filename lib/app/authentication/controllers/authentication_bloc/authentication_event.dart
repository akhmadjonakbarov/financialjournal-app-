part of 'authentication_bloc.dart';

@immutable
class AuthenticationEvent {}

class AppStartEvent extends AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}

class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String username;
  final String password;

  RegisterEvent(
      {required this.name, required this.username, required this.password});
}
