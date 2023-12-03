import 'dart:developer';


import 'package:bloc/bloc.dart';
import 'package:financialjournal_app/utils/connectivity_service.dart';
import '../repository/auth_repository.dart';
import '../services/auth_service.dart';
import '../../../../utils/app_storage.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AppAuthRepository _appAuthRepository = AppAuthRepository(
    AppAuthService(),
  );
  final SecureAppStorage secureAppStorage = SecureAppStorage();
  final ConnectivityService _connectivityService = ConnectivityService();

  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AppStartEvent>(_appStarted);
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  _appStarted(
    AppStartEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    UserModel? user;
    emit(AuthenticatingState());
    bool isHasInternet = await _connectivityService.checkConnection();

    if (isHasInternet) {
      try {
        bool hasToken = await secureAppStorage.hasToken();
        if (hasToken) {
          user = await _appAuthRepository.profile();
          emit(AuthenticatedState(user: user));
        } else {
          emit(UnAuthenticatedState());
        }
        log("_appStart");
      } catch (e) {
        if (e.toString().contains("Token is invalid or expired")) {
          emit(UnAuthenticatedState());
        } else {
          emit(AuthenticationErrorState(errorMessage: e.toString()));
        }
      }
    } else {
      emit(AuthUnAvailableInternet());
    }
  }

  _login(LoginEvent event, Emitter<AuthenticationState> emit) async {
    UserModel user;
    try {
      emit(AuthenticatingState());
      user = await _appAuthRepository.login(
        username: event.username,
        password: event.password,
      );
      await secureAppStorage.writeAccessToken(
        token: user.accessToken,
      );
      await secureAppStorage.writeRefreshToken(
        token: user.refreshToken,
      );
      emit(AuthenticatedState(
        user: user,
      ));
    } catch (e) {
      emit(AuthenticationErrorState(
        errorMessage: e.toString(),
      ));
    }
  }

  _register(RegisterEvent event, Emitter<AuthenticationState> emit) async {
    UserModel user;
    try {
      emit(AuthenticatingState());
      user = await _appAuthRepository.register(
        name: event.name,
        username: event.username,
        password: event.password,
      );
      emit(AuthenticatedState(
        user: user,
      ));
    } catch (e) {
      emit(AuthenticationErrorState(
        errorMessage: e.toString(),
      ));
    }
  }
}
