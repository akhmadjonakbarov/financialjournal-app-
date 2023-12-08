part of 'user_bloc.dart';

@immutable
class UserEvent {}

class GetUserEvent extends UserEvent {}

class SetUserEvent extends UserEvent {
  final UserModel user;
  SetUserEvent({required this.user});
}
