part of 'authentication_bloc.dart';

@immutable
class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {
  final Map<String, dynamic> loginData;
  LoginEvent({required this.loginData});
}

class RegisterEvent extends AuthenticationEvent {
  final Map<String, dynamic> registerData;
  RegisterEvent({required this.registerData});
}
