import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureAppStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'accessToken');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future writeAccessToken({required String token}) async {
    await storage.write(
      key: 'accessToken',
      value: token,
    );
    log("AccessToken was written");
  }

  Future writeRefreshToken({required String token}) async {
    await storage.write(
      key: 'refreshToken',
      value: token,
    );
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'refreshToken');
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'accessToken');
    storage.delete(key: 'refreshToken');
    storage.deleteAll();
  }
}
