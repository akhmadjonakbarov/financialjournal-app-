import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../../authentication/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState(user: null)) {
    on<SetUserEvent>(
      (event, emit) {
        emit(state.copyWith(user: event.user));
      },
    );
  }
}
