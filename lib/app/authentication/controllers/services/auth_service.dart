// ignore_for_file: unused_catch_clause

import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../utils/app_storage.dart';
import '../../../../utils/dio/dio_settings.dart';
import '../../../../utils/service_locator.dart/service_locator.dart';
import '../../models/user_model.dart';

abstract class AuthServices {
  Future<UserModel> login({
    required String username,
    required String password,
  });
  Future<UserModel> register({
    required String name,
    required String username,
    required String password,
  });
  Future<UserModel> profile();
}

class AppAuthService implements AuthServices {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  final _registerURL = "http://127.0.0.1:8000/api/login?phone=332012347&password=123456";

  @override
  Future<UserModel> register({
    required String name,
    required String username,
    required String password,
  }) async {
    UserModel? user;

    Map registerData = {
      'name': name,
      'username': username,
      'password': password,
    };

    try {
      Response response = await _dio.post(
        _registerURL,
        data: registerData,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> resData = response.data as Map<String, dynamic>;
        user = UserModel(
          id: resData['data']['user']['id'],
          name: resData['data']['user']['name'],
          accessToken: resData['data']['access_token'],
          refreshToken: 'null',
          phoneNumber: resData['data']['user']['phone'],
        );
      } else {}
    } on DioException {
      rethrow;
    }
    return user!;
  }

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    UserModel? user;
    final loginURL = "/api/login?phone=$username&password=$password";
    try {
      Response response = await _dio.post(
        loginURL,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resData = response.data as Map<String, dynamic>;
        user = UserModel(
          id: resData['data']['user']['id'],
          name: resData['data']['user']['name'],
          accessToken: resData['data']['access_token'],
          refreshToken: resData['data']['refresh_token'],
          phoneNumber: resData['data']['user']['phone'],
        );
      } else if (response.statusCode == 404) {
        throw "username or password is uncorrect";
      }
    } on DioException catch (error) {
      if (error.response!.statusCode == 401) {
        throw "username or password is uncorrect";
      }
      rethrow;
    }
    return user!;
  }

  @override
  Future<UserModel> profile() async {
    UserModel? user;
    const String profileURL = "/api/profile/";
    SecureAppStorage appStorage = SecureAppStorage();
    String? accessToken = await appStorage.getAccessToken();
    String? refreshToken = await appStorage.getRefreshToken();

    Response response = await _dio.get(
      profileURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['data'] != null) {
        Map<String, dynamic> profileData = response.data as Map<String, dynamic>;
        user = UserModel(
          id: profileData['data']['user']['id'],
          name: profileData['data']['user']['name'],
          accessToken: '',
          refreshToken: '',
          phoneNumber: profileData['data']['user']['phone'],
        );
      }
    } else if (response.statusCode == 401) {
      await getAccessToken(refreshToken!);
      return await profile();
    }
    return user!;
  }

  Future<dynamic> getAccessToken(String refreshToken) async {
    SecureAppStorage appStorage = SecureAppStorage();
    try {
      const accessTokenURL = "/api/refreshToken";
      Response response = await _dio.post(
        accessTokenURL,
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        String accessToken = response.data['data']['access_token'];
        await appStorage.writeAccessToken(token: accessToken);
      }
    } catch (e) {
      rethrow;
    }

    log("getAccessToken");
  }
}
