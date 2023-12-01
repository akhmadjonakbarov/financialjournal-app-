// ignore_for_file: prefer_final_fields

import 'package:financialjournal_app/app/authentication/controllers/services/auth_service.dart';
import 'package:financialjournal_app/app/authentication/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> register({
    required String name,
    required String username,
    required String password,
  });
  Future<UserModel> login({
    required String username,
    required String password,
  });
  Future<UserModel> profile();
}

class AppAuthRepository implements AuthRepository {
  AppAuthService _appAuthService = AppAuthService();
  AppAuthRepository(this._appAuthService);
  @override
  Future<UserModel> register({
    required String name,
    required String username,
    required String password,
  }) async {
    return await _appAuthService.register(
      name: name,
      username: username,
      password: password,
    );
  }

  @override
  Future<UserModel> login({required String username, required String password}) async {
    return await _appAuthService.login(
      username: username,
      password: password,
    );
  }

  @override
  Future<UserModel> profile() async {
    return await _appAuthService.profile();
  }
}
