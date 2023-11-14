import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  _login(LoginEvent event, Emitter<AuthenticationState> emit) async {
    try {
      // login code
    } catch (e) {
      emit(AuthenticationErrorState(
        errorMessage: e.toString(),
      ));
    }
  }

  _register(RegisterEvent event, Emitter<AuthenticationState> emit) async {
    try {
      // register code
    } catch (e) {
      emit(AuthenticationErrorState(
        errorMessage: e.toString(),
      ));
    }
  }
}
