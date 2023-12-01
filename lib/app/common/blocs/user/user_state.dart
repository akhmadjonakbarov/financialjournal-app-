// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final FormzSubmissionStatus status;
  final UserModel? user;
  const UserState({this.status = FormzSubmissionStatus.initial, this.user});
  UserState copyWith({
    FormzSubmissionStatus? status,
    UserModel? user,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
