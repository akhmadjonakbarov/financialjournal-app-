import 'app_storage.dart';

class GenerateAuth {
  final SecureAppStorage _appStorage = SecureAppStorage();

  Future<Map<String, dynamic>> auth() async {
    Map<String, dynamic> auth = {};
    try {
      bool hasToken = await _appStorage.hasToken();
      if (hasToken) {
        String? accessToken = await _appStorage.getAccessToken();
        auth = {
          'Authorization': 'Bearer $accessToken',
        };
        return auth;
      } else {
        return auth;
      }
    } catch (e) {
      rethrow;
    }
  }
}
